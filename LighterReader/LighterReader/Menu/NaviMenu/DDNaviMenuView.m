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
    
    // section 2
    _dataSource = [[NSMutableArray alloc] initWithArray:@[@"All"]];
    _foldableCellIndexPaths = [[NSMutableDictionary alloc] init];
    _recored = [[NSMutableArray alloc] init];
    
    NSDictionary *dict1 = @{@"CNiDev":@[@"1111", @"2222", @"2211", @"jd", @"333"], @"Reader":@[@"44444", @"55555", @"6666", @"77777"], @"News":@[@"News-1", @"News-2", @"News-3", @"News-4", @"News-5"]};
    [self addDataWithDictionary:dict1];
    
    _selectedIndexPath = [[NSMutableArray alloc] init];
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
        
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        for (NSInteger i = start; i <= start + valueArr.count - 1; i++) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:1];
            [tempArr addObject:path];
            [_recored addObject:path];
        }
        [_foldableCellIndexPaths setObject:tempArr forKey:key];
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
            NSString *imageName =  self.originDataSource[0][0][@"imagesName"][indexPath.row];
            cell.leftImageView.image = DDImageWithName(imageName);
            NSString *title = self.originDataSource[0][1][@"titles"][indexPath.row];
            cell.titleLabel.text = title;
            return cell;
        }
            break;
            
        case 1: {
            DDNaviCell *cell = [tableView dequeueReusableCellWithIdentifier:dropCellIdentifier];
            if (!cell) {
                cell = [[DDNaviCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dropCellIdentifier];
            }

            if (indexPath.section == 1 && indexPath.row == 0) {
                cell.leftImageView.image = [UIImage imageNamed:@"mobile-selector-latest-white"];
            } else {
                cell.leftImageView.image = nil;
            }
            
            if ([[_foldableCellIndexPaths allKeys] containsObject:indexPath]) {
                // can be flod
                [cell.imageButton setBackgroundImage:DDImageWithName(@"mobile-selector-right-arrow-white") forState:UIControlStateNormal];
                [cell.imageButton setBackgroundImage:DDImageWithName(@"mobile-selector-down-arrow-white") forState:UIControlStateSelected];
                
                // record group's selected
                if ([_selectedIndexPath containsObject:indexPath]) {
                    cell.imageButton.selected = YES;
                } else {
                    cell.imageButton.selected = NO;
                }
                
                // flod、expand actions
                cell.imageButtonAction = ^(UIButton *sender){
                    NSArray *arr = [_foldableCellIndexPaths objectForKey:indexPath];
                    if (sender.isSelected) {
                        [_selectedIndexPath addObject:indexPath];
                        [_recored removeObjectsInArray:arr];
                    } else {
                        [_selectedIndexPath removeObject:indexPath];
                        [_recored addObjectsFromArray:arr];
                    }
                    [tableView reloadData];
                };
            } else {
                // can not be flod
                [cell.imageButton setBackgroundImage:nil forState:UIControlStateNormal];
                [cell.imageButton setBackgroundImage:nil forState:UIControlStateSelected];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld, %ld" ,indexPath.row, indexPath.section);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger rowHeight = 44;
    if ([_recored containsObject:indexPath]) {
        rowHeight = 0;
    }
    return rowHeight;
}

@end
