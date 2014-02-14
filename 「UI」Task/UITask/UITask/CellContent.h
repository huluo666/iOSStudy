//
//  CellContent.h
//  UITask
//
//  Created by 萧川 on 14-2-14.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellContent : NSObject

@property (retain, nonatomic) NSString *imageName;
@property (retain, nonatomic) NSString *text;
@property (retain, nonatomic) NSString *detailText;

+ (id)cellContentWithImageName:(NSString *)imageName
                          text:(NSString *)text
                    deatilText:(NSString *)detailText;

@end
