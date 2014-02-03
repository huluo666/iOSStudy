//
//  ContactsViewController.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-1.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactSubViewController.h"
#import "ContactsDataSource.h"

@interface ContactsViewController ()

@property (retain, nonatomic) ContactsDataSource *dataSource;

@end

@implementation ContactsViewController

- (void)dealloc
{
    [_dataSource release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        _dataSource = [[ContactsDataSource alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    /*
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    pushButton.bounds = CGRectMake(0, 0, 320, 40);
    pushButton.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMinY(self.view.frame) + 20 + 44 + 35 + 20 + 5);
    [pushButton setTitle:@"PUSH" forState:UIControlStateNormal];
    pushButton.layer.borderWidth = 1.0f;
    pushButton.layer.borderColor = [UIColor colorWithWhite:0.721 alpha:1.000].CGColor;
    [pushButton addTarget:self action:@selector(pushVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
    */
    
    [self initTableView];
    
}

- (void)initTableView
{
    CGRect frame;
    frame.origin = CGPointMake(0, 35);
    frame.size = self.view.frame.size;
    UITableView *contactsTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    contactsTableView.dataSource = self.dataSource; //关联数据源
    [self.view addSubview:contactsTableView];
    [contactsTableView release];
    
}

- (void)pushVC:(UIButton *)sender
{
    ContactSubViewController *contactsSubVC = [[ContactSubViewController alloc] init];
    [self.navigationController pushViewController:contactsSubVC animated:YES];
    [contactsSubVC release];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
