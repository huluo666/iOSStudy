//
//  Student.h
//  四、属性及点语法、属性与方法
//
//  Created by 张鹏 on 13-11-2.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject {
    
    NSString *_name;
    NSInteger _age;
    NSString *_identity;
    NSDate *_birthday;
    NSString *_type;
    NSPoint _location;
}

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *identity;

@property (assign, nonatomic) NSInteger age;
@property (assign, nonatomic) NSPoint location;

@property (copy  , nonatomic, readonly) NSString *type;
@property (retain, nonatomic, readonly) NSDate *birthday;

- (id)initWithName:(NSString *)name
               age:(NSInteger)age
          identity:(NSString *)identity
          location:(NSPoint)location;

- (NSDictionary *)birthdayWihIdentity:(NSString *)identity;
- (NSDate *)dateWithIdentity:(NSString *)identity;
- (float)distanceWithStudent:(Student *)student;

@end










