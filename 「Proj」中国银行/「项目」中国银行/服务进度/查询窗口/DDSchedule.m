//
//  DDSchedule.m
//  「项目」中国银行
//
//  Created by 萧川 on 3/7/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDSchedule.h"
#import "DDSearchResult.h"

@interface DDSchedule () <UITextFieldDelegate, UITextFieldDelegate>
{
    UIImageView *_backgroundView;    // 查询背景图片
    UITextField *_searchField;       // 查询输入框
}

// 查询
- (void)search:(UIButton *)sender;

@end

@implementation DDSchedule

- (void)dealloc
{
    NSLog(@"%@ is dealloced", [self class]);
    [_backgroundView release];
    [_searchField release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, kMainViewWidth, kMainViewHeight);
        
        // 背景
        UIImageView *bottomView = [[UIImageView alloc] init];
        bottomView.frame = kMainViewBounds;
        bottomView.image = [UIImage imageNamed:@"背景"]; // cache
        bottomView.userInteractionEnabled = YES;
        [self addSubview:bottomView];
        [bottomView release];
        
        // 查询背景
        _backgroundView = [[UIImageView alloc] init];
        _backgroundView.bounds = CGRectMake(0, 0, CGRectGetWidth(bottomView.bounds) * 0.92,
                                           CGRectGetHeight(bottomView.bounds) * 0.90);
        _backgroundView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                            CGRectGetMidY(self.bounds) * 0.98);

        _backgroundView.image = kImageWithName(@"di_05");
        _backgroundView.userInteractionEnabled = YES;
        [self addSubview:_backgroundView];
        
        // 显示文字
        UILabel *scheduleLabel = [[UILabel alloc] init];
        scheduleLabel.bounds = CGRectMake(0, 0, 350, 80);
        scheduleLabel.center = CGPointMake(CGRectGetMidX(_backgroundView.bounds),
                                           CGRectGetMidY(_backgroundView.bounds) * 0.6);
        scheduleLabel.font = [UIFont systemFontOfSize:24];
        scheduleLabel.font = [UIFont boldSystemFontOfSize:24];
        scheduleLabel.textColor = [UIColor blackColor];
        scheduleLabel.textAlignment = NSTextAlignmentCenter;
        scheduleLabel.text = @"服务进度查询";
        [_backgroundView addSubview:scheduleLabel];
        [scheduleLabel release];
        
        // 查询框
        UIImage *searchImage = kImageWithName(@"search_48");
        UIImageView *searchView = [[UIImageView alloc] initWithImage:searchImage];
        searchView.bounds = CGRectMake(0, 0, 429, 40);
        searchView.center = CGPointMake(CGRectGetMidX(_backgroundView.bounds),
                                        CGRectGetMidY(_backgroundView.bounds));
        searchView.userInteractionEnabled = YES;
        [_backgroundView addSubview:searchView];
        [searchView release];
        
        // 查询文本输入框
        _searchField = [[UITextField alloc] init];
        _searchField.bounds = CGRectMake(0,
                                         0,
                                         CGRectGetWidth(searchView.bounds) * 0.8,
                                         CGRectGetHeight(searchView.bounds));
        _searchField.center = CGPointMake(CGRectGetMidX(searchView.bounds),
                                          CGRectGetMidY(searchView.bounds));
        _searchField.placeholder = @"Serach";
        _searchField.returnKeyType = UIReturnKeySearch;
        _searchField.enablesReturnKeyAutomatically = YES;
        _searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchField.delegate = self;
        [searchView addSubview:_searchField];
        
        // 查询按钮
        UIButton *submitSearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        submitSearchButton.bounds = CGRectMake(0, 0, 30, 30);
        submitSearchButton.center = CGPointMake(CGRectGetMaxX(searchView.bounds) -
                                                CGRectGetMidX(submitSearchButton.bounds) * 1.2,
                                                CGRectGetMidY(searchView.bounds));
        [submitSearchButton setBackgroundImage:kImageWithName(@"search-1_76")
                                      forState:UIControlStateNormal];
        [submitSearchButton setBackgroundImage:kImageWithName(@"search1_23")
                                      forState:UIControlStateHighlighted];
        [submitSearchButton addTarget:self
                               action:@selector(search:)
                     forControlEvents:UIControlEventTouchUpInside];
        [searchView addSubview:submitSearchButton];

    }
    return self;
}

- (void)search:(UIButton *)sender
{
    if (0 ==_searchField.text.length) {
        return;
    }
    [DDHTTPManager sendRequestForProgressWithKeywords:_searchField.text
                                             pageSize:@"10"
                                           pageNumber:@"1"
                                               userId:[[NSUserDefaults standardUserDefaults]
                                                       objectForKey:kUserInfoId]
                                    completionHandler:^(id content, NSString *resultCode) {
        echo();
        // 加载查询结果页面
        __block DDSearchResult *result = [[DDSearchResult alloc] initWithFrame:CGRectZero];
        CGPoint center = CGPointMake(CGRectGetMidX(self.bounds),
                                     CGRectGetMidY(self.bounds));
        result.center =  CGPointMake(3 * center.x, center.y);
        
        if ([content isKindOfClass:[NSArray class]]) {
            result.dataSource = content;
        }
        
        
        result.goBack = ^{
            [UIView animateWithDuration:kAnimateDuration
                             animations:^{
                _backgroundView.center = center;
                result.center =  CGPointMake(3 * center.x, center.y);
            } completion:^(BOOL finished) {
                [result removeFromSuperview];
            }];
        };
        
        [UIView animateWithDuration:kAnimateDuration
                         animations:^{
             result.center =  CGPointMake(center.x, center.y);
             _backgroundView.center = CGPointMake(-2 * center.x, center.y);
         }];
        [self addSubview:result];
        [result release];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // 向上移动位置
    CGPoint backgroundViewCenter = _backgroundView.center;
    [UIView animateWithDuration:kAnimateDuration / 2
                     animations:^{
         _backgroundView.center = CGPointMake(backgroundViewCenter.x,
                                              backgroundViewCenter.y - 150);
     }];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // 向下移动位置
    CGPoint backgroundViewCenter = _backgroundView.center;
    [UIView animateWithDuration:kAnimateDuration / 2
                     animations:^{
         _backgroundView.center = CGPointMake(backgroundViewCenter.x,
                                              backgroundViewCenter.y + 150);
     }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL shouldReturn = NO;
    if (_searchField.text && _searchField.text.length > 0) {
        shouldReturn = YES;
        [self search:nil];
        [self endEditing:YES];
    }
    return shouldReturn;
}

// 限制长度，过滤输入

@end
