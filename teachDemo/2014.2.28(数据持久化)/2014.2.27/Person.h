//
//  Person.h
//  2014.2.27
//
//  Created by 张鹏 on 14-2-28.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding> {
    
    NSString *_name;
    NSString *_age;
    NSString *_sex;
    NSString *_birthday;
    NSString *_telephone;
    NSString *_address;
}

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *age;
@property (copy, nonatomic) NSString *sex;
@property (copy, nonatomic) NSString *birthday;
@property (copy, nonatomic) NSString *telephone;
@property (copy, nonatomic) NSString *address;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end













