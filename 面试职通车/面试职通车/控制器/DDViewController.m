//
//  DDViewController.m
//  面试职通车
//
//  Created by 萧川 on 14-4-16.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDViewController.h"
#import "UIButton+Generate.h"

@interface DDViewController ()


@end

@implementation DDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        return [self initWithType:DDViewControllerTypeDefault];
    }
    return self;
}


- (id)initWithType:(DDViewControllerType)aViewControllerType {
    
    if (self = [super init]) {

        _viewControllerType = aViewControllerType;
        _titleView = [[UIView alloc] init];
    }
    return self;
}

- (void)viewDidLoad {

    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *image = DDImageWithName(@"title_back");
    UIImageView *backView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:backView];
    
    if (DDViewControllerTypeDefault == _viewControllerType) {
        backView.frame = CGRectMake(0, 0, 320, 64);
    } else {
        backView.frame = CGRectMake(0, 0, 320, 290);

    }
    
    // 添加titleView
    _titleView.frame = CGRectMake(0, 20, 320, 44);
    [self.view addSubview:_titleView];
    
    // 添加titleLael
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:_titleView.bounds];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.title;
    [_titleView addSubview:titleLabel];
    
    // 添加按钮
    UIButton *leftButton = [[UIButton alloc]
                            initWithOrigin:CGPointZero
                            image:DDImageWithName(@"title_return")
                            target:self
                            action:@selector(popSelf)];
    [_titleView addSubview:leftButton];
}

- (void)popSelf {
    
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}



@end
