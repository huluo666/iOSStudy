//
//  BankAccount.h
//  「OC」KVO(KeyValueObserving)
//
//  Created by cuan on 14-1-27.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankAccount : NSObject

@property (nonatomic, assign) float openingBalance; // 账户余额

- (void)balanceUpdate:(id)argument;

@end
