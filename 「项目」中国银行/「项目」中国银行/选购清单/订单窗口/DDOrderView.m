//
//  DDOrderView.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-15.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDOrderView.h"
#import "DDChoose.h"

@implementation DDOrderView

- (void)dealloc
{
    NSLog(@"%@ is dealloced", [self class]);
    [_swipRight release];
    [_dataSource release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        // 订单号
        UILabel *orderNumberLabel = [self label];
        orderNumberLabel.bounds = CGRectMake(0, 0, 100, 40);
        orderNumberLabel.center = CGPointMake(CGRectGetMidX(orderNumberLabel.bounds) + 50,
                                              CGRectGetMidY(orderNumberLabel.bounds) + 50);
        orderNumberLabel.textAlignment = NSTextAlignmentRight;
        orderNumberLabel.text = @"订单号: ";
        [self addSubview:orderNumberLabel];
        
        UILabel *orderLabel = [self label];
        orderLabel.bounds = CGRectMake(0, 0, 300, 40);
        orderLabel.center = CGPointMake(CGRectGetMaxX(orderNumberLabel.frame) +
                                        CGRectGetMidX(orderLabel.bounds) + 10,
                                        CGRectGetMidY(orderNumberLabel.bounds) + 50);
        [self addSubview:orderNumberLabel];
        
        // 姓名
        UILabel *nameLabel = [self label];
        nameLabel.bounds = CGRectMake(0, 0, 100, 40);
        nameLabel.center = CGPointMake(CGRectGetMidX(nameLabel.bounds) + 50,
                                       CGRectGetMaxY(orderNumberLabel.frame) +
                                       CGRectGetMidY(nameLabel.bounds));
        nameLabel.textAlignment = NSTextAlignmentRight;
        nameLabel.text = @"姓名: ";
        [self addSubview:nameLabel];
        
        UILabel *nameDisplayLabel = [self label];
        nameDisplayLabel.bounds = CGRectMake(0, 0, 300, 40);
        nameDisplayLabel.center = CGPointMake(CGRectGetMaxX(nameLabel.frame) +
                                              CGRectGetMidX(nameDisplayLabel.bounds) + 10,
                                        CGRectGetMaxY(nameLabel.frame) +
                                              CGRectGetMidY(nameLabel.bounds));
        [self addSubview:nameDisplayLabel];
        
        // 联系电话
        UILabel *phoneNumberLabel = [self label];
        phoneNumberLabel.bounds = CGRectMake(0, 0, 100, 40);
        phoneNumberLabel.center = CGPointMake(CGRectGetMidX(phoneNumberLabel.bounds) + 50,
                                       CGRectGetMaxY(nameLabel.frame) +
                                              CGRectGetMidY(phoneNumberLabel.bounds));
        phoneNumberLabel.textAlignment = NSTextAlignmentRight;
        phoneNumberLabel.text = @"联系电话: ";
        [self addSubview:phoneNumberLabel];
        
        UILabel *phoneNumberDisplayLabel = [self label];
        phoneNumberDisplayLabel.bounds = CGRectMake(0, 0, 300, 40);
        phoneNumberDisplayLabel.center = CGPointMake(CGRectGetMaxX(phoneNumberLabel.frame) +
                                                     CGRectGetMidX(phoneNumberDisplayLabel.bounds) + 10,
                                              CGRectGetMaxY(nameDisplayLabel.frame) +
                                                     CGRectGetMidY(phoneNumberDisplayLabel.bounds));
        [self addSubview:phoneNumberDisplayLabel];
        
        // 提交按钮
        UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        submitButton.bounds = CGRectMake(0, 0, 159, 50);
        submitButton.center = CGPointMake(CGRectGetMidX(self.bounds),
                                          CGRectGetMaxY(self.bounds) -
                                          CGRectGetMidY(submitButton.bounds) - 20);
        [submitButton setBackgroundImage:kImageWithName(@"提交办理")
                                forState:UIControlStateNormal];
        [submitButton addTarget:self
                         action:@selector(submit:)
               forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:submitButton];
        
        // 添加右滑手势
        UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(handleSwipRight)];
        swipRight.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipRight];
        [swipRight release];
    }
    return self;
}

- (UILabel *)label
{
    UILabel *label = [[[UILabel alloc] init] autorelease];
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor blackColor];
    
    return label;
}

- (void)submit:(UIButton *)sender
{
    NSLog(@"提交办理");

    NSLog(@"%@", _dataSource);
    NSLog(@"%@", _dataSource[@"clientId"]);
    NSLog(@"%@", _dataSource[@"clientName"]);
    NSLog(@"%@", _dataSource[@"clientTel"]);
    NSLog(@"%@", _dataSource[@"shoppingList"]);
    NSLog(@"%@", _dataSource[@"userId"]);
    NSLog(@"%@", _dataSource[@"amountList"]);
    // 提交买产品
    [DDHTTPManager sendRequestForBuyProductsWithClientId:_dataSource[@"clientId"]
                                              clientName:_dataSource[@"clientName"]
                                               clientTel:_dataSource[@"clientTel"]
                                            shoppingList:_dataSource[@"shoppingList"]
                                                  status:@"0"
                                                  userId:_dataSource[@"userId"]
                                              amountList:_dataSource[@"amountList"]
                                       completionHandler:^(id content, NSString *resultCode) {
                                           echo();
                                           // 显示购买完成，干掉清单数据
                                           NSError *error = nil;
                                           BOOL success =[[NSFileManager defaultManager]
                                                          removeItemAtPath:PATH_ORDER
                                                          error:&error];
                                           NSAssert(success, @"remove file failure with %@", [error description]);
                                           
                                           DDChoose *choose = (DDChoose *)self.superview;
                                           choose.dataSource = nil;
                                           [choose.tableView reloadData];
                                           
                                            if (_swipRight) {
                                                _swipRight();
                                            }
                                          }];
}

- (void)handleSwipRight
{
    if (_swipRight) {
        _swipRight();
    }
}


@end
