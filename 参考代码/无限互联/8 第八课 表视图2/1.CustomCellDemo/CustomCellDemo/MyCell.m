//
//  MyCell.m
//  CustomCellDemo
//
//  Created by 周泉 on 13-2-27.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G开发培训中心. All rights reserved.
//

#import "MyCell.h"

@interface MyCell ()

- (void)initSubViews;

@end

@implementation MyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    _label.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_label];
    
    // .....
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _label.frame = CGRectMake(80, 0, 160, 80);
    _label.text = self.text;
    // layout subViews
}

- (void)dealloc
{
    self.text = nil;
    [_label release], _label = nil;
    [super dealloc];
}

@end
