//
//  Person.h
//  「UI」数据持久化(day16)
//
//  Created by 萧川 on 14-2-28.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *age;
@property (copy, nonatomic) NSString *sex;
@property (copy, nonatomic) NSString *birthday;
@property (copy, nonatomic) NSString *telephone;
@property (copy, nonatomic) NSString *address;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
