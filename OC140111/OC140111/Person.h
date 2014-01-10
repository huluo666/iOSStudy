//
//  Person.h
//  OC140111
//
//  Created by cuan on 14-1-10.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    NSString *_name;
    NSInteger _age;
}

-(void) setName:(NSString *)name;
-(NSString *) name;

- (id) init;
- (id) initWithName:(NSString *)name age:(NSInteger) age;
+ (Person *) person;
+ (Person *) personWithName:(NSString *)name age:(NSInteger)age;
@end
