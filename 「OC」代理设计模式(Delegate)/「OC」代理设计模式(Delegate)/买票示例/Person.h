//
//  Person.h
//  「OC」代理设计模式(Delegate)
//
//  Created by cuan on 14-1-28.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol TicketDelegate;

@interface Person : NSObject

@property (nonatomic, assign) id<TicketDelegate> delegate;

- (void)buyTicket;

@end
