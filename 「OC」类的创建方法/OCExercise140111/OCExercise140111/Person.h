//
//  Person.h
//  OCExercise140111
//
//  Created by cuan on 14-1-10.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    NSString   *_name;
    NSInteger    _age;
    NSInteger _height;
}

- (id) init;
- (id) initWithName:(NSString *)name age:(NSInteger) age height:(NSInteger) height;

- (NSString *)name;
- (NSInteger)age;
- (NSInteger)height;

@end
