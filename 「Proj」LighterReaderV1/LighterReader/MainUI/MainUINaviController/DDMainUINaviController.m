//
//  DDMainUINaviController.m
//  LighterReader
//
//  Created by 萧川 on 14-3-28.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDMainUINaviController.h"
#import "DDPresentAnimation.h"
#import "DDDismissAnimation.h"

#define kCellBackgroundColor [UIColor colorWithWhite:0.296 alpha:1.000]
#define kCellSelectedBackgroundColor [UIColor colorWithWhite:0.196 alpha:1.000]

#pragma mark - floater adjust view's header view

@interface HeaderView : UIView

// toggle selected button background color
- (void)toggleSelectedButtonBackgroundColorWithSelectedIndex:(NSInteger)index
                                            willSelectButton:(UIButton *)button;

// blocks
@property (copy, nonatomic) void (^headerTitleOnlyView)(void);
@property (copy, nonatomic) void (^headerListView)(void);
@property (copy, nonatomic) void (^headerMagazineView)(void);
@property (copy, nonatomic) void (^headerCardsView)(void);

@end

@implementation HeaderView

- (void)dealloc {
    [_headerTitleOnlyView release];
    [_headerListView release];
    [_headerMagazineView release];
    [_headerCardsView release];
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.bounds = CGRectMake(0, 0, CGRectGetWidth(DDBounds) * 0.78, 44);
        self.backgroundColor = kCellBackgroundColor;
        // generate four adjust display button
        NSArray *buttonBackgroundImages = @[DDImageWithName(@"mobile-action-titleonly"),
                                            DDImageWithName(@"mobile-action-list"),
                                            DDImageWithName(@"mobile-action-magazine"),
                                            DDImageWithName(@"mobile-action-poster")];
        
        for (int i = 0; i < 4; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.bounds = CGRectMake(0, 0, 44, 44);
            button.center = CGPointMake(CGRectGetWidth(self.bounds) / 8 * (2 * i + 1),
                                        CGRectGetMidY(self.bounds));
            [button setBackgroundImage:buttonBackgroundImages[i]
                              forState:UIControlStateNormal];
            button.tag = kFloaterAdjustDislplayButtonTag + i;
            [button addTarget:self
                       action:@selector(changeDisplayPolicy:)
             forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            NSInteger index = [[kUserDefaults objectForKey:@"currentSelectedButtonIndex"] integerValue];
            if (index == i) {
                button.selected = YES;
                [button setBackgroundColor:kCellSelectedBackgroundColor];
            }
        }
    }
    return self;
}

#pragma mark - change display policy

- (void)changeDisplayPolicy:(UIButton *)sender {
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    // toggle sender slected background color
    NSInteger currentSelectedButtonIndex = [[kUserDefaults objectForKey:
                                             @"currentSelectedButtonIndex"]
                                            integerValue];
    [self toggleSelectedButtonBackgroundColorWithSelectedIndex:currentSelectedButtonIndex
                                              willSelectButton:sender];
    
    NSInteger index = sender.tag  - kFloaterAdjustDislplayButtonTag;
    switch (index) {
        case 0: {
            // title only view
            if (_headerTitleOnlyView) {
                _headerTitleOnlyView();
            }
        }
            break;
        case 1: {
            // list view
            if (_headerListView) {
                _headerListView();
            }
        }
            break;
        case 2: {
            // magazine view
            if (_headerMagazineView) {
                _headerMagazineView();
            }
        }
            break;
        case 3: {
            // cards view
            if (_headerCardsView) {
                _headerCardsView();
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - toggle selected background color
- (void)toggleSelectedButtonBackgroundColorWithSelectedIndex:(NSInteger)index
                                            willSelectButton:(UIButton *)button {

    NSInteger tagIndex = index + kFloaterAdjustDislplayButtonTag;
    UIButton *selectedButton = (UIButton *)[self viewWithTag:tagIndex];
    [selectedButton setBackgroundColor:kCellBackgroundColor];
    
    [button setBackgroundColor:kCellSelectedBackgroundColor];
    NSInteger currentSelectedButtonIndex = button.tag - kFloaterAdjustDislplayButtonTag;
    [kUserDefaults setObject:@(currentSelectedButtonIndex)
                      forKey:@"currentSelectedButtonIndex"];
    [kUserDefaults synchronize];
}

@end

#pragma mark - DDMainUINaviController

@interface DDMainUINaviController () <
    UITableViewDataSource,
    UITableViewDelegate
>

@property (retain, nonatomic) NSArray *dataSource;

// show floater
- (void)showFloaterAdjustView;
// disappear floater
- (void)disappearFloaterAdjustView;

@end

@implementation DDMainUINaviController

- (void)dealloc {
    
    [_dataSource release];
    
    [_titleOnlyView release];
    [_listView release];
    [_magazineView release];
    [_cardsView release];
    
    [_refresh release];
    [_markCategroyAsRead release];
    [_toggleOldestFirst release];
    [_toggleShowStoriesPolicy release];
    [_openWebpageDirectly release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationBar.barTintColor = [UIColor whiteColor];
        self.navigationBar.tintColor = [UIColor grayColor];
        [self.navigationBar setBackgroundImage:DDImageWithName(@"navi")
                                 forBarMetrics:UIBarMetricsDefault];
        
        [kUserDefaults setObject:@0 forKey:@"currentSelectedButtonIndex"];
        [kUserDefaults synchronize];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - UIViewControllerTransitioningDelegate

// Present
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[[DDPresentAnimation alloc] init] autorelease];
    
}

// Dismiss
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[[DDDismissAnimation alloc] init] autorelease];
}

#pragma mark - Display floater adjust view

- (void)showFloaterAdjustView {

    UIView *clearView = [[UIView alloc] init];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    clearView.frame = screenBounds;
    clearView.tag = kClearViewTag;
    [self.view addSubview:clearView];
    [clearView release];
    
    CGRect frame = CGRectMake(CGRectGetWidth(screenBounds) * 0.2,
                              70,
                              CGRectGetWidth(screenBounds) * 0.78,
                              44 * 6);
    UITableView *settingTableView = [[UITableView alloc]
                                     initWithFrame:frame
                                     style:UITableViewStylePlain];
    settingTableView.tag = kSettingViewTag;
    settingTableView.bounces = NO;
    settingTableView.rowHeight = 44;
    settingTableView.delegate = self;
    settingTableView.dataSource = self;
    settingTableView.separatorColor = [UIColor grayColor];
    [self.view addSubview:settingTableView];
    [settingTableView release];
    
    
    NSLog(@"currentSelectedButtonIndex= %@", [kUserDefaults objectForKey:@"currentSelectedButtonIndex"]);
    HeaderView *headerView = [[HeaderView alloc] init];
    headerView.headerTitleOnlyView = ^{
        if (_titleOnlyView) {
            _titleOnlyView();
            [self disappearFloaterAdjustView];
        }
    };
    headerView.headerListView = ^{
        if (_listView) {
            _listView();
            [self disappearFloaterAdjustView];
        }
    };
    headerView.headerMagazineView = ^{
        if (_magazineView) {
            _magazineView();
            [self disappearFloaterAdjustView];
        }
    };
    headerView.headerCardsView = ^{
        if (_cardsView) {
            _cardsView();
            [self disappearFloaterAdjustView];
        }
    };
    settingTableView.tableHeaderView = headerView;
    [headerView release];
    
    NSArray *images = @[DDImageWithName(@"mobile-action-refresh"),
                        DDImageWithName(@"mobile-action-mark-as-read"),
                        DDImageWithName(@"mobile-action-oldest-first"),
                        DDImageWithName(@"mobile-action-unread"),
                        DDImageWithName(@"mobile-action-visit")];
    NSArray *titles = @[@"Refresh",
                        @"Mark Category As Read",
                        @"Oldest Stories First",
                        @"Show Updates Only",
                        @"Open WebPage Directly"];
    NSMutableArray *datas = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        NSArray *objs = @[images[i], titles[i]];
        NSArray *keys =  @[@"image", @"title"];
        NSDictionary *dict = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
        [datas addObject:dict];
    }
    self.dataSource = datas;
    [datas release];
}

- (void)disappearFloaterAdjustView {
    UIView *clearView = (UIView *)[self.view viewWithTag:kClearViewTag];
    if (clearView) {
        [clearView removeFromSuperview];
    }
    
    UITableView *settingTableView = (UITableView *)[self.view viewWithTag:kSettingViewTag];
    if (settingTableView) {
        [UIView animateWithDuration:0.5 animations:^{
            settingTableView.alpha = 0;
        } completion:^(BOOL finished) {
            [settingTableView removeFromSuperview];
        }];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self disappearFloaterAdjustView];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {

    NSInteger count = 0;
    if (_dataSource && [_dataSource isKindOfClass:[NSArray class]]) {
        count = _dataSource.count;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *settingViewCellIdentifier = @"settingViewCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingViewCellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:settingViewCellIdentifier] autorelease];
        cell.backgroundColor = kCellBackgroundColor;
        UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        selectedBackgroundView.backgroundColor = kCellSelectedBackgroundColor;
        cell.selectedBackgroundView = selectedBackgroundView;
        [selectedBackgroundView release];
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    if (_dataSource
        && [_dataSource isKindOfClass:[NSArray class]]
        && _dataSource.count > 0) {
        NSString *textLabelText = _dataSource[indexPath.row][@"title"];
        cell.textLabel.text = textLabelText ? textLabelText : @"";
        UIImage *imageViewImage = _dataSource[indexPath.row][@"image"];
        cell.imageView.image = imageViewImage ? imageViewImage : nil;
    }

    return cell;
}


#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    switch (indexPath.row) {
        case 0: {
            // refresh
            if (_refresh) {
                _refresh();
                [self disappearFloaterAdjustView];
            }
        }
            break;
        case 1: {
            // mark categroy as read
            if (_markCategroyAsRead) {
                _markCategroyAsRead();
                [self disappearFloaterAdjustView];
            }
        }
            break;
        case 2: {
            // toggle oldest stories first
            if (_toggleOldestFirst) {
                _toggleOldestFirst();
                [self disappearFloaterAdjustView];
            }
        }
            break;
        case 3: {
            // toggle show stories policy
            if (_toggleShowStoriesPolicy) {
                _toggleShowStoriesPolicy();
                [self disappearFloaterAdjustView];
            }
        }
            break;
        case 4: {
            // open webpage directly
            if (_openWebpageDirectly) {
                _openWebpageDirectly();
                [self disappearFloaterAdjustView];
            }
        }
            break;
        default:
            break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end