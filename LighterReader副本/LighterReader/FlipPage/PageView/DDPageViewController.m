//
//  DDPageViewController.m
//  「Demo」FlipPage
//
//  Created by 萧川 on 14-4-2.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDPageViewController.h"
#import "DDTitleOnlyCell.h"
#import "DDListCell.h"
#import "DDMagazineCell.h"
#import "DDCardsCell.h"
#import "DDReadViewController.h"
#import "DDAppDelegate.h"
#import "DDRootViewController.h"

static NSString *cellIdentifier = @"cell";

@interface DDPageViewController ()

@end

@implementation DDPageViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCellType:(DDCellType)type {
    
    if (self = [super init]) {
        _celltype = type;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // calculate bounds and centers
    CGRect screenBounds = [[UIScreen mainScreen] bounds];

    // rowHeight
    CGFloat rowHeight = 44;
    CGFloat height = CGRectGetHeight(screenBounds);
    if (480 == height) {
        rowHeight = 83.2;
    } else if (568 == height) {
        rowHeight = 84;
    } else if (1024 == height) {
        rowHeight = 80;
    }
    
    [self registerCellCllass];
    self.tableView.rowHeight = rowHeight;
    self.tableView.bounces = NO;
    _dataSource = [[NSArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // before appear, check rootVC's swip gestures, if not exist, add them
    DDRootViewController *rootVC = (DDRootViewController *)[[((DDAppDelegate *)[[UIApplication sharedApplication] delegate]) window] rootViewController];
    NSArray *gestures = rootVC.view.gestureRecognizers;
    BOOL isExist = NO;
    for (UIGestureRecognizer *ges in gestures) {
        if ([ges isKindOfClass:[UISwipeGestureRecognizer class]]) {
            UISwipeGestureRecognizer *swipGes = (UISwipeGestureRecognizer *)ges;
            if (swipGes.direction == UISwipeGestureRecognizerDirectionRight ||
                swipGes.direction == UISwipeGestureRecognizerDirectionLeft) {
                isExist = YES;
                break;
            }
        }
    }
    if (!isExist) {
        [rootVC.view addGestureRecognizer:rootVC.swipRightGesture];
        [rootVC.view addGestureRecognizer:rootVC.swipLeftGesture];
    }
}

- (void)registerCellCllass {
    
    switch (self.celltype) {
        case DDCellTypeTitleOnly: {
            [self.tableView registerClass:[DDTitleOnlyCell class]
                   forCellReuseIdentifier:cellIdentifier];
        }
            break;
        case DDCellTypeList: {
            [self.tableView registerClass:[DDListCell class]
                   forCellReuseIdentifier:cellIdentifier];
        }
            break;
            
        case DDCellTypeMagazine: {
            [self.tableView registerClass:[DDMagazineCell class]
                   forCellReuseIdentifier:cellIdentifier];
        }
            break;
        case DDCellTypeCards: {
            [self.tableView registerClass:[DDCardsCell class]
                   forCellReuseIdentifier:cellIdentifier];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (_dataSource &&
        [_dataSource isKindOfClass:[NSArray class]]) {
        count = _dataSource.count;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DDCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                            forIndexPath:indexPath];
    cell.titleLabel.text = [_dataSource[indexPath.row] objectForKey:@"title"];
    cell.reviewLabel.text = [_dataSource[indexPath.row] objectForKey:@"review"];
    cell.hintLabel.text = [_dataSource[indexPath.row] objectForKey:@"hint"];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    DDReadViewController *readVC = [[DDReadViewController alloc]
                                    initWithDataSource:nil];
    // before push invalidated rootVC swip gesture
    DDRootViewController *rootVC = (DDRootViewController *)[[((DDAppDelegate *)[[UIApplication sharedApplication] delegate]) window] rootViewController];
    [rootVC.view removeGestureRecognizer:rootVC.swipLeftGesture];
    [rootVC.view removeGestureRecognizer:rootVC.swipRightGesture];

    // now push
    [self.navigationController pushViewController:readVC animated:YES];
}

@end
