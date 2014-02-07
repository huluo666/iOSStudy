//
//  PersonInformations.h
//  「UI」WeChat
//
//  Created by cuan on 14-2-3.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInformations : NSObject

@property (copy, nonatomic) NSString *nickName; // 姓名
@property (copy, nonatomic) NSString *remarkName; // 备注名
@property (copy, nonatomic) NSString *account; // 帐号
@property (assign, nonatomic) Sex sex;
@property (copy, nonatomic) UIImage  *avatar; // 头像
@property (assign, nonatomic, getter = isStart) BOOL start; // 是否为星标朋友
@property (copy, nonatomic) NSString *region; // 地区
@property (copy, nonatomic) NSString *signature; // 个性签名
@property (retain, nonatomic) NSMutableArray *photos; // 个人相册
@property (copy, nonatomic) NSString *displayName; // 通讯录列表显示名称

+ (id)personInfomationsWithNickName:(NSString *)nickName
                     remarkName:(NSString *)remarkName
                            sex:(Sex)sex
                        account:(NSString *)account
                         avatar:(UIImage *)avatar
                         region:(NSString *)region
                      signature:(NSString *)signature
                         photos:(NSMutableArray *)photos;

@end
