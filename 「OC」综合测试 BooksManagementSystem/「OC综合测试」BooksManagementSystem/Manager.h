//
//  Manager.h
//  「OC综合测试」BooksManagementSystem
//
//  Created by cuan on 14-1-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Salesman;
@class Book;

@interface Manager : NSObject

@property (retain, nonatomic) NSMutableArray *books;
@property (retain, nonatomic) NSMutableArray *salesmans;

/*!
 *    为书指定一个销售员
 *
 *    @param theSalesman 被指定的销售员
 *    @param theBook     被指定销售员的书
 */
- (void)assignSalesman:(Salesman *)theSalesman forBook:(Book *)theBook;

/*!
 *    打印按照销售额从高到低排序后的销售员的名字
 */
- (void)printSalesmanNameBySalesSorted;

/*!
 *    通过销售额从高到低对销售员进行排序
 */
- (void)sortSalesmanBySales;

/*!
 *    通过书的编号来获取书
 *
 *    @param theBookNumber 编号
 *
 *    @return 指定编号的书
 */
- (Book *)bookWithbookNumber:(NSString *)theBookNumber;

/*!
 *    打印最差销售员未售出的书的信息
 */
- (void)printLoserBooksInformation;
@end
