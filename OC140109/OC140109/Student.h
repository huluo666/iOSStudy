//
//  Student.h
//  OC140109
//
//  Created by Rimi07 on 14-1-9.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject
{
    NSString *_name;
    NSString *_age;
    NSString *_code;
}

- (void) print;
- (id)init;
- (id)initWithName:(NSString *) name    age:(NSString *) age    code :(NSString *) code;


@end