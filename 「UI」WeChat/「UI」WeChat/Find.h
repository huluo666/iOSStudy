//
//  Find.h
//  「UI」WeChat
//
//  Created by cuan on 14-2-3.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Find : NSObject

@property (retain, nonatomic) UIImage *leftImage;
@property (copy, nonatomic) NSString *name;
@property (retain, nonatomic) UIImage *rightImage;

+ (id)findWithName:(NSString *)name leftImage:(UIImage *)leftImage rightImage:(UIImage *)rightImage;

@end
