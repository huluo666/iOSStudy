//
//  DDFinancing.m
//  「项目」中国银行
//
//  Created by 萧川 on 3/7/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDFinancing.h"
#import "PMCalendar.h"

@interface DDFinancing () <
    PMCalendarControllerDelegate,
    UITableViewDataSource,
    UITableViewDelegate>
{
    UISegmentedControl *_segmentedControl;      // 分段控件
    NSArray *_images;                           // 未选中状态标题图片
    NSArray *_imgaesSelected;                   // 选中状态标题图片
    
    UIView *_currentSelectedView;               // 当前选中的分段控件视图
    
    NSInteger _currentSelectedSegmentIndex;     // 当前选中分段索引
    
    UILabel *_startDataLabel;                   // 开始时间标签
    UILabel *_endDataLabel;                     // 结束时间标签
}

// 选中事件
- (void)segmentAction:(UISegmentedControl *)sender;
// 选中segment
- (void)selectedIndex:(NSInteger)index;

// 加载理财产品视图
- (void)loadFinanceProductsView;
// 单击事件
- (void)dateAction:(UITapGestureRecognizer *)tapGesture;

// 加载基金产品视图
- (void)loadFundsView;
// 加载贵金属产品视图
- (void)loadPreciousMetalView;
// 加载保险产品视图
- (void)loadInsuranceView;

@end

@implementation DDFinancing

- (void)dealloc
{
    _segmentedControl = nil;
    [_images release];
    [_imgaesSelected release];
    _currentSelectedView = nil;
    _startDataLabel = nil;
    _endDataLabel = nil;
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, kMainViewWidth, kMainViewHeight);
        // 初始化背景
        UIImageView *bottomView = [[[UIImageView alloc] init] autorelease];
        bottomView.frame = kMainViewBounds;
        bottomView.image = [UIImage imageNamed:@"背景"];
        bottomView.userInteractionEnabled = YES;
        [self addSubview:bottomView];
        
        // 分段控件标题
        UIImage *financeProducts = [UIImage imageNamed:@"1_08"];
        UIImage *funds = [UIImage imageNamed:@"2_09"];
        UIImage *preciousMetal = [UIImage imageNamed:@"3_10"];
        UIImage *insurance = [UIImage imageNamed:@"4_11"];
        if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)]) {
            financeProducts = [financeProducts imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            funds = [funds imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            preciousMetal = [preciousMetal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            insurance = [insurance imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        _images = [@[financeProducts, funds, preciousMetal, insurance] retain];
        
        // 分段标题选中状态
        UIImage *financeProductsSelected = [UIImage imageNamed:@"理财产品_08"];
        UIImage *fundsSelected = [UIImage imageNamed:@"基金_09"];
        UIImage *preciousMetalSelected = [UIImage imageNamed:@"贵金属_10"];
        UIImage *insuranceSelected = [UIImage imageNamed:@"保险_11"];
        if ([UIImage instancesRespondToSelector:@selector(imageWithRenderingMode:)]) {
            financeProductsSelected = [financeProductsSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            fundsSelected = [fundsSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            preciousMetalSelected = [preciousMetalSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            insuranceSelected = [insuranceSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        _imgaesSelected = [@[financeProductsSelected, fundsSelected, preciousMetalSelected, insuranceSelected] retain];
        
        // 分段控件
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:_images];
        segmentedControl.tintColor = [UIColor clearColor];
        segmentedControl.bounds = CGRectMake(0, 0, 472, 40);
        segmentedControl.center = CGPointMake(CGRectGetMidX(self.bounds), 40);
        [segmentedControl addTarget:self action:@selector(segmentAction:)
                   forControlEvents:UIControlEventValueChanged];
        [self addSubview:segmentedControl];
        _segmentedControl = segmentedControl;
        [segmentedControl release];
        
        // 分段控件下面的阴影
        UIImageView *shadowView = [[UIImageView alloc] init];
        shadowView.bounds = CGRectMake(0, 0, CGRectGetWidth(segmentedControl.bounds), 10);
        shadowView.center = CGPointMake(CGRectGetMidX(segmentedControl.frame),
                                        CGRectGetMaxY(segmentedControl.frame) + CGRectGetMidY(shadowView.bounds));
        shadowView.image = [UIImage imageNamed:@"pshadow_08"];
        [self addSubview:shadowView];
        [shadowView release];
    
        // 默认选中第一个
        _currentSelectedSegmentIndex = 1;
        [self loadFinanceProductsView];
    }
    return self;
}

- (void)segmentAction:(UISegmentedControl *)sender
{
    NSUInteger index = sender.selectedSegmentIndex;
    switch (index) {
        case 0:
            [self loadFinanceProductsView];
            break;
        case 1:
            [self loadFundsView];
            break;
        case 2:
            [self loadPreciousMetalView];
            break;
        case 3:
            [self loadInsuranceView];
            break;
        default:
            break;
    }
}

- (void)loadFinanceProductsView
{
    // 切换选中状态
    [self selectedIndex:0];

    // 加载自己所属分段控件的视图
    UIImage *backgroundImage = [UIImage imageNamed:@"down_05"];
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
    backgroundView.bounds = CGRectMake(0, 0, kMainViewWidth * 0.98, kMainViewHeight * 0.85);
    backgroundView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                        CGRectGetMidY(backgroundView.bounds) + CGRectGetMaxY(_segmentedControl.frame) * 1.3);
    backgroundView.userInteractionEnabled = YES;
    [self addSubview:backgroundView];
    [backgroundView release];
    _currentSelectedView = backgroundView;
    
    CGFloat backgroundViewWidth = CGRectGetWidth(backgroundView.bounds);
    CGFloat backgroundViewHeight = CGRectGetHeight(backgroundView.bounds);
    
    // 查询栏
    // 起售日期
    UILabel *fromTimeLabel = [[UILabel alloc] init];
    fromTimeLabel.textColor = [UIColor lightGrayColor];
    fromTimeLabel.bounds = CGRectMake(0,
                                      0,
                                      backgroundViewWidth * 0.1,
                                      40);
    fromTimeLabel.center = CGPointMake(CGRectGetMidX(fromTimeLabel.bounds) * 1.2,
                                       backgroundViewHeight * 0.05);
    fromTimeLabel.text = @"起售起始日";
    fromTimeLabel.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:fromTimeLabel];
    [fromTimeLabel release];
    
    // 起售日期选择标签
    UILabel *startDataLabel = [[UILabel alloc] init];
    startDataLabel.bounds = CGRectMake(0,
                                       0,
                                       backgroundViewWidth * 0.1,
                                       40);
    startDataLabel.center = CGPointMake(CGRectGetMaxX(fromTimeLabel.frame) + CGRectGetMidX(startDataLabel.bounds) + 6,
                                        backgroundViewHeight * 0.05);
    startDataLabel.layer.cornerRadius = 5;
    startDataLabel.userInteractionEnabled = YES;
    startDataLabel.textColor = [UIColor grayColor];
    startDataLabel.backgroundColor = [UIColor whiteColor];
    _startDataLabel = startDataLabel;
    [backgroundView addSubview:startDataLabel];
    [startDataLabel release];
    // 添加点击事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(dateAction:)];
    tapGesture.numberOfTapsRequired = 1;
    [startDataLabel addGestureRecognizer:tapGesture];
    [tapGesture release];
    
    // UILabel
    UILabel *toTimeLabel = [[UILabel alloc] init];
    toTimeLabel.textColor = [UIColor grayColor];
    toTimeLabel.bounds = CGRectMake(0,
                                    0,
                                    backgroundViewWidth * 0.02,
                                    40);
    toTimeLabel.center = CGPointMake(CGRectGetMaxX(startDataLabel.frame) + CGRectGetMidX(toTimeLabel.bounds) + 6,
                                       backgroundViewHeight * 0.05);
    toTimeLabel.text = @"到";
    toTimeLabel.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:toTimeLabel];
    [toTimeLabel release];
    
    // 停售日期选择标签
    UILabel *endDataLabel = [[UILabel alloc] init];
    endDataLabel.bounds = CGRectMake(0,
                                     0,
                                     backgroundViewWidth * 0.1,
                                     40);
    endDataLabel.center = CGPointMake(CGRectGetMaxX(toTimeLabel.frame) + CGRectGetMidX(endDataLabel.bounds) + 6,
                                        backgroundViewHeight * 0.05);
    endDataLabel.userInteractionEnabled = YES;
    endDataLabel.layer.cornerRadius = 5;
    endDataLabel.textColor = [UIColor grayColor];
    endDataLabel.backgroundColor = [UIColor whiteColor];
    _endDataLabel = endDataLabel;
    [backgroundView addSubview:endDataLabel];
    [endDataLabel release];
    // 添加点击事件
    UITapGestureRecognizer *tapGestureEnd = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(dateAction:)];
    tapGestureEnd.numberOfTapsRequired = 1;
    [endDataLabel addGestureRecognizer:tapGestureEnd];
    [tapGestureEnd release];
    
    // 投资期限
    UIButton *deadlineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    deadlineButton.layer.borderColor = [UIColor grayColor].CGColor;
    deadlineButton.layer.borderWidth = 1.0f;
    deadlineButton.layer.cornerRadius = 5;
    deadlineButton.backgroundColor = [UIColor whiteColor];
    deadlineButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [deadlineButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    deadlineButton.bounds = CGRectMake(0, 0, 100, 40);
    deadlineButton.center = CGPointMake(CGRectGetMaxX(endDataLabel.frame) + CGRectGetMidX(deadlineButton.bounds) + 6,
                                        backgroundViewHeight * 0.05);
    [deadlineButton setTitle:@"投资期限" forState:UIControlStateNormal];
    [deadlineButton addTarget:self
                       action:@selector(buttonAction:)
             forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:deadlineButton];
    
    // 收益类型
    UIButton *profitTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    profitTypeButton.layer.borderColor = [UIColor grayColor].CGColor;
    profitTypeButton.layer.borderWidth = 1.0f;
    profitTypeButton.layer.cornerRadius = 5;
    profitTypeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    profitTypeButton.backgroundColor = [UIColor whiteColor];
    [profitTypeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    profitTypeButton.bounds = CGRectMake(0, 0, 100, 40);
    profitTypeButton.center = CGPointMake(CGRectGetMaxX(deadlineButton.frame) + CGRectGetMidX(profitTypeButton.bounds) + 6,
                                        backgroundViewHeight * 0.05);
    [profitTypeButton setTitle:@"收益类型" forState:UIControlStateNormal];
    [profitTypeButton addTarget:self
                       action:@selector(buttonAction:)
             forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:profitTypeButton];
    
    // 币种
    UIButton *coinTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    coinTypeButton.layer.borderColor = [UIColor grayColor].CGColor;
    coinTypeButton.layer.borderWidth = 1.0f;
    coinTypeButton.layer.cornerRadius = 5;
    coinTypeButton.titleLabel.font = [UIFont systemFontOfSize:15];
    coinTypeButton.backgroundColor = [UIColor whiteColor];
    [coinTypeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    coinTypeButton.bounds = CGRectMake(0, 0, 100, 40);
    coinTypeButton.center = CGPointMake(CGRectGetMaxX(profitTypeButton.frame) + CGRectGetMidX(coinTypeButton.bounds) + 6,
                                          backgroundViewHeight * 0.05);
    [coinTypeButton setTitle:@"币种" forState:UIControlStateNormal];
    [coinTypeButton addTarget:self
                         action:@selector(buttonAction:)
               forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:coinTypeButton];
    
    // 搜索框
    UIImage *searchBackgroundImage = [UIImage imageNamed:@"搜索框_11"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:searchBackgroundImage];
    imageView.bounds = CGRectMake(0, 0, 230, 40);
    imageView.center = CGPointMake(CGRectGetMaxX(coinTypeButton.frame) + CGRectGetMidX(imageView.bounds) + 16,
                                   backgroundViewHeight * 0.05);
    imageView.userInteractionEnabled = YES;
    [backgroundView addSubview:imageView];
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
    tableView.bounds = CGRectMake(0, 0, CGRectGetWidth(backgroundView.bounds) * 0.95, 368);
    tableView.center = CGPointMake(CGRectGetMidX(backgroundView.bounds),
                                   CGRectGetMidY(backgroundView.bounds));
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 46;
    tableView.backgroundColor = [UIColor clearColor];
    [backgroundView addSubview:tableView];
    [tableView release];
    
    // tableView下面部分
    
    // 申请按钮
    UIButton *applicationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    applicationButton.bounds = CGRectMake(0, 0, 159, 50);
    applicationButton.center = CGPointMake(CGRectGetMidX(tableView.frame),
                                           CGRectGetMaxY(tableView.frame) + CGRectGetMidY(applicationButton.bounds) + 50);
    [applicationButton setBackgroundImage:[UIImage imageNamed:@"详情_01"]
                                 forState:UIControlStateNormal];
    [backgroundView addSubview:applicationButton];
    
    UILabel *predictLabel = [[UILabel alloc] init];
    predictLabel.bounds = CGRectMake(0, 0, 115, 50);
    predictLabel.center = CGPointMake(80 + CGRectGetMidX(predictLabel.bounds),
                                      CGRectGetMaxY(tableView.frame) + CGRectGetMidY(predictLabel.bounds));
    predictLabel.text = @"预计收益计算：";
    predictLabel.textColor = [UIColor grayColor];
    predictLabel.font = [UIFont boldSystemFontOfSize:16];
    predictLabel.font = [UIFont systemFontOfSize:16];
    [backgroundView addSubview:predictLabel];
    [predictLabel release];
    
    UILabel *prfigureLabel = [[UILabel alloc] init];
    prfigureLabel.bounds = CGRectMake(0, 0, 70, 50);
    prfigureLabel.center = CGPointMake(CGRectGetMaxX(predictLabel.frame) + CGRectGetMidX(prfigureLabel.bounds),
                                      CGRectGetMaxY(tableView.frame) + CGRectGetMidY(prfigureLabel.bounds));
    prfigureLabel.text = @"投资金额";
    prfigureLabel.textColor = [UIColor grayColor];
    prfigureLabel.font = [UIFont systemFontOfSize:15];
    prfigureLabel.textAlignment = NSTextAlignmentRight;
    prfigureLabel.backgroundColor = [UIColor redColor];
    [backgroundView addSubview:prfigureLabel];
    [prfigureLabel release];
    
    UITextField *prfigureField = [[UITextField alloc] init];
    prfigureField.bounds = CGRectMake(0, 0, 150, 40);
    prfigureField.center = CGPointMake(CGRectGetMaxX(prfigureLabel.frame) + CGRectGetMidX(prfigureField.bounds) + 5,
                                       CGRectGetMidY(prfigureLabel.frame));
    prfigureField.layer.cornerRadius = 5;
    prfigureField.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:prfigureField];
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
    unit.backgroundColor = [UIColor yellowColor];
    [backgroundView addSubview:unit];
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
    incomeLabel.backgroundColor = [UIColor yellowColor];
    [backgroundView addSubview:incomeLabel];
    [incomeLabel release];

    
    UITextField *incomeField = [[UITextField alloc] init];
    incomeField.bounds = CGRectMake(0, 0, 150, 40);
    incomeField.center = CGPointMake(CGRectGetMaxX(incomeLabel.frame) + CGRectGetMidX(incomeField.bounds) + 5,
                                       CGRectGetMidY(prfigureField.frame));
    incomeField.layer.cornerRadius = 5;
    incomeField.backgroundColor = [UIColor whiteColor];
    [backgroundView addSubview:incomeField];
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
    unitIncome.backgroundColor = [UIColor yellowColor];
    [backgroundView addSubview:unitIncome];
    [unitIncome release];
#pragma mark - TODO
#pragma mark - TODO
    // 计算
//    UIButton *calculateButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    calculateButton.bounds = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
}

- (void)dateAction:(UITapGestureRecognizer *)tapGesture
{
    // 日期选择控件
    PMCalendarController *pmCC = [[PMCalendarController alloc] init];
    pmCC.delegate = self;
    pmCC.mondayFirstDayOfWeek = YES;
    
    CGRect rect = CGRectMake(0, 0, 430, 40);
    [pmCC presentCalendarFromRect:rect
                            inView:_currentSelectedView
          permittedArrowDirections:PMCalendarArrowDirectionUp
                          animated:YES];
    [pmCC release];
    pmCC = nil;

}

- (void)buttonAction:(UIButton *)sender
{
    NSLog(@"%@", sender.titleLabel.text);
}

- (void)loadFundsView
{
    [self selectedIndex:1];
    _currentSelectedView = nil;
}

- (void)loadPreciousMetalView
{
    [self selectedIndex:2];
    _currentSelectedView = nil;
}

- (void)loadInsuranceView
{
    [self selectedIndex:3];
    _currentSelectedView = nil;
}

- (void)selectedIndex:(NSInteger)index
{
    // 重复点击无效
    if (_currentSelectedSegmentIndex == index) {
        return;
    }
    
    // 设置当前选中分段图片为取消状态
    [_segmentedControl setImage:_images[_currentSelectedSegmentIndex]
              forSegmentAtIndex:_currentSelectedSegmentIndex];
    // 设置将要选中分段图片为选中状态
    [_segmentedControl setImage:_imgaesSelected[index] forSegmentAtIndex:index];
    // 记录当前选中状态
    _currentSelectedSegmentIndex = index;
  
    // 移除上次选中视图
    if (_currentSelectedView) {
        [_currentSelectedView  removeFromSuperview];
    }
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

- (void)calendarController:(PMCalendarController *)calendarController didChangePeriod:(PMPeriod *)newPeriod
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                                       reuseIdentifier:identifier] autorelease];
        UIImageView *backgroundView = [[UIImageView alloc]
                                       initWithImage:[UIImage imageNamed:@"excel_23"]];
        cell.backgroundView = backgroundView;
        [backgroundView release];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.numberOfLines = 1;
        cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
        cell.detailTextLabel.textColor = [UIColor redColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

@end
