//
//  Teacher.h
//  OC140109
//
//  Created by cuan on 14-1-9.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Teacher : NSObject
{
    NSString *_name;
    NSString *_age;
}

- (id) initWithName:(NSString *) name age:(NSString *)age;

@end
