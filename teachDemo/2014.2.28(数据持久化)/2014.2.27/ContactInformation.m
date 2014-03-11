//
//  ContactInformation.m
//  2014.2.27
//
//  Created by 张鹏 on 14-2-27.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ContactInformation.h"
#import "ContactDetailInformation.h"


@implementation ContactInformation

@dynamic name;
@dynamic sex;
@dynamic age;
@dynamic detailInfo;

+ (NSString *)entityName {
    
    return @"ContactInformation";
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"\ncontact information:\nname:%@\nage:%@\nsex:%@\nbirthday:%@\ntelephone:%@\naddress:%@", self.name, self.age, self.sex, self.detailInfo.birthday, self.detailInfo.telephone, self.detailInfo.address];
}

@end


















