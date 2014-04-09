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
@property (nonatomic, strong) NSArray *expandData;

@end

@implementation DDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    NSArray *titles = @[@"All", @"CNiDev", @"Test"];
    _dataSource = [NSMutableArray array];
    for (NSInteger i = 0; i < 3; i++) {
        DDCellContent *content = [[DDCellContent alloc] init];
        content.imageName = @"mobile-selector-right-arrow-white";
        content.selectedImageName = @"mobile-selector-down-arrow-white";
        content.titleString = titles[i];
        content.row = i;
        if (i) {
            
        }
        [_dataSource addObject:content];
    }
    
    NSArray *titles1 = @[@"111", @"222", @"333"];
    NSMutableArray *data = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        DDCellContent *content = [[DDCellContent alloc] init];
        content.titleString = titles1[i];
        [data addObject:content];

    }
    
    NSArray *titles2 = @[@"444", @"555", @"6666", @"7777"];
    NSMutableArray *data2 = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        DDCellContent *content = [[DDCellContent alloc] init];
        content.titleString = titles2[i];
        [data2 addObject:content];
        
    }
    
    self.expandData =@[data, data, data2];
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
            
            
            
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:[_dataSource[indexPath.row] imageName]] forState:UIControlStateNormal];
            [cell.imageButton setBackgroundImage:[UIImage imageNamed:[_dataSource[indexPath.row] selectedImageName]] forState:UIControlStateSelected];
            
            cell.imageButtonAction = ^(UIButton *sender){
                
                NSLog(@"row = %ld", indexPath.row);
                
                NSInteger row = indexPath.row;
                NSInteger section = indexPath.section;
                NSInteger cellRow = [_dataSource[row] row];

                NSLog(@"%ld %ld %ld", row, section, cellRow);
                
                NSRange range = NSMakeRange(row + 1, [_expandData[cellRow] count]);
                NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
                
                NSMutableArray *indexPaths = [NSMutableArray array];
                for (NSInteger index = 1; index <= [_expandData[cellRow] count]; index++) {
                    NSIndexPath *expIndexPath = [NSIndexPath indexPathForRow:row+index inSection:section];
                    [indexPaths addObject:expIndexPath];
                }
                
                if (sender.isSelected) {
                    // need expand
                    [_dataSource insertObjects:_expandData[cellRow] atIndexes:indexSet];
                    [tableView reloadData];
//                    [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationBottom];
                } else {
                    // already expand
                    [_dataSource removeObjectsAtIndexes:indexSet];
                    [tableView reloadData];
//                    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
                }
            };
            
            
            cell.titleLabel.text = [_dataSource[indexPath.row] titleString];
            
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

    NSLog(@"sedtion:%ld row:%ld", indexPath.section, indexPath.row);
}

#pragma mark - UITableViewDelegate


@end
