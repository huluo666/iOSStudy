//
//  DDNaviMenuView.m
//  LighterReader
//
//  Created by 萧川 on 14-3-29.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDNaviMenuView.h"
#import "DDNaviCell.h"

@interface DDNaviMenuView () <
    UITableViewDelegate,
    UITableViewDataSource
>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *selfDataSource;
@property (strong, nonatomic) NSArray *originTitles;

@end

@implementation DDNaviMenuView

#pragma mark - init

- (id)initWithFrame:(CGRect)frame
{
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
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds
                                                      style:UITableViewStyleGrouped];
        self.tableView.backgroundColor = [UIColor colorWithWhite:0.942 alpha:1.000];
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self addSubview:self.tableView];
        
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
    NSDictionary *sectionImageDict = [NSDictionary dictionaryWithObject:section1ImagesName forKey:@"imagesName"];
    NSDictionary *sectionTitleDict = [NSDictionary dictionaryWithObject:section1Titles forKey:@"titles"];
    NSArray *section1 = @[sectionImageDict, sectionTitleDict];
    
    // section 2
    NSArray *section2 = @[@"All", @"CNiDev", @"Reader Test"];
    self.originTitles = section2;
    
    // section 3
    NSArray *section3 = @[@"Recently Read", @"Edit Content", @"Switch Theme", @"Settings", @"Logout"];
    
    self.selfDataSource = [NSMutableArray arrayWithArray:@[section1, section2, section3]];
    
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
            count = 3;
        }
            break;
        case 1: {
            count = [self.selfDataSource[1] count];
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

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"normalCell";
    static NSString *dropDownCellIdentifier = @"DropDownCell";
    switch (indexPath.section) {
        case 0: {
            DDNaviCell *cell = [tableView dequeueReusableCellWithIdentifier:dropDownCellIdentifier];
            if (!cell) {
                cell = [[DDNaviCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:dropDownCellIdentifier];
            }
            NSString *imageName =  self.selfDataSource[0][0][@"imagesName"][indexPath.row];
            cell.leftImageView.image = DDImageWithName(imageName);
            NSString *title = self.selfDataSource[0][1][@"titles"][indexPath.row];
            cell.titleLabel.text = title;
            return cell;
        }
            break;
            
        case 1: {
            DDNaviCell *cell = [tableView dequeueReusableCellWithIdentifier:dropDownCellIdentifier];
            if (!cell) {
                cell = [[DDNaviCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:dropDownCellIdentifier];

                if (indexPath.row) {
                    [cell.imageButton setBackgroundImage:DDImageWithName(@"mobile-selector-right-arrow-white")
                                                forState:UIControlStateNormal];
                    [cell.imageButton setBackgroundImage:DDImageWithName(@"mobile-selector-down-arrow-white")
                                                forState:UIControlStateSelected];
                } else {
                    cell.leftImageView.image = DDImageWithName(@"mobile-selector-latest-white");
                }
            }
            
            cell.titleLabel.text = self.selfDataSource[1][indexPath.row];
            
            __weak DDNaviCell *weakCell = cell;
            cell.imageButtonAction = ^{
                if (!indexPath.row) {
                    return;
                }
                
                if (weakCell.imageButton.isSelected) {
                    NSLog(@"selected");
                    NSLog(@"%@", self.selfDataSource);
                    NSArray *section2 = @[@"All", @"CNiDev", @"add", @"add2", @"add3", @"add4", @"Reader Test"];
                    [self.selfDataSource removeObjectAtIndex:1];
                    [self.selfDataSource insertObject:section2 atIndex:1];
                    [self.tableView reloadData];
                    NSLog(@"%@", self.selfDataSource);
                } else {
                    NSLog(@"deSelected");
                    [self.selfDataSource removeObjectAtIndex:1];
                    [self.selfDataSource insertObject:self.originTitles atIndex:1];
                    [self.tableView reloadData];
                }

            };
            return cell;
        }
            break;
            
        case 2: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:cellIdentifier];
            }
            
            cell.textLabel.text = self.selfDataSource[2][indexPath.row];
            return cell;
        }
            break;
            
        default: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:cellIdentifier];
            }
            return cell;
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"didSelectRowAtIndexPath");
}

#pragma mark - <UITableViewDelegate>


@end
