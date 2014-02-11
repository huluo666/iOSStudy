//
//  UserDB.m
//  SQLiteDemo
//
//  Created by wei.chen on 13-2-27.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "UserDB.h"
#import <sqlite3.h>

@implementation UserDB

//创建表
- (void)createTable {
    sqlite3 *sqlite = nil;
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/data.sqlite"];

    //打开数据库
    int result = sqlite3_open([filePath UTF8String], &sqlite);
    if (result != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        return;
    }
    
    //创建表的SQL语句
    NSString *sql = @"CREATE TABLE IF NOT EXISTS User (username TEXT primary key,password TEXT,email TEXT)";
    
    char *error;
    //执行sql语句
    result = sqlite3_exec(sqlite, [sql UTF8String], NULL, NULL, &error);
    if (result != SQLITE_OK) {
        NSLog(@"创建表失败：%s",error);
        return;
    }
    
    //关闭数据库
    sqlite3_close(sqlite);
    
    NSLog(@"创建表成功!");
    
}

//插入数据
- (void)inserTable {
    sqlite3 *sqlite = nil;
    sqlite3_stmt *stmt = nil;
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/data.sqlite"];
    
    //打开数据库
    int result = sqlite3_open([filePath UTF8String], &sqlite);
    if (result != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        return;
    }
    
    //创建SQL语句
    NSString *sql = @"INSERT INTO User(username,password,email) VALUES (?,?,?)";
    //编译SQL语句
    sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, NULL);
    
    NSString *username = @"jack";
    NSString *password = @"88888";
    NSString *email = @"wxhl@qq.com";
    
    //往SQL语句上填充绑定数据
    sqlite3_bind_text(stmt, 1, [username UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 2, [password UTF8String], -1, NULL);
    sqlite3_bind_text(stmt, 3, [email UTF8String], -1, NULL);
    
    //执行SQL语句
    result = sqlite3_step(stmt);
    if (result == SQLITE_ERROR || result == SQLITE_MISUSE) {
        NSLog(@"执行SQL语句失败");
        return;
    }
    
    //关闭数据库句柄
    sqlite3_finalize(stmt);
    
    //关闭数据库
    sqlite3_close(sqlite);
    
    NSLog(@"数据插入成功");
}

//查询数据
- (void)selectTable {
    sqlite3 *sqlite = nil;
    sqlite3_stmt *stmt = nil;
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/data.sqlite"];
    
    //打开数据库
    int result = sqlite3_open([filePath UTF8String], &sqlite);
    if (result != SQLITE_OK) {
        NSLog(@"打开数据库失败");
        return;
    }

    NSString *sql = @"SELECT username,password,email FROM USER WHERE username=?";
    
    //编译SQL语句
    result = sqlite3_prepare_v2(sqlite, [sql UTF8String], -1, &stmt, NULL);
    if (result != SQLITE_OK) {
        return;
    }
    
    //往占位符上绑定数据
    NSString *username = @"jack";
    sqlite3_bind_text(stmt, 1, [username UTF8String], -1, NULL);
    
        
    //查询数据
    result = sqlite3_step(stmt);
    while (result == SQLITE_ROW) {
        char *username = (char *)sqlite3_column_text(stmt, 0);
        char *password = (char *)sqlite3_column_text(stmt, 1);
        char *email = (char *)sqlite3_column_text(stmt, 2);
        
        NSString *userNameString = [NSString stringWithCString:username encoding:NSUTF8StringEncoding];
        NSString *passString = [NSString stringWithCString:password encoding:NSUTF8StringEncoding];

        NSString *emailString = [NSString stringWithCString:email encoding:NSUTF8StringEncoding];
        
        NSLog(@"----用户名：%@,密码：%@, 邮箱：%@-----",userNameString,passString,emailString);
        
        result = sqlite3_step(stmt);
    }
    
    //关闭数据库句柄
    sqlite3_finalize(stmt);
    
    //关闭数据库
    sqlite3_close(sqlite);    
    
}


@end
