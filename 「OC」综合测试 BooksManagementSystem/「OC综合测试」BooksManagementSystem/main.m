//
//  main.m
//  「OC综合测试」BooksManagementSystem
//
//  Created by cuan on 14-1-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"
#import "Salesman.h"
#import "Manager.h"

/*
 建立一个图书销售系统：
 1、	一本书拥有名称，编号，单价，总字数和发行日期。销售员拥有名称，编号，销售列表（包含他负责销售的书的编号），总销售额；
 2、	任意一本书可以指定一个销售员；
 3、	销售员可以售出他的列表中的一本书，该书的编号从他的列表中移除，同时总销售额增加（增加的金额为书的价格）；
 4、	可以对全部的销售员按照总销售额排序；
 5、	找出销售额最差的销售员所有未售出的书。
 
 输出要求：
 1、	打印一本书的全部信息，和一个销售员的所有信息；
 2、	实现一本书指定销售员的方法；
 3、	打印一个销售员售出一本书后的所有信息；
 4、	按销售总额打印所有销售员的名称；
 5、	打印这些未售出的书的信息。
 
 */

int main(int argc, const char * argv[])
{

#pragma mark 初始化一本书书和一个销售员并打印信息
    
    // 由于发行日期后面没有涉及的相关计算，故简单处理，统一设为当前时间
    Book *book1 = [[Book alloc] initWithBookName:@"book1"
                                          number:@"001"
                                           price:120
                                           words:11111
                                     releaseDate:[NSDate date]];
    Salesman *salesman1 = [[Salesman alloc] initWithName:@"salesman1" number:12];
    
    NSLog(@"书的信息：%@", book1);
    NSLog(@"销售员的信息：%@", salesman1);
    
#pragma mark 实现一本书指定销售员的方法
    
    NSLog(@"\n");
    
    Manager *manager = [[Manager alloc] init];
    [manager assignSalesman:salesman1 forBook:book1];
    
    NSLog(@"书指定销售员后销售员的信息：%@\n", salesman1);
    
#pragma mark 打印一个销售员售出一本书后的所有信息
    
    NSLog(@"\n");
    
    [salesman1 soldBookWithNumber:book1.number];
    NSLog(@"销售员卖出一本书后销售员的信息：%@\n", salesman1);
    
#pragma mark 对全部的销售员按照总销售额排序
    
    NSLog(@"\n");
    
    Salesman *salesman2 = [[Salesman alloc] initWithName:@"salesman2" number:22];
    Salesman *salesman3 = [[Salesman alloc] initWithName:@"salesman3" number:25];
    Salesman *salesman4 = [[Salesman alloc] initWithName:@"salesman4" number:78];
    salesman2.sales = 231;
    salesman3.sales = 123;
    salesman4.sales = 97;
    
    NSMutableArray *salesmans = [NSMutableArray arrayWithObjects:salesman1,
                                 salesman2, salesman3,salesman4, nil];
    
    // manager持有所有的销售员
    manager.salesmans = salesmans;
    
    NSLog(@"打印销售员按照总销售额从高到低的排序：");
    [manager printSalesmanNameBySalesSorted];

#pragma mark 	找出销售额最差的销售员所有未售出的书,打印这些未售出的书的信息。
    
    NSLog(@"\n");
    
    // 模拟最差销售员没有卖出去的书
    Book *book11 = [[Book alloc] initWithBookName:@"book11"
                                           number:@"111"
                                            price:110 words:24141
                                      releaseDate:[NSDate date]];
    Book *book12 = [[Book alloc] initWithBookName:@"book12"
                                           number:@"2222"
                                            price:421
                                            words:12414
                                      releaseDate:[NSDate date]];
    Book *book13 = [[Book alloc] initWithBookName:@"book13"
                                           number:@"24324"
                                            price:422
                                            words:345345
                                      releaseDate:[NSDate date]];
    Book *book14 = [[Book alloc] initWithBookName:@"book14"
                                           number:@"13414"
                                            price:389
                                            words:2435
                                      releaseDate:[NSDate date]];
    [manager assignSalesman:salesman4 forBook:book11];
    [manager assignSalesman:salesman4 forBook:book12];
    [manager assignSalesman:salesman4 forBook:book13];
    [manager assignSalesman:salesman4 forBook:book14];
    
    NSMutableArray *books = [NSMutableArray arrayWithObjects:book1,
                             book11, book12, book13, book14, nil];
    
    // manager持有所有的书
    manager.books = books;
    
    NSLog(@"打印最差的销售员所有未售出的书的信息：");
    [manager printLoserBooksInformation];
    
#pragma mark 清理空间
    
    [book1 release];
    [book11 release];
    [book12 release];
    [book13 release];
    [book14 release];
    [salesman1 release];
    [salesman2 release];
    [salesman3 release];
    [salesman4 release];
    [manager release];
    
    return 0;
}

