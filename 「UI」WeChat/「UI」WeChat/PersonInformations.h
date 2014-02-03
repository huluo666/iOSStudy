//
//  PersonInformations.h
//  「UI」WeChat
//
//  Created by cuan on 14-2-3.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInformations : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *account;

+ (id)personInfomationsWithName:(NSString *)name account:(NSString *)account;

@end
