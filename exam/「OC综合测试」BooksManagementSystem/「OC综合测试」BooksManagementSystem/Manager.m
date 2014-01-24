//
//  Manager.m
//  「OC综合测试」BooksManagementSystem
//
//  Created by cuan on 14-1-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Manager.h"
#import "Book.h"
#import "Salesman.h"

@implementation Manager

- (void)assignSalesman:(Salesman *)theSalesman forBook:(Book *)theBook
{
    if (!theSalesman || !theBook)
    {
        NSLog(@"kidding!");
        exit(0);
    }
#pragma mark - 为字典添加键值对使用方法setObject:forKey:，setValue:forKey:是KVC方法
    [theSalesman.salesList setValue:@(theBook.price) forKey:theBook.number];
}

- (void)sortSalesmanBySales
{
    [_salesmans sortUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        if (![obj1 isKindOfClass:[Salesman class]] ||
            ![obj2 isKindOfClass:[Salesman class]])
        {
            NSLog(@"Are you kidding?");
            exit(0);
        }
        
        NSComparisonResult result = [@([obj1 sales]) compare:@([obj2 sales])];
        if (result != NSOrderedSame)
        {
            return result == NSOrderedAscending ?
            NSOrderedDescending : NSOrderedAscending;
        }
        
        return result;
        
    }];

}

- (void)printSalesmanNameBySalesSorted
{
    [self sortSalesmanBySales];
    for (Salesman *item in _salesmans)
    {
        NSLog(@"%@", item.name);
    }
}

- (Book *)bookWithbookNumber:(NSString *)theBookNumber
{
    if (!theBookNumber || theBookNumber.length == 0)
    {
        return nil;
    }
    
    for (Book *item in _books)
    {
        if ([item.number isEqualToString:theBookNumber])
        {
            return item;
        }
    }
    
    return nil;
}

- (void)printLoserBooksInfomation
{
    [self sortSalesmanBySales];
    Salesman *loser = _salesmans[[_salesmans count] - 1];
    
    NSArray *bookNumbers = [loser.salesList allKeys];
    
    Book *temp = nil;
    for (NSString *number in bookNumbers)
    {
        temp = [self bookWithbookNumber:number];
        if (temp)
        {
            NSLog(@"%@", temp);
        }
    }
}

@end
