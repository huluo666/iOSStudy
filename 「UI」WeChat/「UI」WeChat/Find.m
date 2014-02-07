//
//  Find.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-3.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Find.h"

@implementation Find

- (void)dealloc
{
    [_leftImage release];
    [_rightImage release];
    [_name release];
    [super dealloc];
}

+ (id)findWithName:(NSString *)name leftImage:(UIImage *)leftImage rightImage:(UIImage *)rightImage
{
    Find *find      = [[[Find alloc] init] autorelease];
    find.name       = name;
    find.leftImage  = leftImage;
    find.rightImage = rightImage;
    return find;
}

@end
