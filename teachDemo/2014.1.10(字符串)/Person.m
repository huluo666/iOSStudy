//
//  Person.m
//  demotext
//
//  Created by 张鹏 on 14-1-10.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Person.h"

// self:对象方法代表：当前类的对象
// self:类方法代表：当前的类
// super:对象方法代表：父类的对象
// super:类方法代表：当前类的父类

@implementation Person

- (id)init {
    
    // self指针：当前类的对象
    self = [self initWithName:@"理查德" age:40];
    if (self) {
        
//        _name = @"理查德";
//        _age = 40;
        
//        [self setName:@"理查德 － 二世"];
        _name = @"理查德 － 二世";
        
    }
    return self;
}

- (id)initWithName:(NSString *)name age:(NSInteger)age {
    
    self = [super init];
    if (self) {
        
        _name = name;
        _age = age;
        
    }
    return self;
}

+ (Person *)person {
    
    Person *person = [[self alloc] init];
    
    return person;
}

+ (Person *)personWithName:(NSString *)name age:(NSInteger)age {
    
    Person *person = [[Person alloc] initWithName:name age:age];
    
    return person;
}

+ (void)classPrint {
    
    NSLog(@"self = %@", self);
}

- (void)instancePrint {
    
    NSLog(@"self = %@", self);
}

- (void)print {
    
    NSLog(@"%@ name:%@ age:%ld", self, _name, _age);
}

- (int)maxWithNumber:(int)number anotherNumber:(int)anotherNumber {
    
    return number > anotherNumber ? number : anotherNumber;
}

+ (NSString *)convertNSIntegerToString:(NSInteger)integer {
    
    return [NSString stringWithFormat:@"%ld", integer];
}

+ (NSInteger)convertNSStringToInteger:(NSString *)string {
    
    return [string integerValue];
}

- (void)setName:(NSString *)name {
    
    _name = name;
}

- (NSString *)name {
    
    return _name;
}

- (void)setAge:(NSInteger)age {
    
    _age = age;
}

- (NSInteger)age {
    
    return _age;
}












@end
