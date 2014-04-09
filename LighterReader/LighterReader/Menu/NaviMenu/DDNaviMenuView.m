//
//  DDNaviMenuView.m
//  LighterReader
//
//  Created by 萧川 on 14-3-29.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDNaviMenuView.h"
#import "DDNaviCell.h"

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

// section 2
@property (strong, nonatomic) NSMutableArray *dataSource;

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
    
    // section 3
    NSArray *section3 = @[@"Recently Read", @"Edit Content", @"Switch Theme", @"Settings", @"Logout"];
    
    self.originDataSource = @[section1, @[], section3];
    
    
    // .....
    _dataSource = [[NSMutableArray alloc] init];
    NSArray *titleStrings = @[@"All", @"CNiDev", @"Reader"];


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

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifier = @"normalCell";
    static NSString *customCellIdentifier = @"customCell";
    switch (indexPath.section) {
        case 0: {
            DDNaviCell *cell = [tableView dequeueReusableCellWithIdentifier:customCellIdentifier];
            if (!cell) {
                cell = [[DDNaviCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:customCellIdentifier];
            }
            NSString *imageName =  self.originDataSource[0][0][@"imagesName"][indexPath.row];
            cell.leftImageView.image = DDImageWithName(imageName);
            NSString *title = self.originDataSource[0][1][@"titles"][indexPath.row];
            cell.titleLabel.text = title;
            return cell;
        }
            break;
            
        case 1: {

            DDNaviCell *cell = [[DDNaviCell alloc] init];

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
            
            cell.textLabel.text = self.originDataSource[2][indexPath.row];
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

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld, %ld" ,indexPath.row, indexPath.section);
}

@end
