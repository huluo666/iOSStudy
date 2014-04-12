//
//  DDRefreshBaseView.m
//  「UI」下拉刷新下拉加载
//
//  Created by 萧川 on 14-2-26.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDRefreshBaseView.h"
#import <AudioToolbox/AudioToolbox.h>

@interface DDRefreshBaseView ()
{
    BOOL _hasInsetInit;
    SystemSoundID _soundsID;             // 音效ID
}

// 控件视图类型(PullDown或者PullUp)
- (DDRefreshType)viewType;

// 创建Label
- (UILabel *)labelWithFont:(UIFont *)font;

// 设置刷新状态为普通状态
- (void)setStateNormal;
// 设置刷新状态为刷新状态
- (void)setStateRefreshing;


// 回调方法打包
// 开始刷新
- (void)callbackBeginRefreshing;
// 刷新完成
- (void)callbackDidRefreshing;
// 刷新状态改变
- (void)callbackWithStateChange:(DDRefreshState)state;

// 刷新状态相关
// 是否正在刷新
- (BOOL)isRefreshing;

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
        [self addSubview:_lastUpdate = [[self labelWithFont:
                                         [UIFont systemFontOfSize:12]] retain]];
        // 状态显示标签
        [self addSubview:_status = [[self labelWithFont:
                                     [UIFont systemFontOfSize:14]] retain]];
        // 箭头头提示图片
        UIImageView *arrowView = [[UIImageView alloc]
                                  initWithImage:[UIImage imageNamed:@"arrow"]];
        arrowView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
                                        UIViewAutoresizingFlexibleRightMargin;
        _arrow = [arrowView retain];
        [arrowView release];
        [self addSubview:_arrow];
        
        // 进度指示器
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]
                                              initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.bounds = arrowView.bounds; // arrowView 和 indicator处于同一位置
        arrowView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
                                        UIViewAutoresizingFlexibleRightMargin;
        _indicator = [indicator retain];
        [self addSubview:_indicator];
        [indicator release];
        
        // 默认控件的刷新状态
        [self setState:DDRefreshStateNormal];
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

- (void)removeFromSuperview
{
    [_scrollView removeObserver:self forKeyPath:DDRefreshContentOffSet];
    [super removeFromSuperview];
}

// 刷新加载数据后滚动视图的内容尺寸大小发生改变，需要重新布局，会调用该方法
/* 
 * layoutSubviews在以下情况下会被调用：
 *
 * 1、init初始化不会触发layoutSubviews
 * 2、addSubview会触发layoutSubviews
 * 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
 * 4、滚动一个UIScrollView会触发layoutSubviews
 * 5、旋转Screen会触发父UIView上的layoutSubviews事件
 * 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (!_hasInsetInit) {
        _scrollViewInsetRecord = _scrollView.contentInset;

        [self observeValueForKeyPath:DDRefreshContentSize
                            ofObject:nil
                              change:nil
                             context:nil];
        _hasInsetInit = YES;
        if (_state == DDRefreshStateWillRefreshing) {
            [self setState:DDRefreshStateRefreshing];
        }
    }
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
    _status.frame = CGRectMake(10, 5, width, 20);
    
    // 上次更新时间标签
    _lastUpdate.frame = CGRectMake(15,
                                   10 + CGRectGetHeight(_status.bounds),
                                   width,
                                   20);
    
    // 箭头图标
    _arrow.center = CGPointMake(frame.size.width / 2 - 100,
                                frame.size.height / 2);

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

- (DDRefreshType)viewType
{
    return DDRefreshTypePullDown;
}

// scrollView setter
- (void)setScrollView:(UIScrollView *)scrollView
{
    if (_scrollView != scrollView) {
        // 移除之前的监听
        [_scrollView removeObserver:self
                         forKeyPath:DDRefreshContentOffSet
                            context:nil];
        [_scrollView release];
        
        // 注册监听
        [scrollView addObserver:self
                     forKeyPath:DDRefreshContentOffSet
                        options:NSKeyValueObservingOptionNew
                        context:nil];
        _scrollView = [scrollView retain];
        [_scrollView addSubview:self];
    }
}

// state setter
- (void)setState:(DDRefreshState)state
{
    // 记录当前contentInSet
    if (_state != DDRefreshStateRefreshing) {
        _scrollViewInsetRecord= _scrollView.contentInset;
    }
    
    if (_state == state) {
        return;
    }

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
    
    // 记录刷新状态
    _state = state;
}

#pragma mark - 私有方法

- (UILabel *)labelWithFont:(UIFont *)font
{
    UILabel *label = [[[UILabel alloc] init] autorelease];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = font;
    label.textColor = [UIColor colorWithWhite:0.349 alpha:1.000];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)setStateNormal
{
    NSLog(@"setStateNormal");
    // 停止进度指示器动画
    [_indicator stopAnimating];
    
    // 显示箭头
    _arrow.hidden = NO;
    
    // 刚好刷新完成，回到普通状态
    if (DDRefreshStateRefreshing == _state) {
        [self callbackDidRefreshing];
    }
}

- (void)setStateRefreshing
{
    NSLog(@"setStateRefreshing");
    // 隐藏箭头
    _arrow.hidden = YES;
    
    // 开始进度指示器动画
    [_indicator startAnimating];
    _arrow.transform = CGAffineTransformIdentity;
    
    // 回调
    [self callbackBeginRefreshing];
}

#pragma mark - 监听_scrollView的contentOffSet属性值的变化来做出响应的的反应
#pragma mark KVO方式实现
// 监听回掉函数
// _scrollView的contentOffSet有变化就调用下面的方法
// keyPath:表示监听的key
// object这里表示contentOffSet的值
// change是一个字典，包含了新旧值
// context是上下文
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (![DDRefreshContentOffSet isEqualToString:keyPath]) {
        return;
    }
    if (!self.isUserInteractionEnabled) {
        return;
    }
    if (0 == self.alpha) {
        return;
    }
    if (self.hidden) {
        return;
    }
    
    // 下拉contentOffSetVerticalValue为负数，上拉为正
    CGFloat contentOffSetVerticalValue = _scrollView.contentOffset.y * [self viewType];
    NSLog(@"-----------1: contentOffSetVerticalValue = %f", contentOffSetVerticalValue);
    CGFloat properVerticalPullValue = [self properVerticalPullValue];
    NSLog(@"+++++++++++2: properVerticalPullValue = %f", properVerticalPullValue);

    if (contentOffSetVerticalValue <= properVerticalPullValue) {
        return;
    }
    
    if (_scrollView.isDragging) {
        CGFloat properContentOffSetVerticalValue =
            properVerticalPullValue + DDRefreshViewHeight;
        NSLog(@"============3: properContentOffSetVerticalValue = %f", properContentOffSetVerticalValue);
        NSLog(@"_state : %d", _state);
        
        if (_state == DDRefreshStatePulling &&
            contentOffSetVerticalValue <= properContentOffSetVerticalValue) {
            // 正在拖动，但是拖动的长度还不够,设置为普通状态
            [self setState:DDRefreshStateNormal];
            // 回调
            [self callbackWithStateChange:DDRefreshStateNormal];
        } else if (_state == DDRefreshStateNormal &&
                   contentOffSetVerticalValue > properContentOffSetVerticalValue) {
            // 已经转换为普通状态而且拖动的长度已经满足刷新要求，松手便刷新
            // 转为正在拖住状态
            [self setState:DDRefreshStatePulling];
            [self callbackWithStateChange:DDRefreshStatePulling];
        }
        
    } else {
        // 手松开了，将要刷新
        if (_state == DDRefreshStatePulling) {
            // 如果现在状态是DDRefreshStatePulling就刷新
            [self setState:DDRefreshStateRefreshing];
            [self callbackWithStateChange:DDRefreshStateRefreshing];
        }
    }
}

#pragma mark 回调函数打包

- (void)callbackWithStateChange:(DDRefreshState)state
{
    // 回调方式一，委托
    if (_delegate &&
        [_delegate respondsToSelector:@selector(refreshBaseView:stateChange:)]) {
        [_delegate refreshBaseView:self stateChange:state];
    }
    // 回调方式二，block
    if (_refreshStateChange) {
        _refreshStateChange(self, state);
    }
}

- (void)callbackBeginRefreshing
{
    if (_delegate &&
        [_delegate respondsToSelector:@selector(refreshBaseViewbeginRefreshing:)]) {
        [_delegate refreshBaseViewbeginRefreshing:self];
    }
    
    if (_beginRefreshBaseView) {
        _beginRefreshBaseView(self);
    }
}

- (void)callbackDidRefreshing
{
    // 回调方式一，委托
    if (_delegate &&
        [_delegate respondsToSelector:@selector(refreshBaseViewDidRefreshing:)]) {
        [_delegate refreshBaseViewDidRefreshing:self];
    }
    // 回调方式二，block
    if (_didRefreshBaseView) {
        _didRefreshBaseView(self);
    }
}

#pragma mark - 刷新状态相关

// 是否正在刷新
- (BOOL)isRefreshing
{
    return _state == DDRefreshStateRefreshing  ? YES : NO;
}

// 开始刷新
- (void)beginRefreshing
{
    if (self.window) {
        [self setState:DDRefreshStateRefreshing];
    } else {
        _state = DDRefreshStateWillRefreshing;
    }
}

// 刷新完成
- (void)endRefreshingWithSuccess:(BOOL)success
{
    [self setState:DDRefreshStateNormal];
    if (success) {
        [self playSounds];
    }
}

- (void)playSounds
{
    NSURL *soundsURL = [[NSBundle mainBundle] URLForAuxiliaryExecutable:@"refresh.caf"];
    // 初始化音频资源
    AudioServicesCreateSystemSoundID((CFURLRef)soundsURL, &_soundsID);
    // 播放音乐
    AudioServicesPlaySystemSound(_soundsID);
}

@end