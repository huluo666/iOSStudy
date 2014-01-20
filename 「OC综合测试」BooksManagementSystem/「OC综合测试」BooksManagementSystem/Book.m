//
//  Book.m
//  「OC综合测试」BooksManagementSystem
//
//  Created by cuan on 14-1-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Book.h"

@implementation Book

- (void)dealloc
{
    [_bookName release];
    [_releaseDate release];
    [_number release];
    [super dealloc];
}

- (id)initWithBookName:(NSString *)bookName
                number:(NSString *)theNumber
                 price:(NSInteger)thePrice
                 words:(NSInteger)theWords
           releaseDate:(NSDate *)theReleaseDate
{
    if (self = [super init])
    {
        _bookName    = [bookName copy];
        _number      = [theNumber copy];
        _price       = thePrice;
        _words       = theWords;
        _releaseDate = [theReleaseDate retain];
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"bookName = %@, number = %@, price = %ld,"
            " words = %ld, releaseDate = %@",
            _bookName, _number, _price, _words, _releaseDate];
}

@end
