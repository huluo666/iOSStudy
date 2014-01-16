# IOS tips4cuan

**此内容未经过验证，纯属个人总结**

## OC内存管理

### 内存管理原则
- 

### retain/release
- 消息涉及到对成员变量操作的时候考虑retain/copy
- 哪些方法对成员变量操作？init、setter、类似setter
- setter/init与dealloc相对应。对象初始化(创建)便retain，对象不需要的时候(小辉)就release
- 有一个+1(retain/alloc/new/copy/mutableCopy)就对应一个-1(release)
- 为什么需要retain/copy？因为当前消息中用到的成员变量在其他方法种也可能需要调用，如果在当前方法中release了，那么-1就可能销毁数据了，其他方法种就出现了访问野指针。所以持有对象+1，对其他方法种不会照成干扰

```
test()
{
	Book *book = [[Book alloc] init];
	student.book = book; // 如果setter没有retain
	[book release];
}

test2(Student *student)
{
	NSLog(@"%@", student.book); // 这里访问的book就是getter里面的book
								  // 而book已经被销毁
}

test3()
{
	test();
	test2();
}

```
### @class
- @class 用于.h文件种，声明一个类
- \#import用于.m文件，拷贝整个.文件