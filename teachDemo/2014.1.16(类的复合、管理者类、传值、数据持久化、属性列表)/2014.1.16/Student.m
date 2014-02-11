//
//  Student.m
//  2014.1.16
//
//  Created by 张鹏 on 14-1-16.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Student.h"
#import "Teacher.h"

@implementation Student

- (void)dealloc {
    
    [_name release];
    _teacher = nil;
    
    NSLog(@"student dealloced.");
    
    [super dealloc];
}

- (NSInteger)agesDifferent {
    
    return _age - _teacher.age;
}

// 1.字典可以遍历，遍历对象所有数据
// 2.可以进行持久化存储，NSUserDefaults
- (NSMutableDictionary *)dictionary {
    
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    [infoDict setObject:_name ? _name : @"" forKey:@"name"];
    [infoDict setObject:@(_age) forKey:@"age"];
    
    return infoDict;
}

- (void)save {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[self dictionary] forKey:STUDENT_KEY];
    [userDefaults synchronize];
}

+ (NSDictionary *)load {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:STUDENT_KEY];
}

@end


















