//
//  DDSearchResult.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-21.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDSearchResult.h"
#import "DDListCell.h"
#import "DDSerachDetailResult.h"

@interface DDSearchResult () <UITableViewDelegate, UITableViewDataSource>
{
    UIImageView *_listBackgroundView; // 清单背景颜色
}

@end

@implementation DDSearchResult

- (void)dealloc
{
    NSLog(@"滚回去了");
    [_listBackgroundView release];
//    [_dataSource release];
    [_goBack release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, kMainViewWidth, kMainViewHeight);
        
        // 初始化大背景
        UIImageView *bottomView = [[UIImageView alloc] init];
        bottomView.frame = kMainViewBounds;
        bottomView.image = [UIImage imageNamed:@"背景"]; // cache
        bottomView.userInteractionEnabled = YES;
        [self addSubview:bottomView];
        [bottomView release];
        
        // 清单背景
        UIImage *listBackgroundImage = kImageWithName(@"down_05");
        _listBackgroundView = [[UIImageView alloc] initWithImage:listBackgroundImage];
        _listBackgroundView.bounds = CGRectMake(0, 0, CGRectGetWidth(bottomView.bounds) * 0.92,
                                                CGRectGetHeight(bottomView.bounds) * 0.92);
        _listBackgroundView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                                 CGRectGetMidY(self.bounds));
        _listBackgroundView.userInteractionEnabled = YES;
        [self addSubview:_listBackgroundView];
        
        CGFloat width = CGRectGetWidth(_listBackgroundView.bounds) * 0.8;
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = [UIFont systemFontOfSize:24];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.bounds = CGRectMake(0, 0, width * 0.2, 40);
        nameLabel.text = @"姓名";
        nameLabel.center = CGPointMake(CGRectGetMidX(nameLabel.bounds) + 20, 70);
        [_listBackgroundView addSubview:nameLabel];
        [nameLabel release];
        
        UILabel *orderLabel = [[UILabel alloc] init];
        orderLabel.textAlignment = NSTextAlignmentCenter;
        orderLabel.font = [UIFont systemFontOfSize:24];
        orderLabel.textColor = [UIColor whiteColor];
        orderLabel.bounds = CGRectMake(0, 0, width * 0.65, 40);
        orderLabel.center = CGPointMake(CGRectGetMaxX(nameLabel.frame) + CGRectGetMidX(orderLabel.bounds) + 20, 70);
        orderLabel.text = @"订单号";
        [_listBackgroundView addSubview:orderLabel];
        [orderLabel release];
        
        UITableView *tableView = [[UITableView alloc] init];
        tableView.bounds = CGRectMake(0, 0, 800, 400);
        tableView.center = CGPointMake(CGRectGetMidX(_listBackgroundView.bounds),
                                       CGRectGetMidY(_listBackgroundView.bounds));
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor clearColor];
        [_listBackgroundView addSubview:tableView];
        [tableView release];

        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        back.bounds = CGRectMake(0, 0, 159, 50);
        back.center = CGPointMake(CGRectGetMidX(_listBackgroundView.bounds),
                                  CGRectGetMaxY(_listBackgroundView.bounds) - CGRectGetMidY(back.bounds) - 20);
        [back setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [back addTarget:self action:@selector(goback:) forControlEvents:UIControlEventTouchUpInside];
        [_listBackgroundView addSubview:back];
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

#pragma mark - UITableView datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (_dataSource) {
        count = _dataSource.count;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SearchResultCell";
    DDListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[DDListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier buttonStyle:DDDetail] autorelease];
    }
    
    if (_dataSource) {
        cell.nameLabel.text = [NSString stringWithFormat:@"%@", _dataSource[indexPath.row][@"purchaser"]];
        cell.orderNumberLabel.text = [NSString stringWithFormat:@"%@" ,_dataSource[indexPath.row][@"order"]];
        __block DDSearchResult *this = self;
        __block UIImageView *imageView = _listBackgroundView;
        cell.buttonTapAction = ^{
            NSLog(@"查看详情");
            __block DDSerachDetailResult *detailResult = [[DDSerachDetailResult alloc] initWithFrame:CGRectZero];
            CGPoint center = CGPointMake(CGRectGetMidX(this.bounds),
                                         CGRectGetMidY(this.bounds));
            detailResult.center =  CGPointMake(3 * center.x, center.y);
            NSLog(@"_dataSource = %@", _dataSource);
            detailResult.serviceStatus = [_dataSource[indexPath.row][@"serviceStatus"] integerValue];
            detailResult.goBack = ^{
                [UIView animateWithDuration:kAnimateDuration animations:^{
                    imageView.center = center;
                    detailResult.center =  CGPointMake(3 * center.x, center.y);
                } completion:^(BOOL finished) {
                    [detailResult removeFromSuperview];
                }];
            };
            
            [UIView animateWithDuration:kAnimateDuration
                             animations:^{
                                 detailResult.center =  CGPointMake(center.x, center.y);
                                 imageView.center = CGPointMake(-2 * center.x, center.y);
                             }];
            
            [this addSubview:detailResult];
            [detailResult release];
        };
        
        
    }
    return cell;
}



@end
