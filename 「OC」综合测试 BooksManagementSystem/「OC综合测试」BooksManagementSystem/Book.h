//
//  Book.h
//  「OC综合测试」BooksManagementSystem
//
//  Created by cuan on 14-1-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (copy, nonatomic  ) NSString  *bookName;
@property (copy, nonatomic  ) NSString  *number;
@property (assign, nonatomic) NSInteger price;
@property (assign, nonatomic) NSInteger words;
@property (retain, nonatomic) NSDate    *releaseDate;

- (id)initWithBookName:(NSString *)bookName
                number:(NSString *)theNumber
                 price:(NSInteger)thePrice
                 words:(NSInteger)theWords
           releaseDate:(NSDate *)theReleaseDate;

@end
