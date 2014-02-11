//
//  Person.m
//  2014.1.17plus
//
//  Created by 张鹏 on 14-1-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Person.h"

@interface Person ()

- (void)agePlus;

@end

@implementation Person

- (void)agePlus {
    
    NSLog(@"person age = %ld", ++_age);
}

- (void)dealloc {
    
    [_name release];
    
    [super dealloc];
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"person name:%@ age:%ld", _name, _age];
}

- (void)print {
    
    NSLog(@"%@", self);
}

- (void)setCode:(NSString *)code {
    
    if (_code != code) {
        [_code release];
        _code = [code copy];
        
//        [self processBirthday];
    }
}

- (NSString *)birthday {
    
    return _birthday;
}

//- (void)processBirthday {
//    
//    // 510104198808100012
//    if (_code && [_code length] == 18) {
//        NSString *year = [_code substringWithRange:NSMakeRange(6, 4)];
//        NSString *month = [_code substringWithRange:NSMakeRange(10, 2)];
//        NSString *day = [_code substringWithRange:NSMakeRange(12, 2)];
//        _birthday = [[NSString stringWithFormat:@"%@-%@-%@", year, month, day] copy];
//    }
//}

@end

















