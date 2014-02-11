//
//  EditorViewController.m
//  UserDemo
//
//  Created by wei.chen on 13-2-27.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "EditorViewController.h"
#import "UserModel.h"
#import "UserDB.h"

@interface EditorViewController ()

@end

@implementation EditorViewController

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

- (void)dealloc {
    [_nameField release];
    [_passField release];
    [_ageField release];
    [super dealloc];
}

- (IBAction)submitAction:(id)sender {
    NSString *username = self.nameField.text;
    NSString *password = self.passField.text;
    NSString *age = self.ageField.text;
    
    UserModel *user = [[UserModel alloc] init];
    user.username = username;
    user.password = password;
    user.age = age;
    
    [[UserDB shareInstance] addUser:user];
    
    [user release];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
