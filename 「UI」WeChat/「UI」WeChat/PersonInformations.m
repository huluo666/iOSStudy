//
//  PersonInformations.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-3.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "PersonInformations.h"

@implementation PersonInformations

- (void)dealloc
{
    [_nickName release];
    [_account release];
    [_avatar release];
    [_displayName release];
    [super dealloc];
}

+ (id)personInfomationsWithNickName:(NSString *)nickName
                     remarkName:(NSString *)remarkName
                            sex:(Sex)sex
                        account:(NSString *)account
                         avatar:(UIImage *)avatar
                         region:(NSString *)region
                      signature:(NSString *)signature
                         photos:(NSMutableArray *)photos;
{
    PersonInformations *infos = [[[PersonInformations alloc] init] autorelease];
    infos.nickName    = nickName;
    infos.remarkName = remarkName;
    infos.sex = sex;
    infos.account = account;
    infos.avatar = avatar;
    infos.start = NO;
    infos.region = region;
    infos.signature = signature;
    infos.photos = photos;
    return infos;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"nickName = %@, remarkName = %@, sex = %@, "
            "account = %@，region = %@, signature = %@",
            _nickName, _remarkName, (_sex == 0 ? @"男":(_sex == 1 ? @"女" : @"保密")),
            _account, _region, _signature];
}

@end
