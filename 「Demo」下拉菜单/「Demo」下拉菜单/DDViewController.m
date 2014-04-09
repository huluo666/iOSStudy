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
@property (nonatomic, strong) NSMutableDictionary *foldedCellIndexPaths;
@property (nonatomic, strong) NSMutableArray *recored; // 记录rowHeight=0的indexPath

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
    
    NSDictionary *dict1 = @{@"CNiDev":@[@"1111", @"2222", @"2211", @"jd", @"333"], @"Reader":@[@"44444", @"55555", @"6666", @"77777"]};
    [self addDataWithDictionary:dict1];

}

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";

    switch (indexPath.section) {
        case 0: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            cell.textLabel.text = [NSString stringWithFormat:@"section:%ld, row:%ld", indexPath.section, indexPath.row];
            return cell;
        }
            break;
            
        case 1: {
            DDNaviCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[DDNaviCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            

            if (indexPath.section == 1 && indexPath.row == 0) {
                cell.leftImageView.image = [UIImage imageNamed:@"mobile-selector-latest-white"];
            }
            
            if ([[_foldedCellIndexPaths allKeys] containsObject:indexPath]) {
                [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"mobile-selector-right-arrow-white"] forState:UIControlStateNormal];
                [cell.imageButton setBackgroundImage:[UIImage imageNamed:@"mobile-selector-down-arrow-white"] forState:UIControlStateSelected];
            }
            
            cell.imageButtonAction = ^(UIButton *sender){
                NSArray *arr = [_foldedCellIndexPaths objectForKey:indexPath];
                if (sender.isSelected) {
                    [_recored removeObjectsInArray:arr];
                } else {
                    [_recored addObjectsFromArray:arr];
                }
                [tableView reloadData];
            };
            cell.titleLabel.text = _dataSource[indexPath.row];
            return cell;
        }
            break;
            
        default: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
