//
//  DDDetailViewController.m
//  「UI」代码块反向传值
//
//  Created by 萧川 on 14-2-24.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "DDDetailViewController.h"

@interface DDDetailViewController ()

@property (retain, nonatomic) UITextField *input;

@end

@implementation DDDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        _input = [[UITextField alloc] init];
    }
    return self;
}

//- (id)initWithBlock:(SendValue)str
//{
//    if (self = [super init]) {
//        _input = [[UITextField alloc] init];
//        _block = [str copy];
//    }
//    return self;
//}

- (id)initWithBlock:(void (^)(NSString *))block
{
    if (self = [super init]) {
        _input = [[UITextField alloc] init];
        _sendValue = [block copy];
    }
    return self;
}

- (void)dealloc
{
    [_input release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.view.backgroundColor = [UIColor whiteColor];

    UIButton *goNext = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    goNext.bounds = CGRectMake(0, 0, 80, 40);
    goNext.center = CGPointMake(self.view.center.x, self.view.center.y - 80);
    [goNext setTitle:@"回上一页" forState:UIControlStateNormal];
    [goNext addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goNext];

    _input.bounds = CGRectMake(0, 0, 320, 40);
    _input.center = self.view.center;
    _input.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_input];
}

- (void)buttonPressed:(UIButton *)sender
{
    NSString *str = _input.text;
//    if (_block) {
//        _block(str);
//    }
    if (_sendValue) {
        _sendValue(str);
    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
