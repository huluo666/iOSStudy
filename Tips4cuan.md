# IOS tips4cuan

**此内容未经过验证，纯属个人总结**
## 索引
- [retain/release](#retain_release)
- [@class](#@class)
- [category](#category)
- [protocol](#protocol)
- [block](#block)



<h3 id="retain_release"> retain/release </h3>
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

- 创建对象时尽量使用autorelease

	```

<h3 id="@class"> @class </h3>

- @class 用于.h文件种，声明一个类
- \#import用于.m文件，拷贝整个.文件

---

<h3 id="category"> category </h3>

- 类别只能扩展方法，不能添加实例变量
- 类别声明可以和需要扩展的类写在同一个.h文件中，写在原声明后面，实现文件同理

---

<h3 id="protocol"> protocol </h3>

- 与java的接口类似
- @protocol于@class有一致的用法，提前声明，实现时，在.h文件中声明，在.m中导入

---

<h3 id="block"> block </h3>

- 类似于java的匿名内部类

	```
	int (^sum)(int, int) = ^(int a, int b)
	{
		return a + b;
	}
	
	int sum = sum(10, 2);
	NSLog(@"%i", sum); 
	```
	
	```
	typedef int (^mySum)(int, int);
	void test()
	{
		mySum sum = ^(int a, int b)
		{
			return a + b;
		}
		NSLog(@"%i"， sum(10, 2));
	}
	```
- block可以访问外面定义的变量
- 如果外面的变量用__block声明，就可以在block内部修改
- block与指针函数的区别于联系

	```
	// 定义了Sum这种Block类型
    typedef int (^Sum) (int, int);
    
    // 定义了sump这种指针类型，这种指针是指向函数的
    typedef int (*Sump) (int, int);
    
    // 定义了一个block变量
    Sum sum1 = ^(int a, int b) {
        return a + b;
    };
    
    int c = sum1(10, 10);
    NSLog(@"%i", c);
    
    // 定义一个指针变量p指向sum函数
    Sump p = sum;
    // c = (*p)(9, 8);
    c = p(9, 8);
    NSLog(@"%i", c);
	```













