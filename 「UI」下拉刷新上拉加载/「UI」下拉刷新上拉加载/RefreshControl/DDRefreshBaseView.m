//
//  DDRefreshBaseView.m
//  「UI」下拉刷新下拉加载
//
//  Created by 萧川 on 14-2-26.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDRefreshBaseView.h"
#import "DDRefreshControlConst.h"

@interface DDRefreshBaseView ()
{
    UIEdgeInsets _scrollViewInset;     // 扩展视图大小
    
    UILabel *_lastUpdate;               // 上次更新时间
    UILabel *_status;                   // 状态显示
    UIImageView *_arrow;                // 箭头图标
    UIActivityIndicatorView *_indicator; // 进度指示器
    
    DDRefreshState _state;              // 刷新状态
}

// 创建Label
- (UILabel *)labelWithFont:(UIFont *)font;

// 设置刷新状态为普通状态
- (void)setStateNormal;
// 设置刷新状态为刷新状态
- (void)setStateRefreshing;


// 监听事件回应方法
// 刷新状态改变
- (void)responseMonitorWithStateChange:(DDRefreshState)state;
// 结束刷新
- (void)responseMonitorDidRefreshing;
// 开始刷新
- (void)responseMonitorBegainRefreshing;

@end

@implementation DDRefreshBaseView

#pragma mark - 复写构造方法

// 复写初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 属性
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor clearColor];
        // 时间显示标签
        [self addSubview:_lastUpdate = [[self labelWithFont:[UIFont systemFontOfSize:12]] retain]];
        // 状态显示标签
        [self addSubview:_status = [[self labelWithFont:[UIFont systemFontOfSize:14]] retain]];
        // 箭头头提示图片
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
        arrowView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _arrow = [arrowView retain];
        [arrowView release];
        [self addSubview:_arrow];
        
        // 进度指示器
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]
                                              initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.bounds = arrowView.bounds; // arrowView 和 indicator处于同一位置
        arrowView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _indicator = [indicator retain];
        [indicator release];
        [self addSubview:_indicator];
        
        // 默认控件的状态
        [self setState:DDRefreshStateNormal];
        
        _viewType = DDRefreshTypeHeader;
        _minScrollCoordinateY = 0;
    }
    
    return self;
}

// 复写初始化方法
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

#pragma mark - 复写setter

// frame setter
- (void)setFrame:(CGRect)frame
{
    // 限制控件高度为固定值
    frame.size.height = DDRefreshViewHeight;
    [super setFrame:frame];
    
    // 获取控件尺寸大小
    CGFloat height = frame.size.height;
    CGFloat width  = frame.size.width;
    
    // 排序不合格情况
    if (width == 0 || height/2 == _arrow.center.y) {
        return;
    }
    
    // 设置各个控件的位置
    // 状态标签
    _status.frame = CGRectMake(0, 5, width, 20);

    // 上次更新时间标签
    _lastUpdate.frame = CGRectMake(0, 10 + CGRectGetHeight(_status.bounds), width, 20);
    
    // 剪头图标
    _arrow.center = CGPointMake(CGRectGetMidX(self.frame) - 100, CGRectGetMidY(self.frame));
    
    // 进度指示器
    _indicator.center = _arrow.center;
}

// bounds setter
- (void)setBounds:(CGRect)bounds
{
    bounds.size.height = DDRefreshViewHeight;
    [super setBounds:bounds];
}

#pragma mark - 本类setter、getter

// scrollView setter
- (void)setScrollView:(UIScrollView *)scrollView
{
#pragma mark - TODO
    
    if (_scrollView != scrollView) {
        [_scrollView release];
        _scrollView = [scrollView retain];
    }
    [_scrollView addSubview:self];
}

// state setter
- (void)setState:(DDRefreshState)state
{
    // 记录当前contentInSet
//    if (_state != DDRefreshStateRefreshing) {
//         _scrollViewInitInset = _scrollView.contentInset;
//    }
    
    if (_state == state) {
        return;
    }
#pragma mark - TODO
#pragma mark - TODO

    switch (state) {
        // 普通状态
        case DDRefreshStateNormal:
            [self setStateNormal];
            break;
        // 刷新状态
        case DDRefreshStateRefreshing:
            [self setStateRefreshing];
            break;
        default:
            break;
    }
}


//- (void)layoutSubviews
//{
//#pragma mark - TODO
//}

#pragma mark - 私有方法

- (UILabel *)labelWithFont:(UIFont *)font
{
    UILabel *label = [[[UILabel alloc] init] autorelease];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = font;
    label.textColor = [UIColor colorWithRed:0.188 green:0.338 blue:1.000 alpha:1.000];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}


- (void)setStateNormal
{
    // 停止进度指示器动画
    [_indicator stopAnimating];
    // 显示箭头
    _arrow.hidden = NO;
    if (DDRefreshStateRefreshing == _state) { // 刷新完成，回到普通状态
        
    }
}

#pragma mark - 监听_scrollView的contentOffSet属性值的变化来做出响应的的反应
#pragma mark KVO方式实现
// 监听回掉函数
// _scrollView的contentOffSet有变化就调用下面的方法
// keyPath:表示监听的key
// object表示contentOffSet的值
// change是一个字典，包含了新旧值
// context是私有变量
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 只监听contentOffSet
    if (![DDRefreshContentOffSet isEqualToString:keyPath]) {
        return;
    }
    // 排除不适合监听的情况
#pragma mark - maybe error
    if (!self.isUserInteractionEnabled ||
        self.alpha == 0 ||
        self.hidden ||
        _state == DDRefreshStateRefreshing
        ) {
        return;
    }
    
    // scrollView所滚动的Y值大于多少才调用
    CGFloat number = 1;
    if (_viewType == DDRefreshTypeFooter) {
        number = -1;
    }
    CGFloat offSetY = _scrollView.contentOffset.y * number;
#pragma maybe error
    if (offSetY <= _minScrollCoordinateY) {
        return;
    }
    
    // 拖动滚动视图控件开始监听
    if (_scrollView.isDragging) {
        CGFloat validOffSetY = _minScrollCoordinateY + DDRefreshViewHeight;
        if (_state == DDRefreshStatePullOrDrop && offSetY <= validOffSetY) { // 正在拖动但是拖动距离不够
            // 转为普通状态
            [self responseMonitorWithStateChange:DDRefreshStateNormal];
        } else if (_state == DDRefreshStatePullOrDrop && offSetY > validOffSetY){ // 满足刷新条件,即将刷新
            // 设置为即将刷新状态
            [self responseMonitorWithStateChange:DDRefreshStateWillRefreshing];
        } else { // 松开，开始刷新
            // 设置为正在刷新状态
            [self responseMonitorWithStateChange:DDRefreshStateRefreshing];
        }
    }
}

#pragma mark 监听事件处理函数打包

- (void)responseMonitorWithStateChange:(DDRefreshState)state
{
    // 转为state状态
    [self setState:state];
    // 回调方式一，委托
    if (_delegate && [_delegate respondsToSelector:@selector(refreshBaseView:stateChange:)]) {
        [_delegate refreshBaseView:self stateChange:state];
    }
    // 回调方式二，block
    if (_refreshStateChange) {
        _refreshStateChange(self, state);
    }
}

#pragma mark - 刷新状态

// 是否正在刷新
- (BOOL)isRefreshing
{
    return _state == DDRefreshStateRefreshing;
}

// 开始刷新
- (void)beginRefreshing
{
#pragma mark - may be error
    if (self) {
        [self setState:DDRefreshStateRefreshing];
    } else {
        _state = DDRefreshStateWillRefreshing;
    }
}

// 刷新完成
- (void)endRefreshing
{
#pragma mark - may be error
    [self setState:DDRefreshStateNormal];
}

// 不静止地刷新
- (void)endRefreshingWithoutIdle
{
    [self endRefreshing];
}

// 释放资源
- (void)free
{

}

@end





























