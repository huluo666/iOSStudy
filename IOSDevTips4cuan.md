# IOS tips4cuan

**此内容未经过验证，纯属个人总结**
## 索引
- [代码规范](#nameMessage)
- [retain/release](#retain_release)
- [@class](#@class)
- [category](#category)
- [protocol](#protocol)
- [block](#block)
- [OC数据类型](#OCDataType)
- [NSString](#NSString)
- [NSArray](#NSArray)
- [NSDictionary](#NSDictionary)
- [NSSet](#NSSet)
- [UIView](#UIView)
- [UIButton(按钮)](#UIButton)
- [UILabel(标签)](#UILabel)
- [UITextField(文本域)）](#UITextField)
- [UISwitch(开关)](#UISwitch)
- [UISlider(滑条)](#UISlider)
- [UIProgressView(进度条)](#UIProgressView)
- [UISegmentedControl(分段控件)](#UISegmentedControl)
- [UIActivityIndicatorView(进度指示器/菊花)](#UIActivityIndicatorView)
- [UIViewController](#UIViewController)

<h3 id="nameMessage"> 代码规范 </h3>

**变量**

- 变量的命令应尽量做到自描述。除了在for()循环语句中，单字母的变量应该避免使用（如i,j,k等）。一般循环语句的当前对象的命名前缀包括“one”、“a/an”。对于简单的单个对象使用“item”命名.

- 尽量的使用属性而非实例变量。除了在初始化方法（init，initWithCoder：等）、dealloc方法以及自定义setter与getter方法中访问属性合成的实例变量，其他的情况使用属性进行访问。

---

**命名**

- 对于NSString、NSArray、NSNumber或BOOL类型，变量的命名一般不需要表明其类型。

- 如果变量不是以上基本常用类型，则变量的命名就应该反映出自身的类型。但有时仅需要某些类的一个实例的情况下，那么只需要基于类名进行命名。

- 大部分情况下，NSArray或NSSet类型的变量只需要使用单词复数形式（比如mailboxes），不必在命名中包含“mutable”。如果复数变量不是NSArray或NSSet类型，则需要指定其类型。

---

**init与dealloc**

- dealloc方法应该被放置在实现方法的顶部，直接在@synthesize或@dynamic语句之后。init方法应该被放置在dealloc方法的下面。

---

**字面值**

- 对于NSString，NSDictionary，NSArray和NSNumber类，当需要创建这些类的不可变实例时，应该使用这些类的字面值表示形式。使用字面值表示的时候nil不需要传入NSArray和NSDictionary中作为字面值。这种语法兼容老的iOS版本，因此可以在iOS5或者更老的版本中使用它。

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

- 一个方法的命名首先描述返回什么，接着是什么情况下被返回。方法签名中冒号的前面描述传入参数的类型。以下类方法和实例方法命名的格式语法：

		[object/class thing+condition];
		
		[object/class thing+input:input];
		
		[object/class thing+identifer:input];

- Cocoa命名举例：

		realPath    = [path     stringByExpandingTildeInPath];
		
		fullString  = [string   stringByAppendingString:@"Extra Text"];
		
		object      = [array    objectAtIndex:3];
		
		// 类方法
		
		newString   = [NSString stringWithFormat:@"%f",1.5];
		
		newArray    = [NSArray  arrayWithObject:newString];


- 良好的自定义方法命名风格：

		recipients  = [email    recipientsSortedByLastName];
		
		newEmail    = [CDCEmail emailWithSubjectLine:@"Extra Text"];
		
		emails      = [mailbox  messagesReceivedAfterDate:yesterdayDate];

- 当需要获取对象值的另一种类型的时候，方法命名的格式语法如下：


		[object adjective+thing];
		
		[object adjective+thing+condition];
		
		[object adjective+thing+input:input];

 
- 良好的自定义方法命名风格：


		capitalized = [name    capitalizedString];
		
		rate        = [number  floatValue];
		
		newString   = [string  decomposedStringWithCanonicalMapping];
		
		subarray    = [array   subarrayWithRange:segment];

- 方法签名尽量做到含义明确。

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

<h3 id="OCDataType"> OC数据类型 </h3>

- NSValue可以用来封装任意数据结构

		(NSValue *)valueWithBytes:(const void *)value objCType:(const char *)type;
		
- NSNumber类继承于NSValue，用来封装基本书数据类型，如，int, float等

		+ (NSNumber *)numberWithInt:(int)value;
		+ (NSNumber *)numberWithFloat:(float)value;
		+ (NSNumber *)numberWithChar:(char)value;
		+ (NSNumber *)numberWithBool:(BOOL)value;
		
- NSNull用来封装nil值

		+ (NSNull *)null;
		
- NSArray、NSSet和NSDictionary等容器只能存储对象，不能存储基本数据类型和结构体，也不能存储nil

- NSString、NSMutableString对字符串封装

- OC特殊数据类型：id, nil, SEL等 

---

<h3 id="NSString"> NSString </h3>

**NSString对象初始化**

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

**字符串长度获取**
		
- 字符串长度获取

		-(NSInteger)length;

**获取字符串的子串**

- 拼接字符串
		
		- (NSString *)stringByAppendingString:(NSString *)aString;
		- (NSString *)stringByAppendingFormat:(NSString *)format....

- 获取字符串的子串

		- (NSString *)substringFromIndex:(NSUInteger)from;
		- (NSString *)substring;ToIndex:(NSUInteger)to;
		- (NSString *)substringWithRang:(NSRang)rang;

- 字符串是否包含别的字符串

		-(BOOL)hasPrefix:(NSString *)aString;
		-(BOOL)hasSuffix:(NSString *)aString;
		-(NSRang)rangeOfString:(NSString *)aString;

**字符串的比较**

- 是否相等

		-(BOOL)isEqualToString:(NSString *)str;
		
- 比较大小

		-(NSComparisonResult)compare:(NSString *)str;

- 转换大小写

		-(NSString *)uppercaseString;
		-(NSString *)lowercaseString;

**类型的转换**

	-(double)doubleValue;
	-(float)floatValue;
	-(int)intValue;
	-(NSInteger)integerValue;
	-(long long)longlongValue;
	-(BOOL)boolValue;
	-(double)doubelValue
	-(id)initWithFormat:(NSString *)format....
 
**可变字符串**

	-(id)initWithCapacity:(NSUInteger)capacity;
	+(id)stringWithCapacity:(NSUInteger)capacity;
	-(void)insertString:(NSString *)aString atIndex:(NSUInteger)loc;
	-(void)deleteCharactersInRang:(NSRange)range;
	-(void)appendString:(NSString *)aString;
	-(void)appendFormat:(NSString *)format, ....
	-(void)setString:(NSString)aString;

---

<h3 id="NSArray"> NSArray </h3>

**初始化**

	+(id)arrayWithObjetcts(id)firstObject, ...
	+(id)arrayWithArray:(NSArray *)array;
	-(id)initWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
	-(id)initWithArray:(NSArray *)array;

**数组元素个数**

	int count = [array count]

**获取数组元素**

	[array objectAtIndex:n];
	[array lastObject];
	
**NSArray简化**

	[NSArray array] 简写为@[]
	[NSArray arrayWithObject:a] 简写为@[a]
	[NSArray arrayWithObjects:a, b, c, nil] 简写为@[a, b, c]
	[array objectAtIndex:idx] 简写为array[idx]
	[array replaceObjectAtIndex:idx withObject:newObj] 简写为array[idx] = newObj;
	
**NSMutableArray**

	- (id)initWithCapacity:(NSUInteger)numItems; // 初始化
	+ (id)arrayWithCapacity:(NSUInteger)numItems;// 初始化
	- (void)addObject:(id)anObject; // 末尾加入一个元素
	- (void)insertObject:(id)anObject atIndex:(NSUInteger)index; // 插入一个元素
	- (void)removeLastObject; // 删除最后一个元素
	- (void)removeObjectAtIndex:(NSUInteger)index; //删除某一个元素
	- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject; //更改某个位置的元素
	+ (instancetype)arrayWithObjects:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
	- (void)addObject:(id)anObject;

---

<h3 id="NSDictionary"> NSDictionary </h3>

**NSDictionary**

	- (instancetype)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys; // 用数据数组和key值数据初始化
	- (instancetype)initWithObjectsAndKeys:(id)firstObject, ... NS_REQUIRES_NIL_TERMINATION; // 用key和value对初始化
	+ (instancetype)dictionaryWithObject:(id)object forKey:(id <NSCopying>)key; // 用某个对象初始化
	- (id)objectForKey:(id)akey; // 从key获取value值
	- (id)valueForKey:(id)aKey; // 从key得到value值
	- (NSArray *)allkeys; // 获取所有的key
	- (NSArray *)allVlues; // 获取所有的value值
	
	- [NSDictionary dictionary] 简写为 @{}
	- [NSDictionary dictionaryWithObject:o1 forKey:k1] 简写为 @{k1:o1}
	- [NSDictionary dictionaryWithObjectsAndKeys:o1, k1, o2, k2, o3, k3, nil] 简写为 @{k1:o1, k2:o2, k3:o3}

**NSMutableDictionary**

	- (void)setObject:(id)anObject forKey:(id)key; // 增加和修改可变字典的内容
	- (void)setValue:(id)anvlaue forKey:(id<NSCopying>)aKey; // 增加和修改可变字典的内容
	- (void)removeObjectForkey:(id)aKey; // 删除Key值对应的对象
	- (void)removeAllObjects; // 删除所有字典内容

---

<h3 id="NSSet"> NSSet </h3>
 
**初始化**

	- (id)initWithObjects:(id)firstObject, ...
	+ (id)setWithObjects:(id)firstObject, ...

**集的元素个数**

	- (NSUInteger)count;
	- (id)member:(id)object;
	- (NSEnumerator *)objectEnumerator;

**获取集中的元素**

	- (NSArray *)allObjects;
	- (id)anyObject;
	- (BOOL)containsObject:(id)anObject;

**NSMutableSet**

	- (void)addObject:(id)anObject;
	- (void)removeObject:(id)object;
	+ (id)setWithObject:(id)object;
	+ (id)setWithObjects:(const id *)objects count:(NSUInteger)cnt;
	+ (id)setWithObjects:(id)firstOject, ...

---

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

---

<h3 id="UIButton"> UIButton(按钮) </h3>

**UIButton初始化**

	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	button.frame = CGRectMake(100, 100, 130, 140);
	[button setTitle:@"按钮" forState:UIControlStateNormal];
	[button addTarget:self action:@selector(pressedButton:) forControlEvents:UIControleEventTouchUpInside]
	
**事件与回调**

- UIControlEventTouchUpInside // 触摸弹起	
- UIControlEventValueChanged  // 值变化事件
- UIControlEventTouchDown	  // 边界内触摸按下事件
- UIControlEventTouchDownRepeat // 轻击数大于1的重复按下事件

**设置背景和图片**

	- [button setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
	- [button setTitle:@"按钮" forState:UIControlStateNormal];
		
	- [lightButton setImage:[UIImage imageNamed:@"开灯"] forState:UIControlStateNormal];
    - [lightButton setImage:[UIImage imageNamed:@"关灯"] forState:UIControlStateHighlighted]; // 高亮状态
    - [lightButton setImage:[UIImage imageNamed:@"关灯"] forState:UIControlStateSelected]; // 选中状态
	- UIControlStateDisable //无法交互状态
	
---

<h3 id="UILabel"> UILabel(标签) </h3>	
	
**UILabel常用属性**

	- text 					// 设置文本内容
	- font 					// 设置文本字体格式和大小
	- textColor 			// 设置文本颜色
	- textAlignment 		// 设置对齐方式
	- backgroundColor 		// 设置背景色
	- numberOfLines 		//文本显示行数，0表示不限制
	- lineBreakMode   (NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail); // 单词换行|末尾"..."	
	
**demo**

	CGSize size = [self sizeWithString:string font:[UIFont systemFontOfSize:15] constraintSize:CGSizeMake(150, 568)];

    UILabel *rightLabel        = [[UILabel alloc] initWithFrame:CGRectMake(165, 250, size.width, size.height)];
    rightLabel.backgroundColor = [UIColor greenColor];
    rightLabel.tag             = 14;
    rightLabel.text            = string;
    rightLabel.textAlignment   = NSTextAlignmentLeft;
    rightLabel.font            = [UIFont systemFontOfSize:15];
    rightLabel.textColor       = [UIColor grayColor];
    rightLabel.numberOfLines   = 0; //文本显示行数，0表示不限制
    rightLabel.lineBreakMode   = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail; // 单词换行|末尾"..."
    [self.view addSubview:rightLabel];
    [rightLabel release];
	
	// 根据字符内容多少获取Rect的size
	- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font constraintSize:(CGSize)constraintSize
	{
	    CGRect rect = [string boundingRectWithSize:CGSizeMake(150, 568)
	                                       options:NSStringDrawingTruncatesLastVisibleLine |
	                                                NSStringDrawingUsesFontLeading |
	                                                NSStringDrawingUsesLineFragmentOrigin
	                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
	                                       context:nil];
	    return rect.size;
	}

---

<h3 id="UITextField"> UITextField(文本域) </h3>

**demo**

	UITextField *textField           = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame) + 50, CGRectGetMinY(self.view.frame) + 150, 200, 25)];
    textField.tag = 15;
    textField.borderStyle            = UITextBorderStyleRoundedRect;
    textField.placeholder            = @"请输入文本....";
    textField.font                   = [UIFont systemFontOfSize:10];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;    // 自动大写
    textField.autocorrectionType     = UITextAutocorrectionTypeNo;          // 自动更正
    textField.tintColor              = [UIColor redColor];                  // 主色调
    textField.keyboardType           = UIKeyboardTypeDefault;               // 键盘类型
    textField.returnKeyType          = UIReturnKeyDone;                     // return键类型
    textField.clearButtonMode        = UITextFieldViewModeWhileEditing;     // 清除模式
    textField.delegate               = self;                                // 设置委托
    textField.secureTextEntry        = YES;
    [self.view addSubview:textField];	

注意：若要实现UITextFieldDelegate协议中的方法，必须设置delegate为当前对象	

---

<h3 id="UISwitch"> UISwitch(开关) </h3>
	
**demo**

	UISwitch *switchControl      = [[UISwitch alloc] initWithFrame:CGRectMake(120, 50, 80, 30)];
    UISwitch *switchControl      = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 40, CGRectGetMinY(self.view.frame) + 55, 80, 30)];
    switchControl.tintColor      = [UIColor grayColor]; // 主色调,边框
    switchControl.onTintColor    = [UIColor redColor]; // 开启后颜色
    switchControl.thumbTintColor = [UIColor blackColor]; // 开关按钮颜色
	//    switchControl.on             = YES; // 默认开启
    [switchControl addTarget:self action:@selector(processControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switchControl];
    [switchControl release];

---

<h3 id="UISlider"> UISlider(滑条) </h3>
	
**demo**
	
	UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMaxY(switchControl.frame) + 20, 200, 30)];
    [self.view addSubview:slider];
    slider.value                 = 0.5;
    slider.minimumValue          = 0.2; // 最小值
    slider.maximumValue          = 1.0; // 最大值
    slider.minimumTrackTintColor = [UIColor redColor]; // 滑条最小进度指示色
    slider.maximumTrackTintColor = [UIColor grayColor]; // 滑条最大进度指示色
    slider.continuous            = NO; //是否持续调用事件方法
    self.view.alpha              = slider.value;
    [slider addTarget:self action:@selector(processControl:) forControlEvents:UIControlEventValueChanged];
    [slider release];

---

<h3 id="UIProgressView"> UIProgressView(进度条) </h3>

**demo**

	UIProgressView *progressView   = [[UIProgressView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame) - 100, CGRectGetMaxY(slider.frame) + 20, 200, 30)];
    progressView.tag               = 20;
    progressView.progress          = slider.value;
    progressView.progressTintColor = [UIColor redColor];
    progressView.trackTintColor    = [UIColor grayColor];
    [self.view addSubview:progressView];
    [progressView release];
    
---

<h3 id="UISegmentedControl"> UISegmentedControl(分段控件) </h3>

**demo**

	// 分段控件
    UISegmentedControl *segmentedControl  = [[UISegmentedControl alloc] initWithItems:@[@"白", @"红", @"绿", @"蓝"]];
    segmentedControl.bounds               = CGRectMake(0, 0, 200, 30);
    segmentedControl.center               = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(progressView.frame) + 40);
    segmentedControl.selectedSegmentIndex = 0; // 当前默认选中的按钮索引
    segmentedControl.tintColor            = [UIColor blackColor];
    [segmentedControl addTarget:self action:@selector(processControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    [segmentedControl release];

---

<h3 id="UIActivityIndicatorView"> UIActivityIndicatorView(进度指示器/菊花) </h3>

	// 进度指示器
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.bounds           = CGRectMake(0, 0, 40, 40);
    activityIndicatorView.center           = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(segmentedControl.frame) + 30);
	//    activityIndicatorView.hidesWhenStopped = NO; // 进度指示器动画停止后是否显示，默认是YES
    
    activityIndicatorView.tag              = 21;
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView release];

---

<h3 id="UIViewController"> UIViewController </h3>

**初始化**

	UIViewController *viewController = 	[[UIViewController alloc] init];

**常用方法**

	- (void)viewDidLoad; //视图加载完成
	- (void)viewWillAppear:(BOOL)animated; // 将要显示
	- (void)viewDidAppear:(BOOL)animated; // 显示完成
	- (void)viewWillDisappear:(BOOL)animated; // 将要移除
	- (void)viewDidDisappear:(BOOL)animated; // 已经移除
	- (void)didReceiveMemoryWarning; // 内存警告
	- (BOOL)shouldAutorotate; // 支持转屏
	- (NSInteger)supportedInterfaceOrientations; // 支持的转屏方向 
	- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration; // 控制器试图将要旋转到某个朝向，在方法中处理新的界面布局

**视图控制器的切换**
 
	- [self presentViewController:detailViewControl animated:YES completion:nil];
	- [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];	
	
	
	
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	