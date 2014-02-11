//
//  UserDB.m
//  UserDemo
//
//  Created by wei.chen on 13-2-27.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "UserDB.h"

static UserDB *instnce;

@implementation UserDB

+ (id)shareInstance {
    if (instnce == nil) {
        instnce = [[[self class] alloc] init];
    }
    return instnce;
}

- (void)createTable {
    NSString *sql = @"CREATE TABLE IF NOT EXISTS User (username TEXT primary key,password TEXT,age TEXT);";
    [self createTable:sql];
}

- (BOOL)addUser:(UserModel *)userModel {
    NSString *sql = @"INSERT OR REPLACE INTO User (username,password,age) VALUES (?,?,?)";
    
    NSArray *params = [NSArray arrayWithObjects:userModel.username,
                                                userModel.password,
                                                userModel.age, nil];
    
    return [self dealData:sql paramsarray:params];
}

- (NSArray *)findUsers {
    NSString *sql = @"SELECT username,password,age FROM User";
    NSArray *data = [self selectData:sql columns:3];

    NSMutableArray *users = [NSMutableArray array];
    for (NSArray *row in data) {
        NSString *username = [row objectAtIndex:0];
        NSString *password = [row objectAtIndex:1];
        NSString *age = [row objectAtIndex:2];
        
        UserModel *user = [[UserModel alloc] init];
        user.username = username;
        user.password = password;
        user.age = age;
        [users addObject:user];
        [user release];
    }
    
    return users;
}

@end
