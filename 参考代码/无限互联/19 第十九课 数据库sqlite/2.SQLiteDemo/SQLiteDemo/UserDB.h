//
//  UserDB.h
//  SQLiteDemo
//
//  Created by wei.chen on 13-2-27.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDB : NSObject

//创建表
- (void)createTable;

//插入数据
- (void)inserTable;

//查询数据
- (void)selectTable;

@end
