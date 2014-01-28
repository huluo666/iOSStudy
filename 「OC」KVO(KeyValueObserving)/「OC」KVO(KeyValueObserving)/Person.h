//
//  Person.h
//  「OC」KVO(KeyValueObserving)
//
//  Created by cuan on 14-1-27.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BankAccount;

@interface Person : NSObject
{
    BankAccount *_bankAccount;
}

// 打开监听银行帐号的能力
- (void)registerAsObsver;

// 移除监听
- (void)unRegeisterObserver;
@end
