//
//  DDLoginViewController.m
//  面试职通车
//
//  Created by 萧川 on 14-4-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDLoginViewController.h"
#import "DDSignUpViewController.h"
#import "DDRetrievePasswordViewController.h"

@interface DDLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passWord;

@end

@implementation DDLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"登录";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.userName becomeFirstResponder];
}

- (IBAction)submitLogin:(UIButton *)sender {
   
    NSString *userName = self.userName.text;
    NSString *passWord = self.passWord.text;
    
    NSLog(@"%@", userName);
    NSLog(@"%@", passWord);
}

- (IBAction)signUp:(UIButton *)sender {
    
    DDSignUpViewController *signVC = [[DDSignUpViewController alloc] init];
    [self.navigationController pushViewController:signVC animated:YES];
}


- (IBAction)forgotPassWord:(UIButton *)sender {
    
    DDRetrievePasswordViewController *retrieve = [[DDRetrievePasswordViewController alloc] init];
    [self.navigationController pushViewController:retrieve animated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}

@end
