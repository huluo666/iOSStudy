//
//  Person.m
//  「OC」代理设计模式(Delegate)
//
//  Created by cuan on 14-1-28.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Person.h"
#import "TicketDelegate.h"
#import "Agent.h"

@implementation Person


- (void)buyTicket
{
    // 让代理去看看票价和余量
    double price = [_delegate ticketPrice];
    NSInteger count = [_delegate leftTicketCount];
    
    NSLog(@"代理查询得到票价为：%f, 余量：%ld", price, count);
}

@end
