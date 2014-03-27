//
//  DDMenuView.m
//  LighterReader
//
//  Created by 萧川 on 14-3-27.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDMenuView.h"

@interface DDMenuView ()

@property (nonatomic ,assign, getter = isLogin) BOOL login;

@end

@implementation DDMenuView

- (void)dealloc
{
    [_handleLeftSwip release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
        [swipLeft release];
        
//        _login = YES;
        if (!_login) {
            // 登录、注册
            self.contentSize = CGSizeMake(CGRectGetWidth(self.bounds),
                                          CGRectGetHeight(self.bounds));
            self.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds) * 0.9, 40);
            titleLabel.center = CGPointMake(CGRectGetMidX(self.bounds),
                                       CGRectGetMidY(titleLabel.bounds) + 20);
            titleLabel.textColor = [UIColor grayColor];
            titleLabel.font = [UIFont systemFontOfSize:24];
            titleLabel.text = @"Get started";
            titleLabel.numberOfLines = 0;
            [self addSubview:titleLabel];
            [titleLabel release];
            
            UILabel *introduceLabel = [[UILabel alloc] init];
            introduceLabel.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds) * 0.9, 60);
            introduceLabel.center = CGPointMake(CGRectGetMidX(self.bounds),
                                                CGRectGetMaxY(titleLabel.frame) +
                                                CGRectGetMidY(introduceLabel.bounds));
            introduceLabel.textColor = [UIColor grayColor];
            introduceLabel.font = [UIFont systemFontOfSize:16];
            introduceLabel.text = @"Get the content of your favorite websites delivered to your feedly";
            introduceLabel.lineBreakMode = NSLineBreakByWordWrapping;
            introduceLabel.numberOfLines = 0;
            [self addSubview:introduceLabel];
            [introduceLabel release];
            
            UIButton *loginWithFacebook = [self buttonWithBackgroundImage:
                                           DDImageWithName(@"Buffer-FacebookLogin")];
            loginWithFacebook.tag = kMenuButtonTag;
            loginWithFacebook.center = CGPointMake(CGRectGetMidX(self.bounds),
                                                   CGRectGetMidY(loginWithFacebook.bounds) +
                                                   CGRectGetMaxY(introduceLabel.frame) + 40);
            
            UIButton *loginWithTwitter = [self buttonWithBackgroundImage:
                                          DDImageWithName(@"Buffer-TwitterLogin")];
            loginWithTwitter.tag = kMenuButtonTag + 1;
            loginWithTwitter.center = CGPointMake(CGRectGetMidX(self.bounds),
                                                  CGRectGetMaxY(loginWithFacebook.frame) +
                                                  CGRectGetMidY(loginWithTwitter.bounds) +
                                                  30);
            UIButton *loginWithBuffer = [self buttonWithBackgroundImage:DDImageWithName(@"Buffer-BufferLogin")];
            loginWithBuffer.tag = kMenuButtonTag + 2;
            loginWithBuffer.center = CGPointMake(CGRectGetMidX(self.bounds),
                                                 CGRectGetMaxY(loginWithTwitter.frame) +
                                                 CGRectGetMidY(loginWithBuffer.bounds) +
                                                 30);
            UIButton *loginWithReader = [self buttonWithBackgroundImage:nil];
            loginWithReader.tag = kMenuButtonTag + 3;
            loginWithReader.center = CGPointMake(CGRectGetMidX(self.bounds),
                                                 CGRectGetMaxY(loginWithBuffer.frame) +
                                                 CGRectGetMidY(loginWithReader.bounds) +
                                                 30);
            [loginWithReader setTitle:@"Sign in with lighter Reader" forState:UIControlStateNormal];
            
            UIButton *createNewAccount = [self buttonWithBackgroundImage:nil];
            createNewAccount.tag = kMenuButtonTag + 4;
            createNewAccount.center = CGPointMake(CGRectGetMidX(self.bounds),
                                                 CGRectGetMaxY(loginWithReader.frame) +
                                                 CGRectGetMidY(createNewAccount.bounds) +
                                                 30);
            [createNewAccount setTitle:@"Create an new account" forState:UIControlStateNormal];
        } else {
            // 显示菜单信息
            
        }
    }
    return self;
}

#pragma mark - private messages

- (void)swipLeftAction
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    if (_handleLeftSwip) {
        _handleLeftSwip();
    }
}

- (UIButton *)buttonWithBackgroundImage:(UIImage *)backgroundImage
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.bounds = CGRectMake(0, 0, 252, 29);
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    button.clipsToBounds = YES;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.cornerRadius = 5;
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(buttonAction:)
     forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
}

- (void)buttonAction:(UIButton *)sender
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSInteger index = sender.tag - kMenuButtonTag;
    if (3 == index) {
        // 登录
        
    }
    if (4 == index) {
        // 注册

    }
    
    [self swipLeftAction];
}

@end
