//
//  DDFeeds.h
//  LighterReader
//
//  Created by 萧川 on 14-4-14.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDFeeds : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *review;
@property (nonatomic, strong) NSString *hint;
@property (nonatomic, strong) NSString *content;

+ (id)feeds;
+ (NSArray *)feedsWithCapacity:(NSInteger)capacity;

- (NSString *)description;

@end
