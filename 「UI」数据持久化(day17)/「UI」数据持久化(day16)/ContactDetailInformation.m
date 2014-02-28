//
//  ContactDetailInformation.m
//  「UI」数据持久化(day16)
//
//  Created by 萧川 on 14-2-27.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "ContactDetailInformation.h"


@implementation ContactDetailInformation

@dynamic birthday;
@dynamic telephone;
@dynamic address;
@dynamic info;

+ (NSString *)entityName
{
    return @"ContactDetailInformation";
}

@end
