//
//  Person.h
//  七、引用与传值、类与类的关联
//
//  Created by 张鹏 on 13-11-4.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject {
    
    NSString *_name;
    NSInteger _age;
    NSString *_identity;
    NSString *_birthday;
}

@property (copy , nonatomic) NSString *name;
@property (copy , nonatomic) NSString *identity;
@property (copy , nonatomic) NSString *birthday;

@property (assign, nonatomic) NSInteger age;

- (id)initWithName:(NSString *)name age:(NSInteger)age identity:(NSString *)identity;
- (NSDictionary *)dictionary;
- (void)saveInformationForKey:(NSString *)key;
+ (NSArray *)loadInformationsForKey:(NSString *)key;

@end












