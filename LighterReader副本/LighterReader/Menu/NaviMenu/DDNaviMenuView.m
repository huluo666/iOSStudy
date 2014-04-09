//
//  DDNaviMenuView.m
//  LighterReader
//
//  Created by 萧川 on 14-3-29.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDNaviMenuView.h"
#import "DDNaviCell.h"
#import "DDCellObj.h"

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
@property (strong, nonatomic) NSArray *originTitles;

@property (strong, nonatomic) NSMutableArray *foldingIndexs;


// .....
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
    
    // section 2
//    NSArray *titles = @[@"All", @"CNiDev", @"11111", @"2222", @"3333", @"Reader Test", @"4444444", @"5555555", @"6666666", @"7777777", @"888888888", @"9999999999999", @"jjjj", @"ddddd", @"ddddd", @"ddddd", @"ddddd", @"ddddd"];
    
    NSArray *titles = @[@"All", @"CNiDev", @"11111", @"2222", @"3333", @"Reader Test", @"4444444", @"5555555", @"6666666"];
    self.foldingIndexs = [[NSMutableArray alloc] initWithObjects:@1, @2, nil];
    
    
    // section 3
    NSArray *section3 = @[@"Recently Read", @"Edit Content", @"Switch Theme", @"Settings", @"Logout"];
    
    self.originDataSource = @[section1, titles, section3];
    
    
    // .....
    _dataSource = [[NSMutableArray alloc] init];
    NSArray *titleStrings = @[@"All", @"CNiDev", @"Reader"];
    
    for (int i = 0 ; i < 3; i++) {
        DDCellObj *obj = [[DDCellObj alloc] init];
        obj.titleString = titleStrings[i];
        [_dataSource addObject:obj];
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
            
            if (0 == indexPath.row) {
                cell.leftImageView.image = DDImageWithName(@"mobile-selector-latest-white");
            }
            
            NSLog(@"%@", _dataSource);
            cell.titleLabel.text = [_dataSource[indexPath.row] titleString];
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
