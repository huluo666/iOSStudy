//
//  ContactDetailInformation.h
//  2014.2.27
//
//  Created by 张鹏 on 14-2-27.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ContactDetailInformation : NSManagedObject

@property (nonatomic, retain) NSString * birthday;
@property (nonatomic, retain) NSString * telephone;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSManagedObject *info;

+ (NSString *)entityName;

@end
