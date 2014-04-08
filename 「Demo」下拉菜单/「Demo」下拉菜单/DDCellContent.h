//
//  DDCellContent.h
//  「Demo」下拉菜单
//
//  Created by 萧川 on 14-4-8.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDCellContent : NSObject

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *selectedImageName;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *commentString;

@property (nonatomic, assign) BOOL expand;

@property (nonatomic, assign) NSInteger row;

@end
