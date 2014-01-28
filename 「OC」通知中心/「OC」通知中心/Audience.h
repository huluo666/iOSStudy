//
//  Audience.h
//  「OC」通知中心
//
//  Created by cuan on 14-1-27.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Audience : NSObject

- (void)listening;
- (void)recesiveBroad:(NSNotification *)notify;

@end
