//
//  TicketDelegate.h
//  「OC」代理设计模式(Delegate)
//
//  Created by cuan on 14-1-28.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

// 声明一个跑腿的协议
@protocol TicketDelegate <NSObject>

// 查询票价
- (double)ticketPrice;

// 查询余票
- (NSInteger)leftTicketCount;

@end
