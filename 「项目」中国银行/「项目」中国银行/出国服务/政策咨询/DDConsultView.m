//
//  DDConsultView.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-14.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDConsultView.h"
#import "DDPullDown.h"

@interface DDConsultView ()<
    UITableViewDelegate,
    UITableViewDataSource>
{
    NSMutableArray *_dataSource;
}

@end

@implementation DDConsultView

- (void)dealloc
{
    NSLog(@"%@ dealloc", [self class]);
    [_dataSource release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // tableView baackground
        UIImageView *tableViewBackgorundView = [[UIImageView alloc] init];
        tableViewBackgorundView.frame = self.bounds;
        // 背景图片多次利用，需要cache
        tableViewBackgorundView.image = kImageWithName(@"背景");
        
        // tableView
        UITableView *tableView = [[UITableView alloc] init];
        tableView.bounds = CGRectMake(0, 0, 800, 450);
        tableView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                       CGRectGetMidY(self.bounds));
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 60;
        tableView.backgroundView = tableViewBackgorundView;
        [tableViewBackgorundView release];
        [self addSubview:tableView];
        [tableView release];
        
        // 下拉刷新
        DDPullDown *pullDown = [DDPullDown pullDown];
        pullDown.scrollView = tableView;
        pullDown.lastUpdate.textColor = [UIColor whiteColor];
        pullDown.status.textColor = [UIColor whiteColor];
        pullDown.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;

        pullDown.arrow.image = kImageWithName(@"blackArrow");
        pullDown.beginRefreshBaseView = ^(DDRefreshBaseView *refreshBaseView) {
            [DDHTTPManager sendRequstWithPageSize:@"12"
                                       pageNumber:@"1"
                                          byTitle:@""
                                       byKeywords:@""
                                completionHandler:^(id content, NSString *resultCode) {
                // 初始化数据源，加载数据
                NSMutableArray *data = content;
                if (_dataSource != data) {
                    [_dataSource release];
                    _dataSource = nil;
                    _dataSource = [data mutableCopy];
                }
                [tableView reloadData];
                [refreshBaseView performSelector:@selector(endRefreshingWithSuccess:)
                                      withObject:nil
                                      afterDelay:1];
            }];
        };
        
        // 上下两条阴影
        UIImageView *upShadowView = [[UIImageView alloc] init];
        upShadowView.bounds = CGRectMake(0, 0, CGRectGetWidth(tableView.bounds) * 1.1, 5);
        upShadowView.center = CGPointMake(CGRectGetMidX(tableView.frame),
                                          CGRectGetMinY(tableView.frame) +
                                          CGRectGetMidY(upShadowView.bounds));
        upShadowView.image = kImageWithName(@"up_19");
        [self addSubview:upShadowView];
        [upShadowView release];
        
        UIImageView *downShadowView = [[UIImageView alloc] init];
        downShadowView.bounds = CGRectMake(0, 0, CGRectGetWidth(tableView.bounds) * 1.1, 5);
        downShadowView.center = CGPointMake(CGRectGetMidX(tableView.frame),
                                            CGRectGetMaxY(tableView.frame) +
                                            CGRectGetMidY(downShadowView.bounds));
        downShadowView.image = kImageWithName(@"down_27");
        [self addSubview:downShadowView];
        [downShadowView release];
        
        // 两个Label
        UILabel *serialNumberLabel = [[UILabel alloc] init];
        serialNumberLabel.bounds = CGRectMake(0, 0, 125, 40);
        serialNumberLabel.center = CGPointMake(CGRectGetMinX(tableView.frame) +
                                               CGRectGetMidX(serialNumberLabel.bounds),
                                               upShadowView.center.y -
                                               CGRectGetMidY(serialNumberLabel.bounds));
        serialNumberLabel.font = [UIFont systemFontOfSize:22];
        serialNumberLabel.textColor = [UIColor whiteColor];
        serialNumberLabel.textAlignment = NSTextAlignmentCenter;
        serialNumberLabel.text = @"编号";
        [self addSubview:serialNumberLabel];
        [serialNumberLabel release];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.bounds = CGRectMake(0, 0, 675, 40);
        titleLabel.center = CGPointMake(CGRectGetMaxX(serialNumberLabel.frame) +
                                        CGRectGetMidX(titleLabel.bounds),
                                        upShadowView.center.y -
                                        CGRectGetMidY(serialNumberLabel.bounds));
        titleLabel.font = [UIFont systemFontOfSize:22];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = @"标题";
        [self addSubview:titleLabel];
        [titleLabel release];
        
        // 加载数据
        [DDHTTPManager sendRequstWithPageSize:@"12"
                                   pageNumber:@"1"
                                      byTitle:@""
                                   byKeywords:@""
                            completionHandler:^(id content, NSString *resultCode) {
            // 初始化数据源，加载数据
            _dataSource = [content mutableCopy];
            [tableView reloadData];
        }];
    }
    
    return self;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;
    if (_dataSource != nil &&
        [_dataSource isKindOfClass:[NSArray class]]) {
        count = _dataSource.count;
    }

    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier  = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    UILabel *titleViewLabel = nil;
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                                       reuseIdentifier:identifier] autorelease];
        UIImageView *backgroundView = [[UIImageView alloc]
                                       initWithImage:[UIImage imageNamed:@"excel_23"]];
        cell.backgroundView = backgroundView;
        [backgroundView release];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.numberOfLines = 1;
        cell.detailTextLabel.textAlignment = NSTextAlignmentCenter;
        cell.detailTextLabel.textColor = [UIColor redColor];

        titleViewLabel = [[UILabel alloc] init];
        titleViewLabel.bounds = CGRectMake(0, 0, 675, tableView.rowHeight);
        titleViewLabel.center = CGPointMake(125 + CGRectGetMidX(titleViewLabel.bounds),
                                            CGRectGetMidY(titleViewLabel.bounds));
        titleViewLabel.textAlignment = NSTextAlignmentCenter;
        titleViewLabel.textColor = [UIColor grayColor];
        [cell.contentView addSubview:titleViewLabel];
        [titleViewLabel release];
    }
    if (_dataSource && _dataSource.count > 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
        titleViewLabel.text = _dataSource[indexPath.row][@"title"];
    }
    return cell;
}

@end
