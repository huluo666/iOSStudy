//
//  DDRefreshBaseView.m
//  「UI」下拉刷新下拉加载
//
//  Created by 萧川 on 14-2-26.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDRefreshBaseView.h"

@interface DDRefreshBaseView ()
{
    UIEdgeInsets _scrollViewInset;     // 扩展视图大小
    
    UILabel *_lastUpdate;               // 上次更新时间
    UILabel *_status;                   // 状态
    UIImageView *_arrow;                // 箭头图标
    UIActivityIndicatorView *_indicator; // 进度指示器
    
    DDRefreshState _state;              // 刷新状态
    
}

@end

@implementation DDRefreshBaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWihtScrollView:(UIScrollView *)scrollView
{
    if (self = [super init]) {
        _scrollView = [scrollView retain];
    }
    return self;
}

- (void)dealloc
{
    [_scrollView release];
    [_lastUpdate release];
    [_status release];
    [_arrow release];
    [_indicator release];
    [super dealloc];
}

- (void)layoutSubviews
{

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
