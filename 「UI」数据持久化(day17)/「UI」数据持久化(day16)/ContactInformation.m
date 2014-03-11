//
//  ContactInformation.m
//  「UI」数据持久化(day16)
//
//  Created by 萧川 on 14-2-27.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "ContactInformation.h"
#import "ContactDetailInformation.h"


@implementation ContactInformation

@dynamic age;
@dynamic name;
@dynamic sex;
@dynamic detailInfo;

+ (NSString *)entityName
{
    return @"ContactInformation";
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"contact information : \nname:%@\nage:%@\nsex:%@\nbirthday:%@\ntelephone:%@\naddress:%@", self.name, self.age, self.sex, self.detailInfo.birthday, self.detailInfo.telephone, self.detailInfo.address];
}

@end
