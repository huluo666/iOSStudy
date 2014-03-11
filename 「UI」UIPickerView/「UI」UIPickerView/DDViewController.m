//
//  DDViewController.m
//  「UI」UIPickerView
//
//  Created by 萧川 on 3/5/14.
//  Copyright (c) 2014 CUAN. All rights reserved.
//

#import "DDViewController.h"

@interface DDViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSArray *dataSource;

- (void)initializeUserInterface;

@end

@implementation DDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // 初始化数据
        NSString *path = [[NSBundle mainBundle] pathForAuxiliaryExecutable:@"city.plist"];
        _dataSource = [[NSArray alloc] initWithContentsOfFile:path];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeUserInterface];
}

- (void)initializeUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建选择器视图
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    // width: 320 height:216 固定值
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, height - 216, 320, 216)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:pickerView];
}

#pragma mark - <UIPickerViewDataSource>
//有几组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

// 每一组的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (0 == component) {
        return _dataSource.count;
    }
    
    // 第一组中选中的行数
    NSInteger selectedRow = [pickerView selectedRowInComponent:0];
    // 取得选中行对应的字典(省份)
    NSDictionary *item = _dataSource[selectedRow];
    // 取得该组中所有数据(城市)
    NSArray *cities = item[@"cities"];
    return cities.count;
}

#pragma mark - <UIPickerViewDelegate>

// 每个item的title
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if (0 == component) {
        NSDictionary *dict = _dataSource[row];
        return dict[@"state"];
    }
    
    // 第一组中选中的行数
    NSInteger selectedRow = [pickerView selectedRowInComponent:0];
    // 取得选中行对应的字典(省份)
    NSDictionary *item = _dataSource[selectedRow];
    // 取得该组中所有数据(城市)
    NSArray *cities = item[@"cities"];
    return cities[row];
}

// 选则省份后更新城市
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    if (0 == component) {
        // 刷新第二组数据(城市)
        [pickerView reloadComponent:1];
        // 跳到每组第一行
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
}



@end
