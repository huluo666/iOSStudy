//
//  DDMoreOptionsViewController.m
//  面试职通车
//
//  Created by 萧川 on 14-4-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDMoreOptionsViewController.h"
#import "UIImageView+Generate.h"

@interface DDMoreOptionsViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation DDMoreOptionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"更多";
        _dataSource = @[@"more_系统设置",
                        @"more_系统设置",
                        @"more_新手帮助",
                        @"more_意见反馈",
                        @"more_关于我们"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"moreCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }

    UIImageView *imageView = [[UIImageView alloc]
                           initWithOrigin:CGPointZero
                           image:DDImageWithName(_dataSource[indexPath.row])
                           highlightedImage:nil];
    [cell.contentView addSubview:imageView];
    return cell;
}


@end
