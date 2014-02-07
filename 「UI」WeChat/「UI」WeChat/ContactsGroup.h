//
//  Group.h
//  「UI」WeChat
//
//  Created by cuan on 14-2-3.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactsGroup : NSObject

@property (nonatomic, copy) NSString *groupName; // 分组名
@property (nonatomic, retain) NSMutableArray *infos; // 分组内容(联系人信息)

+ (id)contactsGroup;
+ (id)contactsGroupWithGroupName:(NSString *)groupName;

@end
