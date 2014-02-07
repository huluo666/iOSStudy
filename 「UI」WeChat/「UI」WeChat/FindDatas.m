//
//  FindDatas.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-3.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "FindDatas.h"
#import "Find.h"

@implementation FindDatas

+ (NSMutableArray *)datas
{
    NSMutableArray *findDatas = [NSMutableArray array];
    [findDatas addObject:[Find findWithName:@"朋友圈" leftImage:[UIImage imageNamed:@"find_more_friend_photograph_icon"] rightImage:[UIImage imageNamed:@"read_tips_onbackbtn"]]];
    [findDatas addObject:[Find findWithName:@"扫一扫" leftImage:[UIImage imageNamed:@"find_more_friend_scan"] rightImage:nil]];
    [findDatas addObject:[Find findWithName:@"摇一摇" leftImage:[UIImage imageNamed:@"find_more_friend_shake"] rightImage:nil]];
    [findDatas addObject:[Find findWithName:@"附近的人" leftImage:[UIImage imageNamed:@"find_more_friend_near_icon"] rightImage:nil]];
    [findDatas addObject:[Find findWithName:@"游戏" leftImage:[UIImage imageNamed:@"find_more_friend_game"] rightImage:nil]];
    [findDatas addObject:[Find findWithName:@"表情商店" leftImage:[UIImage imageNamed:@"find_more_emoji_store"] rightImage:[UIImage imageNamed:@"app_new"]]];
    
    return findDatas;
}

@end
