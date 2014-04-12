//
//  DDViewController.m
//  「Demo」下拉菜单
//
//  Created by 萧川 on 14-4-8.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDViewController.h"
#import "DDNaviCell.h"
#import "DDCellContent.h"

@interface DDViewController () <
    UITableViewDataSource,
    UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableDictionary *foldedCellIndexPaths;    // 记录可以折叠的indexPath
@property (nonatomic, strong) NSMutableArray *recored;                      // 记录rowHeight=0的indexPath
@property (nonatomic, strong) NSMutableArray *selectedIndexPath;            // 记录已经展开的indexPath title's indexPath

@end

@implementation DDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    _dataSource = [[NSMutableArray alloc] initWithArray:@[@"All"]];
    _foldedCellIndexPaths = [[NSMutableDictionary alloc] init];
    _recored = [[NSMutableArray alloc] init];
    
    NSDictionary *dict1 = @{@"CNiDev":@[@"1111", @"2222", @"2211", @"jd", @"333"], @"Reader":@[@"44444", @"55555", @"6666", @"77777"], @"News":@[@"News-1", @"News-2", @"News-3", @"News-4", @"News-5"]};
    [self addDataWithDictionary:dict1];
    
    _selectedIndexPath = [[NSMutableArray alloc] init];

}

// 添加数据到数据源
- (void)addDataWithDictionary:(NSDictionary *)dict {
    
    NSArray *keys = [dict allKeys];
    for (NSString *title in keys) {
        
        [_dataSource addObject:title];
        NSLog(@"_dataSource = %@", _dataSource);
        
        NSInteger start = _dataSource.count;
        NSIndexPath *key = [NSIndexPath indexPathForRow:start - 1 inSection:1];
        
        NSArray *valueArr = (NSArray *)[dict objectForKey:title];
        
        [_dataSource addObjectsFromArray:valueArr];
        NSLog(@"_dataSource = %@", _dataSource);
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        for (NSInteger i = start; i <= start + valueArr.count - 1; i++) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:1];
            [tempArr addObject:path];
            [_recored addObject:path];
        }
        [_foldedCellIndexPaths setObject:tempArr forKey:key];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (0 == section) {
        return 3;
    } else {
        return _dataSource.count;
    }
}

// 注意：返回值类型为：DDNaviCell
- (DDNaviCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    static NSString *dropCellIdentifier = @"dropCellIdentifier";
    switch (indexPath.section) {
        case 0: {
            DDNaviCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[DDNaviCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            cell.textLabel.text = [NSString stringWithFormat:@"section:%ld, row:%ld", indexPath.section, indexPath.row];
            return cell;
        }
            break;
            
        case 1: {
            // 初始化cell
            DDNaviCell *cell = [tableView dequeueReusableCellWithIdentifier:dropCellIdentifier];
            if (!cell) {
                cell = [[DDNaviCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dropCellIdentifier];
            }

            // 为第一个cell设置独特的样式
            if (indexPath.section == 1 && indexPath.row == 0) {
                cell.leftImageView.image = [UIImage imageNamed:@"mobile-selector-latest-white"];
            } else {
                cell.leftImageView.image = nil;
            }
            
            // 如果当前indexPath可以折叠
            if ([[_foldedCellIndexPaths allKeys] containsObject:indexPath]) {
                // 设置左侧按钮
                [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"mobile-selector-right-arrow-white"] forState:UIControlStateNormal];
                [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"mobile-selector-down-arrow-white"] forState:UIControlStateSelected];
                
                // 记录已经折叠的分组
                if ([_selectedIndexPath containsObject:indexPath]) {
                    cell.imageButton.selected = YES;
                } else {
                    cell.imageButton.selected = NO;
                }
                
                // 点击按钮展开、闭合事件
                cell.imageButtonAction = ^(UIButton *sender){
                    NSArray *arr = [_foldedCellIndexPaths objectForKey:indexPath];
                    if (sender.isSelected) {
                        // 记录展开分组title's indexPath
                        [_selectedIndexPath addObject:indexPath];
                        // 从高度为零数组中移除
                        [_recored removeObjectsInArray:arr];
                    } else {
                        // 记录折叠分组titles's indexPath
                        [_selectedIndexPath removeObject:indexPath];
                        // 添加到高度为零数组
                        [_recored addObjectsFromArray:arr];
                    }
                    
                    // 重载数据
                    [tableView reloadData];
                };
            } else {
                // 不可以折叠。设置左侧按钮为nil
                [cell.imageButton setBackgroundImage:nil forState:UIControlStateNormal];
                [cell.imageButton setBackgroundImage:nil forState:UIControlStateSelected];
            }

            cell.titleLabel.text = _dataSource[indexPath.row];
            return cell;
        }
            break;
            
        default: {
            DDNaviCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[DDNaviCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            return cell;;
        }
            break;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"%@", indexPath);
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSInteger rowHeight = 44;
    if ([_recored containsObject:indexPath]) {
        rowHeight = 0;
    }
    return rowHeight;
}

@end
