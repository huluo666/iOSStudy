//
//  DDAbout.m
//  LighterReader
//
//  Created by 萧川 on 14-4-14.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDAbout.h"

@interface DDAbout () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation DDAbout

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView.dataSource = self;
        tableView.delegate = self;
        [self addSubview:tableView];
        
        UISwipeGestureRecognizer *swipDown = [[UISwipeGestureRecognizer alloc]
                                              initWithTarget:self
                                              action:@selector(removeSelf)];
        swipDown.direction = UISwipeGestureRecognizerDirectionDown;
        [self addGestureRecognizer:swipDown];
        
        _dataSource = @[@"About US",
                        @"Go to Work",
                        @"Get Married",
                        @"Have some kids",
                        @"Pay your taxes",
                        @"Watch your TV",
                        @"Follow fashion",
                        @"Act normal",
                        @"Obey the law",
                        @"And repeat after me",
                        @"I AM FREE",
                        @"CopyLeft@cuan 2014",
                        @"Twitter:atcuan@gmail.com"];
        
        CGRect selfFrame = self.frame;
        self.center = CGPointMake(self.center.x, 3 * self.center.y);
        [UIView animateWithDuration:1 animations:^{
            self.frame = selfFrame;
        }];
    }
    return self;
}

- (void)removeSelf {
    
    [UIView animateWithDuration:1 animations:^{
        self.center = CGPointMake(self.center.x, 3 * self.center.y);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}

#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifer = @"cellIdenitfier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
        cell.backgroundColor = [UIColor whiteColor];
        cell.tintColor = [UIColor whiteColor];
        UIView *view = [[UIView alloc] initWithFrame:cell.contentView.bounds];
        view.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView = view;
    }
    
    if (0 == indexPath.row) {
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.textLabel.textColor = [UIColor grayColor];
    } else if (10 == indexPath.row) {
        cell.textLabel.font = [UIFont systemFontOfSize:22];
        cell.textLabel.textColor = [UIColor blackColor];
    } else {
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor grayColor];
    }
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath; {
    
    return self.bounds.size.height / _dataSource.count;
}


@end
