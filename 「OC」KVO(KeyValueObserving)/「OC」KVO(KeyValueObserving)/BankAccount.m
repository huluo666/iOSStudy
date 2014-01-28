//
//  BankAccount.m
//  「OC」KVO(KeyValueObserving)
//
//  Created by cuan on 14-1-27.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "BankAccount.h"

@implementation BankAccount

- (id)init
{
    if (self = [super init])
    {
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(balanceUpdate:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)balanceUpdate:(id)argument
{
    float currentBalance = self.openingBalance;
    currentBalance += arc4random()%100;
    // method 1
    self.openingBalance = currentBalance;
    
    // method 2
//    [self setOpeningBalance:currentBalance];
    
    // method 3
//    [self setValue:@(currentBalance) forKey:@"openingBalance"];
    
    // method 4
//    [self willChangeValueForKey:@"openingBalance"];
//    _openingBalance = currentBalance;
//    [self didChangeValueForKey:@"openingBalance"];
    
}


@end
