//
//  Agent.h
//  「OC」代理设计模式(Delegate)
//
//  Created by cuan on 14-1-28.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TicketDelegate.h"

@interface Agent : NSObject <TicketDelegate>

@end
