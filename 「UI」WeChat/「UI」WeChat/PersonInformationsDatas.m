//
//  PersonInformationsDatas.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-3.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "PersonInformationsDatas.h"
#import "PersonInformations.h"

@implementation PersonInformationsDatas

+ (NSMutableArray *)datas
{
    NSMutableArray *datasArray = [NSMutableArray array];
    
    [datasArray addObject:[PersonInformations personInfomationsWithName:@"Jack" account:[NSString stringWithFormat:@"%d", arc4random()%99 + 100]]];
    [datasArray addObject:[PersonInformations personInfomationsWithName:@"Mike" account:[NSString stringWithFormat:@"%d", arc4random()%99 + 100]]];
    [datasArray addObject:[PersonInformations personInfomationsWithName:@"Lucy" account:[NSString stringWithFormat:@"%d", arc4random()%99 + 100]]];
    [datasArray addObject:[PersonInformations personInfomationsWithName:@"Lily" account:[NSString stringWithFormat:@"%d", arc4random()%99 + 100]]];
    [datasArray addObject:[PersonInformations personInfomationsWithName:@"Matt" account:[NSString stringWithFormat:@"%d", arc4random()%99 + 100]]];
    [datasArray addObject:[PersonInformations personInfomationsWithName:@"Micheal" account:[NSString stringWithFormat:@"%d", arc4random()%99 + 100]]];
    [datasArray addObject:[PersonInformations personInfomationsWithName:@"Laury" account:[NSString stringWithFormat:@"%d", arc4random()%99 + 100]]];
    [datasArray addObject:[PersonInformations personInfomationsWithName:@"Damon" account:[NSString stringWithFormat:@"%d", arc4random()%99 + 100]]];
    [datasArray addObject:[PersonInformations personInfomationsWithName:@"Kalus" account:[NSString stringWithFormat:@"%d", arc4random()%99 + 100]]];
    [datasArray addObject:[PersonInformations personInfomationsWithName:@"Matt" account:[NSString stringWithFormat:@"%d", arc4random()%99 + 100]]];
    [datasArray addObject:[PersonInformations personInfomationsWithName:@"Tom" account:[NSString stringWithFormat:@"%d", arc4random()%99 + 100]]];
    [datasArray addObject:[PersonInformations personInfomationsWithName:@"Will" account:[NSString stringWithFormat:@"%d", arc4random()%99 + 100]]];
    [datasArray addObject:[PersonInformations personInfomationsWithName:@"Jerry" account:[NSString stringWithFormat:@"%d", arc4random()%99 + 100]]];
    [datasArray addObject:[PersonInformations personInfomationsWithName:@"Anna" account:[NSString stringWithFormat:@"%d", arc4random()%99 + 100]]];
    [datasArray addObject:[PersonInformations personInfomationsWithName:@"Jermy" account:[NSString stringWithFormat:@"%d", arc4random()%99 + 100]]];
    [datasArray addObject:[PersonInformations personInfomationsWithName:@"Jim" account:[NSString stringWithFormat:@"%d", arc4random()%99 + 100]]];
    [datasArray addObject:[PersonInformations personInfomationsWithName:@"Anni" account:[NSString stringWithFormat:@"%d", arc4random()%99 + 100]]];
    [datasArray addObject:[PersonInformations personInfomationsWithName:@"Bob" account:[NSString stringWithFormat:@"%d", arc4random()%99 + 100]]];
    [datasArray addObject:[PersonInformations personInfomationsWithName:@"andy" account:[NSString stringWithFormat:@"%d", arc4random()%99 + 100]]];
    
    return datasArray;
}

@end
