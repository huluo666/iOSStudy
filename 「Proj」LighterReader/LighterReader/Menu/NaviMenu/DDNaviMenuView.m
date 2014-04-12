//
//  DDNaviMenuView.m
//  LighterReader
//
//  Created by 萧川 on 14-3-29.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDNaviMenuView.h"
#import "DDNaviCell.h"
#import "DDRootViewController.h"
#import "UIView+FindUIViewController.h"
#import "DDPullDown.h"

typedef struct {
    NSInteger start;
    NSInteger end;
} DDRang;

@interface DDNaviMenuView () <
    UITableViewDelegate,
    UITableViewDataSource
>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *originDataSource;

/* section 2 */
@property (nonatomic, strong) NSMutableArray *dataSource;
// flodable cell indexPathss
@property (nonatomic, strong) NSMutableDictionary *foldableCellIndexPaths;
// record rowHeight = 0 indexPaths
@property (nonatomic, strong) NSMutableArray *recored;
// add data to _dataSource
- (void)addDataWithDictionary:(NSDictionary *)dict;
// record already expanded indexPaths titles's indxPath
@property (nonatomic, strong) NSMutableArray *selectedIndexPath;

// add content
- (void)addContentAction;

/* must reades */
@property (strong, nonatomic) NSMutableArray *mustReadList;

/* pull down */
@property (strong, nonatomic) DDPullDown *pullDown;

@end

static NSInteger mustReadRowsCount;

@implementation DDNaviMenuView

- (void)dealloc {
    
    [_pullDown free];
    NSLog(@"Navi Menu dealloced");
}

#pragma mark - init

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        // init
        self.backgroundColor = [UIColor colorWithWhite:0.863 alpha:1.000];
        CGFloat width = [[UIScreen mainScreen] bounds].size.width;
        CGFloat height = [[UIScreen mainScreen] bounds].size.height;
        self.bounds = CGRectMake(0, 0, width - 40, height - 20);
        
        // swip left gesture
        UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(swipLeftAction)];
        swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipLeft];
        
        // tableView
        _tableView = [[UITableView alloc] initWithFrame:self.bounds
                                                      style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.942 alpha:1.000];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];

        // pull down refresh
        _pullDown = [DDPullDown pullDown];
        _pullDown.scrollView = _tableView;
        _pullDown.beginRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
            [refreshBaseView performSelector:@selector(endRefreshingWithSuccess:)
                                  withObject:@1
                                  afterDelay:1];
        };
        
        [self initDataSource];
    }
    return self;
}

- (void)initDataSource {
    
    // section 1
    NSArray *section1ImagesName = @[@"mobile-selector-feedly-white",
                                    @"mobile-selector-saved-white",
                                    @"mobile-selector-explore-white"];
    NSArray *section1Titles = @[@"Home", @"Saved For Later", @"Explore"];
    NSDictionary *sectionImageDict = [NSDictionary dictionaryWithObject:section1ImagesName
                                                                 forKey:@"imagesName"];
    NSDictionary *sectionTitleDict = [NSDictionary dictionaryWithObject:section1Titles
                                                                 forKey:@"titles"];
    NSArray *section1 = @[sectionImageDict, sectionTitleDict];

    // section 3
    NSArray *section3 = @[@"Recently Read", @"Edit Content",
                          @"Switch Theme", @"Settings", @"Logout"];
    
    _originDataSource = @[section1, @[], section3];
    
    // section 2
    _dataSource = [[NSMutableArray alloc] initWithArray:@[@"All"]];
    _foldableCellIndexPaths = [NSMutableDictionary dictionaryWithCapacity:0];
    _recored = [[NSMutableArray alloc] init];
    
    NSDictionary *dict1 = @{@"CNiDev":@[@"oneVcat", @"破船之家", @"博客园——biosli", @"luke", @"码农周刊"],
                            @"Reader":@[@"44444", @"55555", @"6666", @"77777"],
                            @"News":@[@"News-1", @"News-2", @"News-3", @"News-4", @"News-5"]};
    [self addDataWithDictionary:dict1];
    
    _selectedIndexPath = [[NSMutableArray alloc] init];
    
    // must reads
    _mustReadList = [[NSMutableArray alloc] initWithArray:@[@"Must reads", @"oneVcat", @"博客园"]];
    mustReadRowsCount = _mustReadList.count - 1;
}

#pragma mark - add data to _dataSource

- (void)addDataWithDictionary:(NSDictionary *)dict {
    
    NSArray *keys = [dict allKeys];
    for (NSString *title in keys) {
        [_dataSource addObject:title];
        
        NSInteger start = _dataSource.count;
        NSIndexPath *key = [NSIndexPath indexPathForRow:start - 1 inSection:1];
        
        NSArray *valueArr = (NSArray *)[dict objectForKey:title];
        [_dataSource addObjectsFromArray:valueArr];
        
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger i = start; i <= start + valueArr.count - 1; i++) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:1];
            [tempArr addObject:path];
            [_recored addObject:path];
        }
        [self.foldableCellIndexPaths setObject:tempArr forKey:key];
    }
}

#pragma mark - handle swip left

- (void)swipLeftAction
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    if (_handleSwipLeft) {
        _handleSwipLeft();
    }
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {

    NSInteger count = 0;
    switch (section) {
        case 0: {
            count = 3 + _mustReadList.count - mustReadRowsCount;
        }
            break;
        case 1: {
            count = _dataSource.count;
        }
            break;
        case 2: {
            count = 5;
        }
            break;
        default:
            break;
    }
    
    return count;
}

- (DDNaviCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"normalCell";
    static NSString *customCellIdentifier = @"customCell";
    static NSString *dropCellIdentifier = @"dropCellIdentifier";
    switch (indexPath.section) {
        case 0: {
            DDNaviCell *cell = [tableView dequeueReusableCellWithIdentifier:customCellIdentifier];
            if (!cell) {
                cell = [[DDNaviCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:customCellIdentifier];
            }
            
            if (indexPath.row < 3) {
                NSString *imageName =  _originDataSource[0][0][@"imagesName"][indexPath.row];
                cell.leftImageView.image = DDImageWithName(imageName);
                NSString *title = _originDataSource[0][1][@"titles"][indexPath.row];
                cell.titleLabel.text = title;
            } else {
                __block NSMutableArray *blockMustReadList = _mustReadList;
                cell.titleLabel.text = blockMustReadList[indexPath.row - 3];
                if (3 == indexPath.row) {
                    [cell.imageButton setBackgroundImage:DDImageWithName(@"mobile-selector-favorite-white")
                                                forState:UIControlStateNormal];
                    
                    __weak DDNaviCell *weakCell = cell;
                    __weak UITableView *weaktable = tableView;
                    cell.imageButtonAction = ^(UIButton *sender) {
                        mustReadRowsCount = sender.isSelected ? 0 : blockMustReadList.count - 1;
                        if (sender.isSelected) {
                            [UIView animateWithDuration:0.2
                                             animations:^{
                                weakCell.imageButton.transform =
                                                 CGAffineTransformRotate(weakCell.imageButton.transform, M_PI_2);
                            } completion:^(BOOL finished) {
                                [weaktable reloadData];
                            }];
                        } else {
                            [UIView animateWithDuration:0.2
                                             animations:^{
                                weakCell.imageButton.transform = CGAffineTransformIdentity;
                            } completion:^(BOOL finished) {
                                [weaktable reloadData];
                            }];
                        }
                    };
                }
            }
            
            return cell;
        }
            break;
            
        case 1: {
            DDNaviCell *cell = [tableView dequeueReusableCellWithIdentifier:dropCellIdentifier];
            if (!cell) {
                cell = [[DDNaviCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:dropCellIdentifier];
            }

            if (indexPath.section == 1 && indexPath.row == 0) {
                cell.leftImageView.image = [UIImage imageNamed:@"mobile-selector-latest-white"];
            } else {
                cell.leftImageView.image = nil;
            }
            
            if ([[_foldableCellIndexPaths allKeys] containsObject:indexPath]) {
                // can be fold
                [cell.imageButton setBackgroundImage:DDImageWithName(@"mobile-selector-right-arrow-white")
                                            forState:UIControlStateNormal];
                
                // fold、expand actions
                __weak DDNaviCell *weakCell = cell;
                /* __weak、__block、__strong均可，直接在下面block里面直接使用会retain cycle？ */
                __block NSMutableDictionary *blockFoldableCellIndexPaths = _foldableCellIndexPaths;
                __block NSMutableArray *blockSelectedIndexPath = _selectedIndexPath;
                __block NSMutableArray *blockRecored = _recored;
                __weak UITableView *weaktable = tableView;
                
                if ([blockSelectedIndexPath containsObject:indexPath]) {
                    weakCell.imageButton.selected = YES;
                    weakCell.imageButton.transform = CGAffineTransformMakeRotation(M_PI_2);
                } else {
                    weakCell.imageButton.selected = NO;
                    weakCell.imageButton.transform = CGAffineTransformIdentity;
                }
                
                cell.imageButtonAction = ^(UIButton *sender) {
                    NSArray *arr = [blockFoldableCellIndexPaths objectForKey:indexPath];
                    if (sender.isSelected) {
                        [blockSelectedIndexPath addObject:indexPath];
                        [blockRecored removeObjectsInArray:arr];
                        
                        [UIView animateWithDuration:0.2
                                         animations:^{
                            weakCell.imageButton.transform = CGAffineTransformMakeRotation(M_PI_2);
                        } completion:^(BOOL finished) {
                            [weaktable reloadData];
                        }];
                    } else {
                        [blockSelectedIndexPath removeObject:indexPath];
                        [blockRecored addObjectsFromArray:arr];
                        
                        [UIView animateWithDuration:0.2
                                         animations:^{
                            weakCell.imageButton.transform = CGAffineTransformIdentity;
                        } completion:^(BOOL finished) {
                            [weaktable reloadData];
                        }];
                    }
                };
            } else {
                // can not be fold
                [cell.imageButton setBackgroundImage:nil forState:UIControlStateNormal];
            }
            
            cell.titleLabel.text = _dataSource[indexPath.row];
            return cell;
        }
            break;
            
        case 2: {
            DDNaviCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[DDNaviCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:cellIdentifier];
            }
            
            cell.textLabel.text = self.originDataSource[2][indexPath.row];
            return cell;
        }
            break;
            
        default: {
            DDNaviCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[DDNaviCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:cellIdentifier];
            }
            return cell;
        }
            break;
    }
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 0: {
            
        }
            break;
            
        case 1: {
            
        }
            break;
            
        case 2: {
            if (4 == indexPath.row) {
                // set root login NO
                DDRootViewController *rootVC = (DDRootViewController *)[self viewController];
                if (rootVC.isLogin) {
                    rootVC.login = NO;
                    
                    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
                    [notification postNotificationName:@"login"
                                                object:nil
                                              userInfo:@{@"isLogined":@"0"}];
                    if (_handleSwipLeft) {
                        _handleSwipLeft();
                    }
                }
            }
        }
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger rowHeight = 44;
    if ([_recored containsObject:indexPath]) {
        rowHeight = 0;
    }
    return rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView
    viewForFooterInSection:(NSInteger)section {
    
    if (1 == section) {
        
        UIView *view = [[UIView alloc]
                        initWithFrame:CGRectMake(0,
                                                 0,
                                                 CGRectGetWidth(self.bounds),
                                                 88)];
        [self addSubview:view];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds) * 0.8, 40);
        button.center = CGPointMake(CGRectGetMidX(self.bounds), 50);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithWhite:0.822 alpha:1.000]];
        [button setTitle:@"Add content" forState:UIControlStateNormal];
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor colorWithWhite:0.822 alpha:1.000].CGColor;
        button.layer.cornerRadius = 5;
        [button addTarget:self
                   action:@selector(addContentAction)
         forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:button];
        
        return view;
    } else if (2 == section){
        UIView *view = [[UIView alloc]
                        initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 88)];
        [self addSubview:view];
        
        UILabel *label = [[UILabel alloc] init];
        label.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 30);
        label.center = CGPointMake(CGRectGetMidX(self.bounds),
                                   CGRectGetMaxY(view.bounds) - 15);
        label.text = @"Version 2.0";
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor grayColor];
        [view addSubview:label];
        
        return view;
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForFooterInSection:(NSInteger)section {
    
    if (section) {
        return 88;
    } else {
        return 0;
    }
}

#pragma mark - addContentAction

- (void)addContentAction {
    
    NSLog(@"addContentAction");
}

@end
