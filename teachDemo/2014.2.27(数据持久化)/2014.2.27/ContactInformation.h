//
//  ContactInformation.h
//  2014.2.27
//
//  Created by 张鹏 on 14-2-27.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ContactDetailInformation;

@interface ContactInformation : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSString * age;
@property (nonatomic, retain) ContactDetailInformation *detailInfo;

// 返回对象匹配的实体名称
+ (NSString *)entityName;

@end















