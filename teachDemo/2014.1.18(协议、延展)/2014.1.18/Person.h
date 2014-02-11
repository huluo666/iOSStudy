//
//  Person.h
//  2014.1.18
//
//  Created by 张鹏 on 14-1-18.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonProtocol.h"

@interface Person : NSObject <PersonProtocol> {
    
    NSString *_name;
    NSString *_age;
    NSString *_code;
}

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *age;
@property (copy, nonatomic) NSString *code;

- (id)initWithName:(NSString *)name
               age:(NSString *)age
              code:(NSString *)code;

@end
















