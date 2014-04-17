//
//  DDRetrievePasswordViewController.m
//  面试职通车
//
//  Created by 萧川 on 14-4-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDRetrievePasswordViewController.h"

@interface DDRetrievePasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *account;

@end

@implementation DDRetrievePasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"找回密码";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.account becomeFirstResponder];
}

- (IBAction)retrievePassword:(UIButton *)sender {
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

@end
