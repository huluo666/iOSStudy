//
//  Student.h
//  L04-数组、字典、集合
//
//  Created by 张鹏 on 14-1-12.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject {
    
    NSMutableDictionary *_infoDictionary;
}

- (id)initWithInfoDictionary:(NSMutableDictionary *)infoDictionary;

- (void)setInfoDictionary:(NSMutableDictionary *)infoDictionary;
- (NSMutableDictionary *)infoDictionary;

@end