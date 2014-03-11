//
//  DDCoreDataManager.m
//  「UI」数据持久化(day16)
//
//  Created by 萧川 on 14-2-28.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDCoreDataManager.h"

@implementation DDCoreDataManager

//+ (void)insertObjectInManagedObjectContext:(NSManagedObjectContext *)context
//                                entityName:(NSString *)entityName
//                        relationEntityName:(NSString *)relationEntityName
//                                    params:(NSDictionary *)params
//                            relationParams:(NSDictionary *)relationParams
//{
//    // 非空判断
//    if (!context
//        || !entityName
//        || !relationEntityName
//        || !params
//        || !relationParams
//        || (params.count == 0 && relationParams.count == 0)) {
//        return;
//    }
//    // 创建模板对象
//    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:entityName
//                                                            inManagedObjectContext:context];
//    // 创建关系对象
//    NSManagedObject *relationObject = [NSEntityDescription insertNewObjectForEntityForName:relationEntityName
//                                                                    inManagedObjectContext:context];
//    // 基础对象配置数据
//    for (NSString *key in params) {
//        id value = [params objectForKey:key];
//        // 处理关系建立
//        if ([value isEqualToString:@"relation"]) {
//            [object setValue:relationObject forKey:key];
//        } else {
//            [object setValue:value forKey:key];
//        }
//
//    }
//
//    // 关系对象配置数据
//    for (NSString *key in params) {
//        id value = [relationParams objectForKey:key];
//        if ([value isEqualToString:@"relation"]) {
//            [relationObject setValue:object forKey:key];
//        } else {
//            [relationObject setValue:value forKey:key];
//        }
//    }
//    
//    // 保存上下文
//    NSError *error = nil;
//    BOOL success = [context save:&error];
//    NSAssert(success, @"Insert operation failed with error %@", [error localizedDescription]);
//}


+ (void)insertObjectInManagedObjectContext:(NSManagedObjectContext *)context
                                entityName:(NSString *)entityName
                        relationEntityName:(NSString *)relationEntityName
                                    params:(NSDictionary *)params
                            relationParams:(NSDictionary *)relationParams {
    
    // 为空判断：使方法变得更健壮
    if (!context ||
        entityName.length == 0 ||
        relationEntityName.length == 0 ||
        ([params count] == 0 && [relationParams count] == 0)) {
        return;
    }
    // 创建基础对象
    NSManagedObject *object = [NSEntityDescription
                               insertNewObjectForEntityForName:entityName
                               inManagedObjectContext:context];
    // 创建关系对象
    NSManagedObject *relationObject = [NSEntityDescription
                                       insertNewObjectForEntityForName:relationEntityName
                                       inManagedObjectContext:context];
    // 基础对象数据配置
    for (NSString *key in params) {
        id value = [params objectForKey:key];
        // 处理关系建立
        if ([value isEqualToString:@"relation"]) {
            [object setValue:relationObject forKey:key];
        }
        else {
            [object setValue:value forKey:key];
        }
    }
    
    // 关系对象数据配置
    for (NSString *key in relationParams) {
        id value = [relationParams objectForKey:key];
        // 处理关系建立
        if ([value isEqualToString:@"relation"]) {
            [relationObject setValue:object forKey:key];
        }
        else {
            [relationObject setValue:value forKey:key];
        }
    }
    // 保存上下文
    NSError *error = nil;
    BOOL success = [context save:&error];
    NSAssert(success, @"Insert operation did failed with error message '%@'.", [error localizedDescription]);
}


+ (NSArray *)fetchObjectsInManagedObjectContext:(NSManagedObjectContext *)context
                                     entityName:(NSString *)entityName
                                      predicateFormat:(NSString *)predicateFormat
{
    if (!entityName || entityName.length == 0) {
        return  nil;
    }
    if (!predicateFormat) {
        return nil;
    }
    // 初始化检索请求
    NSFetchRequest *fetchRequset = [NSFetchRequest fetchRequestWithEntityName:entityName];
    // 配置检索条件
    fetchRequset.predicate = [NSPredicate predicateWithFormat:predicateFormat];
    // 执行检索请求
    NSError *error = nil;
    NSArray *objects =[context executeFetchRequest:fetchRequset error:&error];
    NSAssert(!error, @"NSManagedObjectContext fetch operation did faild with error message %@", [error localizedDescription]);
    NSMutableArray *result = [NSMutableArray array];
    if (objects.count > 0) {
        for (id obj in objects) {
            [result addObject:obj];
        }
    }
    
    return result;
}

+ (void)deleteObjectsInManagedObjectContext:(NSManagedObjectContext *)context
                                 entityName:(NSString *)entityName
                            predicateFormat:(NSString *)predicateFormat
{
    if (!entityName || entityName.length == 0) {
        return;
    }
    if (!predicateFormat) {
        return;
    }
    // 查询
    NSArray *objects = [self fetchObjectsInManagedObjectContext:context
                                                     entityName:entityName
                                                predicateFormat:predicateFormat];
    // 删除
    NSError *error = nil;
    if (objects.count > 0) {
        for (id obj in objects) {
            // 从上下文中删除数据
            [context deleteObject:obj];
        }
        BOOL success = [context save:&error];
        NSAssert(success, @"NSManagedObjectContext delete operation faild with error message %@", [error localizedDescription]);
    }
}


@end
