//
//  DDCellObj.h
//  LighterReader
//
//  Created by 萧川 on 14-4-8.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDCellObj : NSObject

@property (strong, nonatomic) NSString *leftImageName;
@property (strong, nonatomic) NSString *titleString;
@property (strong, nonatomic) NSString *commentString;

@property (assign, nonatomic) BOOL expand;
@property (assign, nonatomic) BOOL expanded;

@end
