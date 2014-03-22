//
//  DDAddProducts.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-22.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDAddProducts.h"

@interface DDAddProducts ()

@end


static NSString *addCellIdentifier = @"addCellIdentifier";

@implementation DDAddProducts

- (id)init
{
    self = [super init];
    if (self) {
        self.bounds = CGRectMake(0, 0, 230, 500);
        self.backgroundColor = [UIColor greenColor];
        self.layer.cornerRadius = 15;
        
    }
    return self;
}


@end
