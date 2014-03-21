//
//  DDFinanceProductsView.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-14.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDFinanceProductsView.h"
#import "DDFinancingProductsCell.h"
#import "DDPullDown.h"
#import "DDSelectViewController.h"

@interface DDFinanceProductsView () <
    UITableViewDataSource,
    UITableViewDelegate,
    PMCalendarControllerDelegate,
    UITextFieldDelegate>
{
    UIImageView *_backgroundView;   // 背景图片
    UILabel *_startDataLabel;       // 开始时间标签
    UILabel *_endDataLabel;         // 结束时间标签
    UIPopoverController *_popover;  // 气泡窗口
}

// 创建label
- (UILabel *)labelWithTitle:(NSString *)title;

// 创建有手势的label
- (UILabel *)labelHasTapGesture;

// 创建button
- (UIButton *)buttonWitStateNormalTitle:(NSString *)title;

// button点击处理事件
- (void)financeButtonAction:(UIButton *)sender;

// 日期控件点击处理事件
- (void)dateAction:(UITapGestureRecognizer *)tapGesture;

@end

@implementation DDFinanceProductsView 

- (void)dealloc
{
    NSLog(@"%@ is dealloced", [self class]);
    _startDataLabel = nil;
    _popover = nil;
    [_backgroundView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 背景
        UIImage *backgroundImage = kImageWithName(@"down_05");
        _backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
        _backgroundView.frame = self.bounds;
        _backgroundView.userInteractionEnabled = YES;
        [self addSubview:_backgroundView];

        CGFloat backgroundViewHeight = CGRectGetHeight(_backgroundView.bounds);
        
        // 查询栏
        // 起售日期
        UILabel *fromTimeLabel = [self labelWithTitle:@"起售起始日"];
        fromTimeLabel.center = CGPointMake(CGRectGetMidX(fromTimeLabel.bounds) * 2,
                                           backgroundViewHeight * 0.05);
        [_backgroundView addSubview:fromTimeLabel];

        // 起售日期选择标签
        _startDataLabel = [self labelHasTapGesture];
        _startDataLabel.center = CGPointMake(CGRectGetMaxX(fromTimeLabel.frame) + CGRectGetMidX(_startDataLabel.bounds) + 6,
                                            backgroundViewHeight * 0.05);
        [_backgroundView addSubview:_startDataLabel];

        // UILabel
        UILabel *toTimeLabel = [self labelWithTitle:@"到"];
        toTimeLabel.bounds = CGRectMake(0, 0, 20, 40);
        toTimeLabel.center = CGPointMake(CGRectGetMaxX(_startDataLabel.frame) + CGRectGetMidX(toTimeLabel.bounds) + 6,
                                         backgroundViewHeight * 0.05);
        [_backgroundView addSubview:toTimeLabel];
        
        // 停售日期选择标签
        _endDataLabel = [self labelHasTapGesture];
        _endDataLabel.center = CGPointMake(CGRectGetMaxX(toTimeLabel.frame) + CGRectGetMidX(_endDataLabel.bounds) + 6,
                                          backgroundViewHeight * 0.05);
        [_backgroundView addSubview:_endDataLabel];

        // 投资期限
        UIButton *deadlineButton = [self buttonWitStateNormalTitle:@"投资期限"];
        [deadlineButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        deadlineButton.center = CGPointMake(CGRectGetMaxX(_endDataLabel.frame) + CGRectGetMidX(deadlineButton.bounds) + 6,
                                            backgroundViewHeight * 0.05);
        deadlineButton.tag = kFinanceButtonTag;
        [_backgroundView addSubview:deadlineButton];
        
        // 收益类型
        UIButton *profitTypeButton = [self buttonWitStateNormalTitle:@"收益类型"];
        profitTypeButton.center = CGPointMake(CGRectGetMaxX(deadlineButton.frame) + CGRectGetMidX(profitTypeButton.bounds) + 6,
                                              backgroundViewHeight * 0.05);
        profitTypeButton.tag = kFinanceButtonTag + 1;
        [_backgroundView addSubview:profitTypeButton];

        // 币种
        UIButton *coinTypeButton = [self buttonWitStateNormalTitle:@"币种"];
        coinTypeButton.center =  CGPointMake(CGRectGetMaxX(profitTypeButton.frame) + CGRectGetMidX(coinTypeButton.bounds) + 6,
                                             backgroundViewHeight * 0.05);
        coinTypeButton.tag = kFinanceButtonTag + 2;
        [_backgroundView addSubview:coinTypeButton];
       
        // 搜索框
        UIImage *searchBackgroundImage = kImageWithName(@"搜索框_11");
        UIImageView *imageView = [[UIImageView alloc] initWithImage:searchBackgroundImage];
        imageView.bounds = CGRectMake(0, 0, 230, 40);
        imageView.center = CGPointMake(CGRectGetMaxX(coinTypeButton.frame) + CGRectGetMidX(imageView.bounds) + 16,
                                       backgroundViewHeight * 0.05);
        imageView.userInteractionEnabled = YES;
        [_backgroundView addSubview:imageView];
        [imageView release];
        
        // search bar textfield
        UITextField *searchTextField = [[UITextField alloc] init];
        searchTextField.bounds = CGRectMake(0,
                                            0,
                                            CGRectGetWidth(imageView.bounds) * 0.9,
                                            CGRectGetHeight(imageView.bounds));
        searchTextField.center = CGPointMake(CGRectGetMidX(imageView.bounds), CGRectGetMidY(imageView.bounds));
        searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        searchTextField.textAlignment = NSTextAlignmentLeft;
        searchTextField.placeholder = @"Search";
        searchTextField.leftViewMode = UITextFieldViewModeAlways;
        searchTextField.backgroundColor = [UIColor clearColor];
        [imageView addSubview:searchTextField];
        [searchTextField release];
        
        // tableView
        UITableView *tableView = [[UITableView alloc] init];
        tableView.bounds = CGRectMake(0, 0, CGRectGetWidth(_backgroundView.bounds) * 0.95, 368);
        tableView.center = CGPointMake(CGRectGetMidX(_backgroundView.bounds),
                                       CGRectGetMidY(_backgroundView.bounds));
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 46;
        tableView.backgroundColor = [UIColor clearColor];
        [_backgroundView addSubview:tableView];
        [tableView release];
        
        // 下拉刷新
        DDPullDown *pullDown = [DDPullDown pullDown];
        pullDown.scrollView = tableView;
        pullDown.lastUpdate.textColor = [UIColor whiteColor];
        pullDown.status.textColor = [UIColor whiteColor];
        pullDown.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        pullDown.arrow.image = [UIImage imageNamed:@"blackArrow"]; // cache

        pullDown.beginRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
            NSLog(@"开始刷新");

        };

        // 申请按钮
        UIButton *applicationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        applicationButton.bounds = CGRectMake(0, 0, 159, 50);
        applicationButton.center = CGPointMake(CGRectGetMidX(tableView.frame),
                                               CGRectGetMaxY(tableView.frame) + CGRectGetMidY(applicationButton.bounds) + 50);
        [applicationButton setBackgroundImage:kImageWithName(@"申请")
                                     forState:UIControlStateNormal];
        [applicationButton addTarget:self
                              action:@selector(financeButtonAction:)
                    forControlEvents:UIControlEventTouchUpInside];
        applicationButton.tag = kFinanceButtonTag + 3;
        [_backgroundView addSubview:applicationButton];
        
        UILabel *predictLabel = [[UILabel alloc] init];
        predictLabel.bounds = CGRectMake(0, 0, 115, 50);
        predictLabel.center = CGPointMake(80 + CGRectGetMidX(predictLabel.bounds),
                                          CGRectGetMaxY(tableView.frame) + CGRectGetMidY(predictLabel.bounds));
        predictLabel.text = @"预计收益计算：";
        predictLabel.textColor = [UIColor grayColor];
        predictLabel.font = [UIFont boldSystemFontOfSize:16];
        predictLabel.font = [UIFont systemFontOfSize:16];
        [_backgroundView addSubview:predictLabel];
        [predictLabel release];
        
        // 收益
        UILabel *prfigureLabel = [[UILabel alloc] init];
        prfigureLabel.bounds = CGRectMake(0, 0, 70, 50);
        prfigureLabel.center = CGPointMake(CGRectGetMaxX(predictLabel.frame) + CGRectGetMidX(prfigureLabel.bounds),
                                           CGRectGetMaxY(tableView.frame) + CGRectGetMidY(prfigureLabel.bounds));
        prfigureLabel.text = @"投资金额";
        prfigureLabel.textColor = [UIColor grayColor];
        prfigureLabel.font = [UIFont systemFontOfSize:15];
        prfigureLabel.textAlignment = NSTextAlignmentRight;
        [_backgroundView addSubview:prfigureLabel];
        [prfigureLabel release];
        
        UITextField *prfigureField = [[UITextField alloc] init];
        prfigureField.bounds = CGRectMake(0, 0, 150, 40);
        prfigureField.center = CGPointMake(CGRectGetMaxX(prfigureLabel.frame) + CGRectGetMidX(prfigureField.bounds) + 5,
                                           CGRectGetMidY(prfigureLabel.frame));
        prfigureField.layer.cornerRadius = 5;
        prfigureField.backgroundColor = [UIColor whiteColor];
        prfigureField.delegate = self;
        [_backgroundView addSubview:prfigureField];
        [prfigureField release];
        
        // 单位
        UILabel *unit = [[UILabel alloc] init];
        unit.bounds = CGRectMake(0, 0, 30, 50);
        unit.center = CGPointMake(CGRectGetMaxX(prfigureField.frame) + CGRectGetMidX(unit.bounds) + 5,
                                  CGRectGetMaxY(tableView.frame) + CGRectGetMidY(unit.bounds));
        unit.text = @"万元";
        unit.textColor = [UIColor grayColor];
        unit.font = [UIFont systemFontOfSize:15];
        unit.textAlignment = NSTextAlignmentLeft;
        [_backgroundView addSubview:unit];
        [unit release];
        
        // 预期投资收入
        UILabel *incomeLabel = [[UILabel alloc] init];
        incomeLabel.bounds = CGRectMake(0, 0, 110, 50);
        incomeLabel.center = CGPointMake(CGRectGetMaxX(unit.frame) + CGRectGetMidX(incomeLabel.bounds) + 15,
                                         CGRectGetMaxY(tableView.frame) + CGRectGetMidY(incomeLabel.bounds));
        incomeLabel.text = @"预期投资收益：";
        incomeLabel.textColor = [UIColor grayColor];
        incomeLabel.font = [UIFont systemFontOfSize:15];
        incomeLabel.textAlignment = NSTextAlignmentLeft;
        [_backgroundView addSubview:incomeLabel];
        [incomeLabel release];
        
        
        UITextField *incomeField = [[UITextField alloc] init];
        incomeField.bounds = CGRectMake(0, 0, 150, 40);
        incomeField.center = CGPointMake(CGRectGetMaxX(incomeLabel.frame) + CGRectGetMidX(incomeField.bounds) + 5,
                                         CGRectGetMidY(prfigureField.frame));
        incomeField.layer.cornerRadius = 5;
        incomeField.enabled = NO;
        incomeField.backgroundColor = [UIColor whiteColor];
        [_backgroundView addSubview:incomeField];
        [incomeField release];
        
        // 单位
        UILabel *unitIncome = [[UILabel alloc] init];
        unitIncome.bounds = CGRectMake(0, 0, 30, 50);
        unitIncome.center = CGPointMake(CGRectGetMaxX(incomeField.frame) + CGRectGetMidX(unitIncome.bounds) + 5,
                                        CGRectGetMaxY(tableView.frame) + CGRectGetMidY(unitIncome.bounds));
        unitIncome.text = @"万元";
        unitIncome.textColor = [UIColor grayColor];
        unitIncome.font = [UIFont systemFontOfSize:15];
        unitIncome.textAlignment = NSTextAlignmentLeft;
        [_backgroundView addSubview:unitIncome];
        [unitIncome release];
        
        // 计算
        UIButton *calculateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        calculateButton.bounds = CGRectMake(0, 0, 86, 42);
        calculateButton.center = CGPointMake(CGRectGetMaxX(unitIncome.frame) + CGRectGetMidX(calculateButton.bounds) + 5,
                                             CGRectGetMidY(unitIncome.frame));
        [calculateButton setBackgroundImage:kImageWithName(@"计算_01")
                                   forState:UIControlStateNormal];
        [calculateButton addTarget:self
                            action:@selector(financeButtonAction:)
                  forControlEvents:UIControlEventTouchUpInside];
        calculateButton.tag = kFinanceButtonTag + 4;
        [_backgroundView addSubview:calculateButton];
        
        // tableView每一项对应名称
        NSArray *labelsWidth = @[@"71", @"165", @"55", @"59", @"58", @"90", @"94", @"93", @"93", @"52", @"50"];
        NSArray *titles =  @[@"产品",@"代码",@"投资期限(天)",@"预期收益率(％)",@"起点金额(万元)",@"起售日",@"停售日",@"起息日",@"到期日",@"额度  (亿元)",@"网银"];
        
        CGFloat lastLabelMaxX = 22;
        for (int i = 0; i < labelsWidth.count; i++) {
            UILabel *label = [[UILabel alloc] init];
            label.bounds = CGRectMake(0, 0, [labelsWidth[i] floatValue], 40);
            label.center = CGPointMake(lastLabelMaxX + CGRectGetMidX(label.bounds),
                                       80);
            label.numberOfLines = 2;
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:14];
            label.text = titles[i];
            [_backgroundView addSubview:label];
            [label release];
            lastLabelMaxX = CGRectGetMaxX(label.frame);
        }
    }
    return self;
}

- (UILabel *)labelWithTitle:(NSString *)title
{
    UILabel *label = [[[UILabel alloc] init] autorelease];
    label.textColor = [UIColor lightGrayColor];
    label.bounds = CGRectMake(0, 0, 80, 40);
    label.backgroundColor = [UIColor clearColor];
    label.layer.cornerRadius = 5;
    label.userInteractionEnabled = YES;
    label.font = [UIFont systemFontOfSize:15];
    label.text = title;
    
    return label;
}

- (UILabel *)labelHasTapGesture
{
    UILabel *label = [self labelWithTitle:nil];
    label.textColor = [UIColor grayColor];
    label.backgroundColor = [UIColor whiteColor];
 
    // 添加点击事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(dateAction:)];
    tapGesture.numberOfTapsRequired = 1;
    [label addGestureRecognizer:tapGesture];
    [tapGesture release];
    
    return label;
}

- (UIButton *)buttonWitStateNormalTitle:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, 100, 40);
    button.layer.borderColor = [UIColor grayColor].CGColor;
    button.layer.borderWidth = 1.0f;
    button.layer.cornerRadius = 5;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.bounds = CGRectMake(0, 0, 100, 40);
    [button addTarget:self
                        action:@selector(financeButtonAction:)
              forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)financeButtonAction:(UIButton *)sender
{
    NSInteger index = sender.tag - kFinanceButtonTag;
    switch (index) {
        case 0: {
            // 投资期限
            if (_popover.popoverVisible) {
                [_popover dismissPopoverAnimated:YES];
                [_popover release];
                _popover = nil;
            }
            
            if (_popover != nil) {
                [_popover release];
                _popover = nil;
            }
            
//            DDDeadlineViewController *deadlineVC = [[DDDeadlineViewController alloc] init];
            DDSelectViewController *deadlineVC = [[DDSelectViewController alloc]
                                                  initWithStyle:UITableViewStylePlain
                                                  dataSource:nil];
            _popover = [[UIPopoverController alloc] initWithContentViewController:deadlineVC];
            [deadlineVC release];
            _popover.popoverContentSize = CGSizeMake(150, 200);
            CGRect rect = CGRectMake(0, 0, 740, 50);
            [_popover presentPopoverFromRect:rect
                                     inView:self
                   permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        
            if (_popover.popoverVisible) {
                NSLog(@"kejian");
            }
        }
            break;
        case 1: {
            // 收益类型
            if (_popover.popoverVisible) {
                [_popover dismissPopoverAnimated:YES];
                _popover = nil;
            }
//            DDProfitTypeViewController *profitType = [[DDProfitTypeViewController alloc] init];
            DDSelectViewController *profitType = [[DDSelectViewController alloc]
                                                  initWithStyle:UITableViewStylePlain
                                                  dataSource:nil];
            _popover = [[UIPopoverController alloc] initWithContentViewController:profitType];
            [profitType release];
            _popover.popoverContentSize = CGSizeMake(150, 200);
            CGRect rect = CGRectMake(0, 0, 960, 50);
            [_popover presentPopoverFromRect:rect
                                      inView:self
                    permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }
            break;
        case 2: {
            // 币种
            if (_popover.popoverVisible) {
                [_popover dismissPopoverAnimated:YES];
                _popover = nil;
            }
//            DDCoinTypeViewController *coinType = [[DDCoinTypeViewController alloc] init];
            DDSelectViewController *coinType = [[DDSelectViewController alloc]
                                                  initWithStyle:UITableViewStylePlain
                                                  dataSource:nil];
            _popover = [[UIPopoverController alloc] initWithContentViewController:coinType];
            [coinType release];
            _popover.popoverContentSize = CGSizeMake(150, 200);
            CGRect rect = CGRectMake(0, 0, 1180, 50);
            [_popover presentPopoverFromRect:rect
                                      inView:self
                    permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];

        }
            break;
        case 3: {
            // 申请
            
        }
            break;
        case 4: {
            // 计算
            
        }
            break;
        default:
            break;
    }
    
}

- (void)dateAction:(UITapGestureRecognizer *)tapGesture
{
    // 日期选择控件
    PMCalendarController *pmCC = [[PMCalendarController alloc] init];
    pmCC.delegate = self;
    pmCC.mondayFirstDayOfWeek = YES;
    
    CGRect rect = CGRectMake(0, 0, 380, 40);
    [pmCC presentCalendarFromRect:rect
                           inView:self
         permittedArrowDirections:PMCalendarArrowDirectionUp
                         animated:YES];
    [pmCC release];
    pmCC = nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

#pragma mark - <PMCalendarControllerDelegate>

- (BOOL)calendarControllerShouldDismissCalendar:(PMCalendarController *)calendarController
{
    return YES;
}

- (void)calendarControllerDidDismissCalendar:(PMCalendarController *)calendarController
{
    NSLog(@"dismissed");
}

- (void)calendarController:(PMCalendarController *)calendarController
           didChangePeriod:(PMPeriod *)newPeriod
{
    _startDataLabel.text = [NSString stringWithFormat:@"%@" ,
                            [newPeriod.startDate dateStringWithFormat:@"dd-MM-yyyy"]];
    _endDataLabel.text = [NSString stringWithFormat:@"%@" ,
                          [newPeriod.endDate dateStringWithFormat:@"dd-MM-yyyy"]];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier  = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[[DDFinancingProductsCell alloc]
                 initWithStyle:UITableViewCellStyleValue2
                 reuseIdentifier:identifier] autorelease];
    }
    return cell;
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // 向上移动位置
    CGPoint backgroundViewCenter = _backgroundView.center;
    [UIView animateWithDuration:kAnimateDuration / 2
                     animations:^{
        _backgroundView.center = CGPointMake(backgroundViewCenter.x,
                                             backgroundViewCenter.y - 350);

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
                                             backgroundViewCenter.y + 350);
    }];
}

@end
