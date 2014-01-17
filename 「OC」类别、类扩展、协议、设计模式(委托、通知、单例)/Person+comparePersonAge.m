//
//  Person+comparePersonAge.m
//  「OC」类别、类扩展、协议、设计模式(委托、通知、单例)
//
//  Created by cuan on 14-1-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Person+comparePersonAge.h"

@implementation Person (comparePersonAge)

- (Person *)ElderPersonWithPerson:(Person *)person
{
    if (self.age < person.age)
    {
        return person;
    }
    else
    {
        return self;
    }
}

@end
