//
//  ContactInformation.h
//  「UI」数据持久化(day16)
//
//  Created by 萧川 on 14-2-27.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ContactDetailInformation;

@interface ContactInformation : NSManagedObject

@property (nonatomic, retain) NSString * age;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) ContactDetailInformation *detailInfo;

// 返回对象所对应的实体名称
+ (NSString *)entityName;

@end
