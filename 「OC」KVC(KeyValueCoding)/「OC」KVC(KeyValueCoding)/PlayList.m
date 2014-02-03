//
//  PlayList.m
//  「OC」KVC(KeyValueCoding)
//
//  Created by cuan on 14-1-27.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "PlayList.h"
#import "PlayItem.h"

@implementation PlayList

- (void)dealloc
{
    [_name release];
    [_currentItem release];
    [_number release];
    [_itemList release];
    [super dealloc];
}

- (id)init
{
    if (self = [super init])
    {
        self.currentItem = [[[PlayItem alloc] init] autorelease];
        self.itemList = [NSMutableArray array];
        for (int i = 0; i < 20; i++)
        {
            PlayItem *item = [[PlayItem alloc] init];
            item.name = [NSString stringWithFormat:@"name %d", i];
            item.price = 100 + i;
            [self.itemList addObject:item];
            [item release];
        }
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"function %@ is called", NSStringFromSelector(_cmd));
}

@end
