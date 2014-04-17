//
//  DDMacroDefinition.h
//  面试职通车
//
//  Created by 萧川 on 14-4-16.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#ifndef ______DDMacroDefinition_h
#define ______DDMacroDefinition_h

#endif


// 萧川
#ifndef XIAOCHUAN
#define XIAOCHUAN

#import "UrlDefines.h"
#import "DDViewController.h"

#define DDAPIURL(SHORTURL) [BaseUrl_ stringByAppendingPathComponent:SHORTURL]
#define echo() NSLog(@"%@", content)

#define DDImageWithName(NAME) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:NAME ofType:@"png"]]
#define kRandomColor [UIColor colorWithRed:arc4random() % 128 / 255.0f green:arc4random() % 64 / 255.0f blue:arc4random() % 255 / 255.0f alpha:1.000]

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
//主色--蓝色
#define kBlueColor [UIColor colorWithRed:21/255.0f green:200/255.0f blue:223/255.0f alpha:1]

#endif

#ifndef YIYUAN
#define YIYUAN

// 易愿

#endif

// 廖天真
#ifndef LIAOTIANZHEN
#define LIAOTIANZHEN


#endif