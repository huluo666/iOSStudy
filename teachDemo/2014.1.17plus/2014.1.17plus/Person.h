//
//  Person.h
//  2014.1.17plus
//
//  Created by 张鹏 on 14-1-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomProtocol.h"

@interface Person : NSObject <CustomProtocol> {
    
    NSString *_name;
    NSString *_identity;
    NSInteger _age;
    
    NSString *_code;
    NSString *_birthday;
}

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;

@property (copy, nonatomic) NSString *code;

- (void)print;
- (NSString *)birthday;

@end











