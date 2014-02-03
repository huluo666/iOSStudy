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
    [_name release];
    [_account release];
    [super dealloc];
}

+ (id)personInfomationsWithName:(NSString *)name account:(NSString *)account
{
    PersonInformations *infos = [[[PersonInformations alloc] init] autorelease];
    infos.name    = name;
    infos.account = account;
    return infos;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@, account = %@", _name, _account];
}

@end
