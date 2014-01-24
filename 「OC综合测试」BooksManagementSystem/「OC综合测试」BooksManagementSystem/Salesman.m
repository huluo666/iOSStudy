//
//  Salesman.m
//  「OC综合测试」BooksManagementSystem
//
//  Created by cuan on 14-1-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Salesman.h"
#import "Book.h"

@implementation Salesman

- (void)dealloc
{
    [_name release];
    [_salesList release];
    [super dealloc];
}

- (id)initWithName:(NSString *)aName number:(NSInteger)aNumber
{
    if (self = [super init])
    {
        _name      = [aName copy];
        _number    = aNumber;

        _salesList = [[NSMutableDictionary alloc] init];
    }
   
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@, number = %ld, "
            "salesList = %@, sales = %ld",
            _name, _number, _salesList, _sales];
}

- (void)soldBookWithNumber:(NSString *)theBookNumber
{
    if (!theBookNumber || theBookNumber.length == 0)
    {
        NSLog(@"Are you fucking kidding me!");
        return;
    }
    
    for (int i = 0; i < [_salesList count]; i++)
    {
        NSNumber *price = [_salesList valueForKey:theBookNumber];
        [_salesList removeObjectForKey:theBookNumber];
        _sales += [price integerValue];
    }
}

@end
