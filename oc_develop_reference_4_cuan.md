# OC Develop Reference 4 cuan

#目录

- 为什么需要内存管理?
- 如何管理内存?
- 管理内存方式
- 拥有、持有对象
- Cocoa内存管理规则

## 内存管理  

### 为什么需要内存管理?

- OC是动态语言，需要管理内存


### 如何管理内存?

- 对象被引用时，引用计数为1
- 对象没有被引用时，引用计数为0
- 当引用减少时，引用计数减1
- retainCount = 0时，对象对销毁 
  

### 管理内存方式
  
- 手动管理
- 自动管理(*ARC*)


### 拥有、持有对象
	
- 一个对象持有另外一个对象的指针，拥有对象
- 一个函数，方法初始化一个对象，方法拥有这个对象


### Cocoa内存管理规则

- 使用alloc、new、copy、mutableCopy生成的对象需要手动释放，这些对象成为堆上的对象
- 使用以上4种方法以外的方法（遍历初始化）生成的对象，默认retainCount为1，并且设置为自动释放，这些对象可以称作栈上的临时对象，局部变量、方法或者函数传参
- 使用retain方法持有的对象，需要手动release进行释放，并且保持retain以及release次数想相同
- 集合类可以持有集合中的对象(retain一次)，当集合对象自身销毁时，会将自身中的所有对象release一次
- 持有集合类，不会增加内部对象的引用计数值

##字符串的拆分与合并

```
NSString *string = @"0180go923o08d";
NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
NSString *result = [[string componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
NSLog(@"%@", result);
```

- - -

## 属性(@property)
- 特性自动声明成员变量
- 特性自动实现了setter及getter
- 只能生成简单的setter以及getter方法，不支持多参数
- 结构体不能连点赋值，可以连点取值

### 属性的总结
- assign:直接赋值，简单、复杂数据类型、SEL(@selector()) 默认属性 避免循环引用(无法释放对象) --delegate:委托、代理设计模式
- retain:引用计数值+1，适用于对象对象
- copy:适用于对象，复制，用于NSString,深度复制，retain不加1，对原值release一次
- readonly:只生成getter
- readwrite:默认属性，生成getter,setter
- noatomic：线程不安全
- atomic:默认，线程安全
- strong:ARC，强引用
- weak:ARC,弱引用
- __ussafe_unretained:类似于assign
- getter =:规定getter方法的名称
- **copy:不可变复制，对可变对象复制是深度复制，其它时候一律浅复制**
- **mutableCopy:可变深度复制**