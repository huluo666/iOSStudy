//
//  MainViewController.m
//  UserDemo
//
//  Created by wei.chen on 13-2-27.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MainViewController.h"
#import "UserModel.h"
#import "UserDB.h"
#import "EditorViewController.h"

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
    
    [[UserDB shareInstance] createTable];
    self.title = @"用户列表";
    

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    self.navigationItem.rightBarButtonItem = add;
}

- (void)loadData {
    //查询数据
    self.data = [[UserDB shareInstance] findUsers];
    [self.tableView reloadData];
}

- (void)addAction {
    EditorViewController *editor = [[EditorViewController alloc] init];
    [self.navigationController pushViewController:editor animated:YES];
    [editor release];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    
    UserModel *user = [self.data objectAtIndex:indexPath.row];
    cell.textLabel.text = user.username;
    cell.detailTextLabel.text = user.age;
    
    return cell;
}


@end
