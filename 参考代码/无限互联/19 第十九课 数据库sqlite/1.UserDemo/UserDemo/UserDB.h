//
//  UserDB.h
//  UserDemo
//
//  Created by wei.chen on 13-2-27.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "BaseDB.h"
#import "UserModel.h"

@interface UserDB : BaseDB

+ (id)shareInstance;

//创建用户表
- (void)createTable;

//添加用户
- (BOOL)addUser:(UserModel *)userModel;

- (NSArray *)findUsers;

@end
