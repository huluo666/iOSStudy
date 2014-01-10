//
//  Person.m
//  OC140111
//
//  Created by cuan on 14-1-10.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Person.h"

@implementation Person

-(void) setName:(NSString *)name
{
    _name = name;
}

-(NSString *) name
{
    return _name;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        _name = @"Lucy";
        _age = 22;
    }
    return self;
}

- (id) initWithName:(NSString *)name age:(NSInteger) age
{
    self = [super init];
    if (self)
    {
        _name = name;
        _age  = age;
    }
    return self;
}

+ (Person *) person
{
    return [[Person alloc] init] ;
}

+ (Person *) personWithName:(NSString *)name age:(NSInteger)age
{
    return [[Person alloc] initWithName:@"Mike" age:34];
}
@end
