//
//  CellContent.m
//  UITask
//
//  Created by 萧川 on 14-2-14.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "CellContent.h"

@implementation CellContent

- (void)dealloc
{
    [_imageName release];
    [_text release];
    [_detailText release];
    [super dealloc];
}

+ (id)cellContentWithImageName:(NSString *)imageName
                          text:(NSString *)text
                    deatilText:(NSString *)detailText
{
    CellContent *cellContent = [[[CellContent alloc] init] autorelease];
    cellContent.imageName = imageName;
    cellContent.text = text;
    cellContent.detailText = detailText;
    return cellContent;
}

@end
