//
//  DDNaviDataSource.m
//  面试职通车
//
//  Created by 萧川 on 14-4-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDNaviDataSource.h"
#import "DDNaviCell.h"

@interface DDNaviDataSource ()

@property (nonatomic, strong) NSArray *imageNames;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *naviSubControlClassNames;

@end

@implementation DDNaviDataSource

- (id)init {
    self = [super init];
    if (self) {
        _imageNames = @[@"item_01", @"item_02", @"item_03", @"item_04", @"item_05", @"item_06"];
        _titles = @[@"招聘信息", @"面试技巧", @"薪资查询", @"面试日程", @"个人简历", @"更多选项"];
        NSArray *classNames = @[@"LTZRecruitmentInformationViewController",
                                      @"LTZInterviewSkillsViewController",
                                      @"YYSalaryQueryViewController",
                                      @"DDInterviewScheduleViewController",
                                      @"YYPersonalResumeViewController",
                                      @"DDMoreOptionsViewController"];
        _naviSubControlClassNames = [[NSMutableArray alloc] initWithArray:classNames];
        
    }
    return self;
}


#pragma mark - <UICollectionViewDatasource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return 6;
}

- (DDNaviCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DDNaviCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"naviCell"
                                                                 forIndexPath:indexPath];

    NSString *backViewName = [NSString stringWithFormat:@"%@_normal", _imageNames[indexPath.row]];
    NSString *selectedBackViewName = [NSString stringWithFormat:@"%@_selected", _imageNames[indexPath.row]];
    [cell.button setBackgroundImage:DDImageWithName(backViewName) forState:UIControlStateNormal];
    [cell.button setBackgroundImage:DDImageWithName(selectedBackViewName) forState:UIControlStateHighlighted];
    [cell.button setBackgroundImage:DDImageWithName(selectedBackViewName) forState:UIControlStateSelected];
    cell.cellButtonDidTap = ^{
        // 获取类字节码
        Class clazz = NSClassFromString(_naviSubControlClassNames[indexPath.row]);
        // 创建类对应的实例
        DDViewController *viewControl = [[clazz alloc] init];
        [[[[UIApplication sharedApplication].keyWindow.rootViewController childViewControllers] firstObject] pushViewController:viewControl animated:YES];
    };
    cell.label.text = _titles[indexPath.row];

    return cell;
}



@end
