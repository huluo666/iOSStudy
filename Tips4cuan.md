# IOS tips4cuan

**此内容未经过验证，纯属个人总结**

## OC内存管理

### 内存管理原则
- 

### retain/release
- `消息涉及到对成员变量操作的时候考虑retain/copy`
- 哪些方法对成员变量操作？init、setter、类似setter
- setter/init与dealloc相对应。对象初始化(创建)便retain，对象不需要的时候(小辉)就release
- 有一个+1(retain/alloc/new/copy/mutableCopy)就对应一个-1(release)
- 为什么需要retain/copy？因为当前消息中用到的成员变量在其他方法种也可能需要调用，如果在当前方法中release了，那么-1就可能销毁数据了，其他方法种就出现了访问野指针。所以持有对象+1，对其他方法种不会照成干扰

```
void test(Student *stu) 
{
    Book *book = [[Book alloc] initWithPrice:3.5];

    stu.book = book; // 如果没有retain.等效于_book = book;

    [book release];
}

void test1(Student *stu) 
{
    [stu readBook];
}

int main(int argc, const char * argv[])
{
	Student *stu = [[Student alloc] initWithAge:10];

	test(stu); //book:0

	test1(stu); // 调用book，野指针错误

	[stu release];

    return 0;
}

Student.m
- (void) readBook
{
	NSLog(@"read %@", _book)
} 

```

- 创建对象时尽量使用autorelease	- 创建临时对象时,尽量同时在同一行中 autorelease 掉,而非使用单独的 release 语句	- 虽然这样会稍微有点慢,但这样可以阻止因为提前 return 或其他意外情况导致的内存泄露。通盘来看这是值得的。如:
		```	// 避免这样使用(除非有性能的考虑)	MyController* controller = [[MyController alloc] init];	// ... 这里的代码可能会提前return ...	[controller release];	// 这样更好	MyController* controller = [[[MyController alloc] init] autorelease];
	```
### @class
- @class 用于.h文件种，声明一个类
- \#import用于.m文件，拷贝整个.文件
