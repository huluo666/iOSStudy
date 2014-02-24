//
//  NSArray+NSStringFilter.h
//  2014.2.24
//
//  Created by 张鹏 on 14-2-24.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (NSStringFilter)

- (NSArray *)filteredArrayUsingBlock:(BOOL(^)(id objc))block;

@end
