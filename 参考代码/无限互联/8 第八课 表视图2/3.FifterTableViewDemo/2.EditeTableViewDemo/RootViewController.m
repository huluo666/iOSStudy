//
//  RootViewController.m
//  2.EditeTableViewDemo
//
//  Created by 周泉 on 13-2-27.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G开发培训中心. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _fontsArray = [[NSMutableArray arrayWithArray:[UIFont familyNames]] retain];
    
    _data = [[UIFont familyNames] retain];
    
    UITextField *_textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 250, 30)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.delegate = self;
//    _textField.clearsOnBeginEditing = YES;
    _textField.returnKeyType = UIReturnKeyDone;
    [_textField addTarget:self action:@selector(filter:) forControlEvents:UIControlEventEditingChanged];
    self.navigationItem.titleView = _textField;
    [_textField release];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_fontsArray release];
    _fontsArray = nil;
    [_data release];
    _data = nil;
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_fontsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 320, 44)];
        label.tag = 101;
        [cell.contentView addSubview:label];
    }
    
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:101];
    label.text = _fontsArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)filter:(UITextField *)textField
{
    if ([textField.text length] == 0) {
        self.fontsArray = _data;
        [self.tableView reloadData];// insert delete
        return;
    }
    NSString *regex = [NSString stringWithFormat:@"SELF LIKE[c]'%@*'", textField.text];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:regex];
    self.fontsArray = [_data filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
}

@end
