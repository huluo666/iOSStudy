//
//  MainViewController.m
//  LoginDemo
//
//  Created by wei.chen on 13-1-15.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MainViewController.h"
#import "WXHLDataService.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_loginLabel release];
    [super dealloc];
}

- (IBAction)loginAction:(id)sender {
    // * 接口参数:
    // password   密码
    //username    账户名
    //Version   客户端版本         //3.3.0
    //Channel    渠道             //ios||iPhone OS##6.0.1||appstore||appstore_3.3.0
    NSDictionary *params = @{@"username":@"35965539@qq.com",@"password":@"123456",@"Version":@"3.3.0",@"Channel":@"ios||iPhone OS##6.0.1||appstore||appstore_3.3.0"};
    [WXHLDataService login:params competeBlock:^(NSDictionary *result){
        self.loginLabel.text = @"已登陆";
    }];
}

- (IBAction)photoAction:(id)sender {
    NSDictionary *params = @{@"Version":@"3.3.0",@"Channel":@"ios||iPhone OS##6.0.1||appstore||appstore_3.3.0"};
    [WXHLDataService getPhotoList:params competeBlock:^(NSDictionary *result){
        NSLog(@"%@",result);
    }];
}

- (IBAction)clearAction:(id)sender {
    
}

- (IBAction)addActon:(id)sender {
    [WXHLDataService setCookies];
}

@end
