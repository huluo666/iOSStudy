//
//  DDSerachDetailResult.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-21.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDSerachDetailResult.h"

@interface DDSerachDetailResult ()

@property (retain, nonatomic) UIImageView *status;

@end

@implementation DDSerachDetailResult

- (void)dealloc
{
    NSLog(@"%@ 滚回去了", [self class]);
    [_goBack release];
    [_status release];
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
        UIImageView *backgroundView = [[UIImageView alloc] init];
        backgroundView.bounds = CGRectMake(0, 0, CGRectGetWidth(bottomView.bounds) * 0.92,
                                            CGRectGetHeight(bottomView.bounds) * 0.90);
        backgroundView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                             CGRectGetMidY(self.bounds) * 0.98);
        
        backgroundView.image = kImageWithName(@"di_05");
        backgroundView.userInteractionEnabled = YES;
        [self addSubview:backgroundView];
        [backgroundView release];

        _status = [[UIImageView alloc] init];
        _status.bounds = CGRectMake(0, 0, 530, 60);
        _status.center = CGPointMake(CGRectGetMidX(backgroundView.bounds),
                                    CGRectGetMidY(backgroundView.bounds));
        [backgroundView addSubview:_status];
        
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        back.bounds = CGRectMake(0, 0, 159, 50);
        back.center = CGPointMake(CGRectGetMidX(backgroundView.bounds),
                                  CGRectGetMaxY(backgroundView.bounds) -
                                  CGRectGetMidY(back.bounds) - 20);
        [back setBackgroundImage:[UIImage imageNamed:@"返回"]
                        forState:UIControlStateNormal];
        [back addTarget:self
                 action:@selector(goback:)
       forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:back];
    }
    return self;
}

- (void)goback:(UIButton *)sender
{
    // 滚回去
    if (_goBack) {
        NSLog(@"滚回去");
        _goBack();
    }
}

- (void)setServiceStatus:(NSInteger)serviceStatus
{
    switch (serviceStatus) {
        case 1: {
            _status.image = kImageWithName(@"1_19");
        }
            break;
        case 2: {
            _status.image = kImageWithName(@"2_19");
        }
            break;
        case 3: {
            _status.image = kImageWithName(@"3_19");
        }
            break;
        default:
            break;
    }
}


@end
