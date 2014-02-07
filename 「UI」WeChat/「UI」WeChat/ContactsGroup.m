//
//  Group.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-3.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ContactsGroup.h"

@implementation ContactsGroup

- (void)dealloc
{
    [_groupName release];
    [_infos release];
    [super dealloc];
}

- (id)init
{
    if (self = [super init])
    {
        _infos = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (id)contactsGroup
{
    ContactsGroup *gp = [[[ContactsGroup alloc] init] autorelease];
    return gp;
}

+ (id)contactsGroupWithGroupName:(NSString *)groupName
{
    ContactsGroup *gp = [[[ContactsGroup alloc] init] autorelease];
    gp.groupName = groupName;
    return gp;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"groupName = %@, infos = %@", _groupName, _infos];
}

@end
