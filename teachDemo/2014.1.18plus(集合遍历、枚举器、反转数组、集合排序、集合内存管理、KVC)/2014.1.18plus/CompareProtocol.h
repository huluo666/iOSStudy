//
//  CompareProtocol.h
//  2014.1.18plus
//
//  Created by 张鹏 on 14-1-18.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CompareProtocol <NSObject>

@property (assign, nonatomic) NSInteger age;

- (NSComparisonResult)compareAge:(id<CompareProtocol>)object;

@end















