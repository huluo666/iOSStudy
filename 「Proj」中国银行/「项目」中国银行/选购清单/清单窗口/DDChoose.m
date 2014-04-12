//
//  DDChoose.m
//  「项目」中国银行
//
//  Created by 萧川 on 3/7/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDChoose.h"
#import "DDOrderView.h"
#import "DDListCell.h"

@interface DDChoose () <UITableViewDelegate, UITableViewDataSource>
{
    UIImageView *_listBackgroundView; // 清单背景颜色
}

// 提交办理
- (void)submitWithDataSource:(NSDictionary *)dict;

@end

@implementation DDChoose

- (void)dealloc
{
    NSLog(@"%@ is dealloced", [self class]);
    [_listBackgroundView release];
    [_dataSource release];
    [_tableView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, kMainViewWidth, kMainViewHeight);
        
        // 关联解档管理器与数据
        NSData *unarchiverData = [[NSData alloc] initWithContentsOfFile:PATH_ORDER];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]
                                         initForReadingWithData:unarchiverData];
        // 通过解档管理器和key解档数据
        id notProcessOrders = [unarchiver decodeObjectForKey:@"选购清单"];
        [unarchiverData release];
        [unarchiver release];
        
        if ([notProcessOrders isKindOfClass:[NSDictionary class]]) {
            _dataSource = [notProcessOrders retain];
        }
        
        NSLog(@"清单窗口接受到的数据 = %@", _dataSource);
        
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
        orderLabel.center = CGPointMake(CGRectGetMaxX(nameLabel.frame) +
                                        CGRectGetMidX(orderLabel.bounds) + 20, 70);
        orderLabel.text = @"订单号";
        [_listBackgroundView addSubview:orderLabel];
        [orderLabel release];
        
        _tableView = [[UITableView alloc] init];
        _tableView.bounds = CGRectMake(0, 0, 800, 500);
        _tableView.center = CGPointMake(CGRectGetMidX(_listBackgroundView.bounds),
                                       CGRectGetMidY(_listBackgroundView.bounds) + 50);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_listBackgroundView addSubview:_tableView];
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)submitWithDataSource:(NSDictionary *)dict
{
    // 创建订单信息页面
    CGRect frame = CGRectMake(20,
                              20,
                              CGRectGetWidth(_listBackgroundView.bounds),
                              CGRectGetHeight(_listBackgroundView.bounds));
    
    __block DDOrderView *orderView = [[DDOrderView alloc] initWithFrame:frame];
    CGPoint center = _listBackgroundView.center;
    orderView.center = CGPointMake(3 * center.x, center.y);
    orderView.dataSource = dict;
    [self addSubview:orderView];
    [orderView release];

    orderView.swipRight = ^{
        [UIView animateWithDuration:kAnimateDuration animations:^{
            _listBackgroundView.center = center;
            orderView.center =  CGPointMake(3 * center.x, center.y);
        } completion:^(BOOL finished) {
            [orderView removeFromSuperview];
        }];
    };
    
    [UIView animateWithDuration:kAnimateDuration animations:^{
        _listBackgroundView.center = CGPointMake(-center.x, center.y);
        orderView.center = center;
    }];
}

#pragma mark - tableview deletage

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (_dataSource && [_dataSource isKindOfClass:[NSDictionary class]]) {
        count = [_dataSource[@"shoppingList"] count];
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ShopCartCell";
    DDListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[DDListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                 reuseIdentifier:cellIdentifier
                                     buttonStyle:DDSubmit];
    }
    
   
    cell.nameLabel.text = _dataSource[@"name"];
    NSArray *list = _dataSource[@"shoppingList"];
    cell.orderNumberLabel.text = [NSString stringWithFormat:@"%@", list[indexPath.row]];
    __block DDChoose *this = self;
    cell.buttonTapAction = ^{
        NSLog(@"%@", _dataSource);
        // 到订单窗口
        NSString *clientId = [NSString stringWithFormat:@"%@", _dataSource[@"ID"]];
        NSString *clientName = [NSString stringWithFormat:@"%@", _dataSource[@"name"]];
        NSString *clientTel = [NSString stringWithFormat:@"%@" ,_dataSource[@"tel"]];
        NSArray *shoppingList = @[[NSString stringWithFormat:@"%@", _dataSource[@"shoppingList"][indexPath.row]]];
        NSString *userId = [NSString stringWithFormat:@"%@", _dataSource[@"userId"]];
        NSArray *amountList = @[[NSString stringWithFormat:@"%@", _dataSource[@"amount"][indexPath.row]]];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:clientId forKey:@"clientId"];
        [dict setObject:clientName forKey:@"clientName"];
        [dict setObject:clientTel forKey:@"clientTel"];
        [dict setObject:shoppingList forKey:@"shoppingList"];
        [dict setObject:userId forKey:@"userId"];
        [dict setObject:amountList forKey:@"amountList"];
        [this submitWithDataSource:dict];
    };
    return cell;
}

@end
