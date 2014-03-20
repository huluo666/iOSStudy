//
//  DDShopcart.m
//  「项目」中国银行
//
//  Created by 萧川 on 3/7/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDShopcart.h"
#import "DDShopCartCell.h"
#import "DDRecordInfo.h"
#import "DDAppDelegate.h"
#import "DDRootViewController.h"
#import "DDChoose.h"

@interface DDShopcart () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic ,retain) NSMutableArray *dataSource;
@property (nonatomic, retain) UITableView *tableView;

@end

@implementation DDShopcart

- (void)dealloc
{
    NSLog(@"%@ is dealloced", [self class]);
    [_dataSource release];
    [_tableView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 获取未处理订单
        NSData *unarchiverData = [[NSData alloc] initWithContentsOfFile:PATH]; // 关联解档管理器与数据
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:unarchiverData];
        // 通过解档管理器和key解档数据
        _dataSource = [[unarchiver decodeObjectForKey:kOrderInfo] retain];
        [unarchiverData release];
        [unarchiver release];
        
        NSLog(@"购物车获取数据：%@", _dataSource);

        // 背景
        UIImage *backgroundImage = kImageWithName(@"down_05");
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
        backgroundView.bounds = self.bounds;
        backgroundView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                            CGRectGetMidY(self.bounds));
        backgroundView.userInteractionEnabled = YES;
        [self addSubview:backgroundView];
        
        // 保存订单
        UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        saveButton.bounds = CGRectMake(0, 0, 159, 50);
        saveButton.center = CGPointMake(CGRectGetMidX(backgroundView.bounds) - CGRectGetMidX(saveButton.bounds) * 1.2,
                                        CGRectGetMaxY(backgroundView.bounds) - CGRectGetMidY(saveButton.bounds) * 2);
        [saveButton setBackgroundImage:kImageWithName(@"save") forState:UIControlStateNormal];
        saveButton.tag = kCartButtonTag;
        [saveButton addTarget:self
                       action:@selector(cartButtonAction:)
             forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:saveButton];
        
        // 提交办理
        UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        submitButton.bounds = CGRectMake(0, 0, 159, 50);
        submitButton.center = CGPointMake(CGRectGetMidX(backgroundView.bounds) + CGRectGetMidX(submitButton.bounds) * 1.2,
                                        CGRectGetMaxY(backgroundView.bounds) - CGRectGetMidY(submitButton.bounds) * 2);
        [submitButton setBackgroundImage:kImageWithName(@"提交办理") forState:UIControlStateNormal];
        submitButton.tag = kCartButtonTag + 1;
        [submitButton addTarget:self
                       action:@selector(cartButtonAction:)
             forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:submitButton];
        
        // 添加
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.bounds = CGRectMake(0, 0, 50, 50);
        addButton.center = CGPointMake(CGRectGetMaxX(backgroundView.bounds) - 60,
                                          CGRectGetMinY(backgroundView.bounds) + 60);
        [addButton setBackgroundImage:kImageWithName(@"+_10") forState:UIControlStateNormal];
        addButton.tag = kCartButtonTag + 2;
        [addButton addTarget:self
                      action:@selector(cartButtonAction:)
            forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:addButton];
        
        // 表头
        // table view
        _tableView = [[UITableView alloc] init];
        _tableView.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds) * 0.95, 350);
        _tableView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds) + 10);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];
    }
    return self;
}

- (void)cartButtonAction:(UIButton *)sender
{
    NSInteger index = sender.tag - kCartButtonTag;
    if (0 == index) {
        // 保存
        DDRecordInfo *record = [[DDRecordInfo alloc] init];
        record.doSomeThing = ^(NSMutableDictionary *dict){
            // 移除自己，跳到选购清单
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = kButtonTag + 3;
            DDRootViewController *root = (DDRootViewController *)[[((DDAppDelegate *)[[UIApplication sharedApplication] delegate]) window] rootViewController];
            DDChoose *choose = (DDChoose *)[root.view subviews][3];
            choose.dataSource = dict;
            [root switchVC:button];
        };
        record.data = _dataSource;
        [kRootView addSubview:record];
        [record release];
    } else if (1 == index) {
        // 提交
    } else {
        // 查询
    }
}


#pragma mark - tableview deletage

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ShopCartCell";
    DDShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[DDShopCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSLog(@"date = %@", _dataSource[indexPath.row]);
    cell.data = _dataSource[indexPath.row];
    return cell;
}


@end
