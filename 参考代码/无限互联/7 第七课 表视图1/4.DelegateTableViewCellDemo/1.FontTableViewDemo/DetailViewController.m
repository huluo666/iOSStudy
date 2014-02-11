//
//  DetailViewController.m
//  1.FontTableViewDemo
//
//  Created by 周泉 on 13-2-24.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G开发培训中心. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

- (void)setBackgroundView:(NSIndexPath *)indexPath withCell:(UITableViewCell *)cell;

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = view;
    [view release];
    
    UITableViewStyle style;
    if (!self.isBaseCell) {
        
        self.title = @"modify CellBG Type";
        style = UITableViewStyleGrouped;
        
        NSArray *array = [UIFont familyNames];
        _fontsArray = [[NSMutableArray alloc] initWithCapacity:13];
        NSMutableArray *temp = nil;
        for (int index = 0; index < [array count]; index++) {
            
            // 取出字体内容
            NSString *font = array[index];
            
            if (index % 5 == 0) {
                
                temp = [[NSMutableArray alloc] initWithCapacity:5];
                [_fontsArray addObject:temp];
                [temp release];
            } // 将5整除时，创建temp数组，添加到_fontsArray
            [temp addObject:font];
        }
        
    }else {
        self.title = @"Cell Base Type";
        style = UITableViewStylePlain;
    }
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, kDeviceHeight-20-44) style:style];
    // 设置数据源
    _tableView.dataSource = self;
    // 设置代理方法
    _tableView.delegate = self;

    [self.view addSubview:_tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITablView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isBaseCell) {
        return 1;
    }
    return [_fontsArray count]; // 13
} // 表视图当中存在secion的个数，默认是1个

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (_isBaseCell) {
        return 4; // 0 - 3
    }
    return [_fontsArray[section] count]; // 5
} // section 中包含row的数量

// indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isBaseCell) {
        
        /*
        UITableViewCellStyleDefault   0  no detailTextLabel
        UITableViewCellStyleValue1    1
        UITableViewCellStyleValue2    2  no imageView
        UITableViewCellStyleSubtitle  3
         */
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:indexPath.row reuseIdentifier:nil];
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"这是一个默认的风格";
                cell.imageView.image = [UIImage imageNamed:@"IMG_0410"];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 1:
                cell.textLabel.text = @"这是一个value1风格";
                cell.imageView.image = [UIImage imageNamed:@"IMG_0410"];
                cell.detailTextLabel.text = @"这是副标题";
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                break;
            case 2:
                cell.textLabel.text = @"这是一个value2风格";
                cell.detailTextLabel.text = @"这是副标题";
                cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
                break;
            case 3:
                cell.textLabel.text = @"这是一个subTitle风格";
                cell.detailTextLabel.text = @"这是副标题";
                cell.imageView.image = [UIImage imageNamed:@"IMG_0410"];
                break;
            default:
                break;
        }
        
        return cell;
        
    }else {
        
        static NSString *cellIdentifier = @"cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        }
        
        cell.textLabel.text = [[_fontsArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.backgroundColor = [UIColor clearColor];
        
        // 设置选中背景的风格
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setBackgroundView:indexPath withCell:cell];
        
        return cell;
    }
    
    
} // 创建单元格

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (_isBaseCell) {
        return nil;
    }
    NSString *title = [NSString stringWithFormat:@"header 第%d个section", section+1];
    return title;
} // 设置section header 的title

#pragma mark - TableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
} // 设置行高

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s", __FUNCTION__);
} // accessoryButton 响应事件

#pragma mark - Private
- (void)setBackgroundView:(NSIndexPath *)indexPath withCell:(UITableViewCell *)cell
{
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:CGRectZero];
    UIImageView *selectView     = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    if ([_fontsArray count] - 1 == indexPath.section) {
        
        
        backgroundView.image = [UIImage imageNamed:@"tableCell_single"];
        selectView.image = [UIImage imageNamed:@"tableCell_single_tapped"];
        
        
    } // 最后一个section的cell
    else {
        
        if (indexPath.row == 0) {
            
            backgroundView.image = [UIImage imageNamed:@"tableCell_head"];
            selectView.image = [UIImage imageNamed:@"tableCell_head_tapped"];
            
        }else if (indexPath.row == 4) {
            backgroundView.image = [UIImage imageNamed:@"tableCell_bottom"];
            selectView.image = [UIImage imageNamed:@"tableCell_bottom_tapped"];
            
        }else {
            backgroundView.image = [UIImage imageNamed:@"tableCell_common"];
            selectView.image = [UIImage imageNamed:@"tableCell_common_tapped"];
            
        }
    }
    
    cell.backgroundView = backgroundView;
    cell.selectedBackgroundView = selectView;
}

- (void)dealloc
{
    [_tableView release], _fontsArray = nil;
    [_fontsArray release], _fontsArray = nil;
    [super dealloc];
}

@end
