//
//  ContactDetailInformation.m
//  2014.2.27
//
//  Created by 张鹏 on 14-2-27.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ContactDetailInformation.h"


@implementation ContactDetailInformation

@dynamic birthday;
@dynamic telephone;
@dynamic address;
@dynamic info;

+ (NSString *)entityName {
    
    return @"ContactDetailInformation";
}

@end
