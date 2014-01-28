//
//  PlayList.h
//  「OC」KVC(KeyValueCoding)
//
//  Created by cuan on 14-1-27.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PlayItem;

@interface PlayList : NSObject
{
    NSString *_name;
}

@property (copy, nonatomic) NSString *name;
@property (retain, nonatomic) NSNumber *number;
@property (retain, nonatomic) PlayItem *currentItem; // 当前播放列表
@property (retain, nonatomic) NSMutableArray *itemList;

@end
