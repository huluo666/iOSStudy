//
//  DDCoreDataManager.h
//  「UI」数据持久化(day16)
//
//  Created by 萧川 on 14-2-28.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDCoreDataManager : NSObject

/*!
 *    增加数据
 *
 *    @param context            指定需要操作的上下文
 *    @param entityName         基本实体名称
 *    @param relationEntityName 关系实体名称
 *    @param params             基本实体对象数据
 *    @param relationParams     关系实体对象数据
 */
+ (void)insertObjectInManagedObjectContext:(NSManagedObjectContext *)context
                                entityName:(NSString *)entityName
                        relationEntityName:(NSString *)relationEntityName
                                    params:(NSDictionary *)params
                            relationParams:(NSDictionary *)relationParams;

// 检索数据
+ (NSArray *)fetchObjectsInManagedObjectContext:(NSManagedObjectContext *)context
                                     entityName:(NSString *)entityName
                                predicateFormat:(NSString *)predicateFormat;

// 删除数据
+ (void)deleteObjectsInManagedObjectContext:(NSManagedObjectContext *)context
                                 entityName:(NSString *)entityName
                            predicateFormat:(NSString *)predicateFormat;

@end
