//
//  main.m
//  「OC」代理设计模式(Delegate)
//
//  Created by cuan on 14-1-28.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Agent.h"
#import "Human.h"
#import "Dog.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        Person *person = [[Person alloc] init];
        Agent *agent = [[Agent alloc] init];
        person.delegate = agent;
        
        [person buyTicket];
        
        [agent release];
        [person release];
        
        
        Human *human = [[Human alloc] init];
        Dog *dog = [[Dog alloc] init];
        dog.ID = 111;
        human.dog = dog;
        dog.delegate = human; // 狗的主人(代理)设置为人
        [dog release];
        while (1)
        {
            [[NSRunLoop currentRunLoop] run];
        }
        
        [human release];
        
    }
    return 0;
}

