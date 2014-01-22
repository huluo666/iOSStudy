# IOS tips4cuan

**此内容未经过验证，纯属个人总结**
## 索引
- [代码规范](#nameMessage)
- [retain/release](#retain_release)
- [@class](#@class)
- [category](#category)
- [protocol](#protocol)
- [block](#block)

- [UIView](#UIView)


<h3 id="nameMessage"> 代码规范 </h3>

**变量**

变量的命令应尽量做到自描述。除了在for()循环语句中，单字母的变量应该避免使用（如i,j,k等）。一般循环语句的当前对象的命名前缀包括“one”、“a/an”。对于简单的单个对象使用“item”命名.

尽量的使用属性而非实例变量。除了在初始化方法（init，initWithCoder：等）、dealloc方法以及自定义setter与getter方法中访问属性合成的实例变量，其他的情况使用属性进行访问。

---

**命名**

对于NSString、NSArray、NSNumber或BOOL类型，变量的命名一般不需要表明其类型。

如果变量不是以上基本常用类型，则变量的命名就应该反映出自身的类型。但有时仅需要某些类的一个实例的情况下，那么只需要基于类名进行命名。

大部分情况下，NSArray或NSSet类型的变量只需要使用单词复数形式（比如mailboxes），不必在命名中包含“mutable”。如果复数变量不是NSArray或NSSet类型，则需要指定其类型。

---

**init与dealloc**

dealloc方法应该被放置在实现方法的顶部，直接在@synthesize或@dynamic语句之后。init方法应该被放置在dealloc方法的下面。

---

**字面值**

对于NSString，NSDictionary，NSArray和NSNumber类，当需要创建这些类的不可变实例时，应该使用这些类的字面值表示形式。使用字面值表示的时候nil不需要传入NSArray和NSDictionary中作为字面值。这种语法兼容老的iOS版本，因此可以在iOS5或者更老的版本中使用它。

良好的风格：

	NSArray *names = @[@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul"];
	
	NSDictionary *productManagers = @{@"iPhone" : @"Kate", @"iPad" : @"Kamal", @"Mobile Web" : @"Bill"};
	
	NSNumber *shouldUseLiterals = @YES;
	
	NSNumber *buildingZIPCode = @10018;

 
不良的风格：


	NSArray *names = [NSArray arrayWithObjects:@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul", nil];
	
	NSDictionary *productManagers = [NSDictionary dictionaryWithObjectsAndKeys: @"Kate", @"iPhone", @"Kamal", @"iPad", @"Bill", @"Mobile Web", nil];
	
	NSNumber *shouldUseLiterals = [NSNumber numberWithBool:YES];
	
	NSNumber *buildingZIPCode = [NSNumber numberWithInteger:10018];

 
如非必要，避免使用特定类型的数字（相较于使用5.3f，应使用5.3）。

---

**方法命名**

一个方法的命名首先描述返回什么，接着是什么情况下被返回。方法签名中冒号的前面描述传入参数的类型。以下类方法和实例方法命名的格式语法：

	[object/class thing+condition];
	
	[object/class thing+input:input];
	
	[object/class thing+identifer:input];

Cocoa命名举例：

	realPath    = [path     stringByExpandingTildeInPath];
	
	fullString  = [string   stringByAppendingString:@"Extra Text"];
	
	object      = [array    objectAtIndex:3];
	
	// 类方法
	
	newString   = [NSString stringWithFormat:@"%f",1.5];
	
	newArray    = [NSArray  arrayWithObject:newString];


良好的自定义方法命名风格：

	recipients  = [email    recipientsSortedByLastName];
	
	newEmail    = [CDCEmail emailWithSubjectLine:@"Extra Text"];
	
	emails      = [mailbox  messagesReceivedAfterDate:yesterdayDate];

当需要获取对象值的另一种类型的时候，方法命名的格式语法如下：


	[object adjective+thing];
	
	[object adjective+thing+condition];
	
	[object adjective+thing+input:input];

 
良好的自定义方法命名风格：


	capitalized = [name    capitalizedString];
	
	rate        = [number  floatValue];
	
	newString   = [string  decomposedStringWithCanonicalMapping];
	
	subarray    = [array   subarrayWithRange:segment];

方法签名尽量做到含义明确。

---

<h3 id="retain_release"> retain/release </h3>
- `消息涉及到对成员变量操作的时候考虑retain/copy`
- 哪些方法对成员变量操作？init、setter、类似setter
- setter/init与dealloc相对应。对象初始化(创建)便retain，对象不需要的时候(小辉)就release
- 有一个+1(retain/alloc/new/copy/mutableCopy)就对应一个-1(release)
- 为什么需要retain/copy？因为当前消息中用到的成员变量在其他方法种也可能需要调用，如果在当前方法中release了，那么-1就可能销毁数据了，其他方法种就出现了访问野指针。所以持有对象+1，对其他方法种不会照成干扰

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
					
	

- 创建对象时尽量使用autorelease
	- 创建临时对象时,尽量同时在同一行中 autorelease 掉,而非使用单独的 release 语句
	- 虽然这样会稍微有点慢,但这样可以阻止因为提前 return 或其他意外情况导致的内存泄露。通盘来看这是值得的。如:
					// 避免这样使用(除非有性能的考虑)			MyController* controller = [[MyController alloc] init];			// ... 这里的代码可能会提前return ...			[controller release];			// 这样更好			MyController* controller = [[[MyController alloc] init] autorelease];
		---

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
	
	int (^sum)(int, int) = ^(int a, int b)
	{
		return a + b;
	}
	
	int sum = sum(10, 2);
	NSLog(@"%i", sum); 

	typedef int (^mySum)(int, int);
	void test()
	{
		mySum sum = ^(int a, int b)
		{
			return a + b;
		}
		NSLog(@"%i"， sum(10, 2));
	}
	
- block可以访问外面定义的变量
- 如果外面的变量用__block声明，就可以在block内部修改
- block与指针函数的区别于联系

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

---

<h3 id="NSString"> NSString </h3>

- 创建常量字符串

		NSString *aString = @"This is a String";
	
- 创建空字符串

		NSString *aString = [[String alloc] init];
		aString = @"This is a String";
		
- 提升速度的方法

		NSString *aString = [[NSString alloc] initWithString:@"This is a String"];
		
- 其他方法

		-(id)initWithFormat:(NSString *)format // 便利构造器
		-(id)initWithData:(NSData *) encoding:(NSStringEncoding) encoding;
		-(id)initWithCString(const char *)cString encoding:(NSStringEncoding)encoding; // 通过一个c字符串得到一个新字符串


<h3 id="UIView"> UIView </h3>

**UIView常见属性以及含义**
	
	- frame:  			相对于父视图的位置和大小(CGRect)
	- bounds: 			相对于自己的的位置和大小(CGRect)
	- center:			相对于父视图自己的中心点
	- transform 		变换属性(CGAffineTransform)
	- superview		父视图
	- subviews			子视图
	- window			当前view所在的window
	- backgroundColor	背景色(UIColor)
	- alpha				透明度(CGFloat)
	- hidden			是否隐藏
	- userInteractionEnabled	是否开启交互
	- tag				区分标识
	- layer				视图层(CALayer)
	
	- 屏幕上能够看见的都是UIView
	- 每一个UIView都是容器
	- IBAction === void 能让方法显示到storyboard文件的右键列表
	- IButlet能够让属性显示到storyboard的右键列表
	- bounds的x,y永远为0(以自身左上角为原点)，frame的x,y以父视图的左上角为原点

**UIView的常用方法**

	- (void)removeFromSuperview;// 从父视图中移除
	- (void)addSubview:(UIView *)view;// 添加一个子视图
	- (BOOL)isDescendantOgView(UIView *)view;// 将某个子视图移到上方显示
	- (UIView *)viewWithTag:(NSInteger)view;// 取到指定tag值的view  
