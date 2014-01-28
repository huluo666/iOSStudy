//
//  Person.m
//  「OC」KVO(KeyValueObserving)
//
//  Created by cuan on 14-1-27.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Person.h"
#import "BankAccount.h"

@implementation Person

- (void)dealloc
{
    [_bankAccount release];
    [super dealloc];
}

- (id)init
{
    if (self = [super init])
    {
        _bankAccount = [[BankAccount alloc] init];
    }
    return self;
}

// OpeningBalance指向自己的指针
static void *OpeningBalance = (void *)&OpeningBalance;

// 监听银行帐号变化过程
- (void)registerAsObsver
{
    // 给银行帐号_bankAccount增加一个监听者self, 监听openingBalance的变化过程，只要openingBalance有变化就会让self知道
    // 变化？ 有新的值
    [_bankAccount addObserver:self forKeyPath:@"openingBalance" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:OpeningBalance];
}

// 监听回掉函数
// _bankAccount里面openingBalance有变化就调用下面的方法
// keyPath:表示之前监听的key,就是openingBalance
// object表示bankAccount
// change是一个字典，包含了新旧值
// context是私有变量OpeningBalance
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"keyPath %@, objcet %@, change %@", keyPath, object, change);
//    if ([keyPath isEqualToString:@"openingBalance"])
    if (context == OpeningBalance)
    {
        NSString *value = [change objectForKey:NSKeyValueChangeNewKey];
        NSLog(@"value is %@", value);
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

// 移除监听
- (void)unRegeisterObserver
{
    [_bankAccount removeObserver:self forKeyPath:@"openingBalance"];
}

@end
