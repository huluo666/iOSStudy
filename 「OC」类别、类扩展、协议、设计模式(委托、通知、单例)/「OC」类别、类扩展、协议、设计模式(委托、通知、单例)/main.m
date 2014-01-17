//
//  main.m
//  「OC」类别、类扩展、协议、设计模式(委托、通知、单例)
//
//  Created by cuan on 14-1-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person+comparePersonAge.h"
#import "Person.h"

int main(int argc, const char * argv[])
{
    // 类别：为现有类添加新的方法
    
    Person *person = [[Person alloc] init];
    person.age = 22;
    Person *otherPerson = [[Person alloc] init];
    otherPerson.age = 25;
    
    NSLog(@"%@", [person ElderPersonWithPerson:otherPerson]);
    
    return 0;
}

