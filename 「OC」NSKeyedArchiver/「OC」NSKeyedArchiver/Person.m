//
//  Person.m
//  「OC」NSKeyedArchiver
//
//  Created by cuan on 14-1-28.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)dealloc
{
    [_name release];
    [_child release];
    [super dealloc];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:_age forKey:@"age"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_child forKey:@"child"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.name  = [aDecoder decodeObjectForKey:@"name"];
        self.age   = [aDecoder decodeIntegerForKey:@"age"];
        self.child = [aDecoder decodeObjectForKey:@"child"];
    }
    return self;
}

@end
