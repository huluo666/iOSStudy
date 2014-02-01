//
//  Salesman.h
//  「OC综合测试」BooksManagementSystem
//
//  Created by cuan on 14-1-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Salesman : NSObject

@property (copy, nonatomic  ) NSString            *name;
@property (assign, nonatomic) NSInteger           number;
@property (retain, nonatomic) NSMutableDictionary *salesList;
@property (assign, nonatomic) NSInteger           sales;

- (id)initWithName:(NSString *)aName number:(NSInteger)aNumber;

/*!
 *    通过书的编号卖出一本书
 *
 *    @param theBookNumber 书的编号
 */
- (void)soldBookWithNumber:(NSString *)theBookNumber;

@end
