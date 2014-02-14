//
//  RootViewController.m
//  「UI」表视图(day08)
//
//  Created by 萧川 on 14-2-14.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import "CustomCell.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) NSMutableArray *dataSource;

- (void)initDataSource;
- (void)initUserInterface;

- (void)barButtonPressed:(UIBarButtonItem *)barItem;

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDataSource];
	[self initUserInterface];
}

- (void)dealloc
{
    [_tableView release];
    [_dataSource release];
    [super dealloc];
}

- (void)initDataSource
{
    NSMutableArray *fonts = [[UIFont familyNames] mutableCopy];
    [fonts sortUsingSelector:@selector(caseInsensitiveCompare:)];
    _dataSource = [fonts retain];
}

- (void)initUserInterface
{
    self.title = @"Font List";
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    tableView.rowHeight = TABLE_VIEW_ROW_HEIGHT;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    _tableView = [tableView retain];
    [tableView release];
    
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
                                             style:UIBarButtonItemStylePlain
                                            target:self
                                            action:@selector(barButtonPressed:)];
    edit.tag = EDIT_BAR_TAG;

    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                         target:self
                                                         action:@selector(barButtonPressed:)];

    add.tag = ADD_BAR_TAG;
    self.navigationItem.leftBarButtonItem = edit;
    [edit release];
    self.navigationItem.rightBarButtonItem = add;
    [add release];
}

- (void)barButtonPressed:(UIBarButtonItem *)barItem
{
    if (barItem.tag == EDIT_BAR_TAG) {
        if ([barItem.title isEqualToString:@"Done"]) {
            [_tableView setEditing:NO animated:YES];
        } else {
            [_tableView setEditing:YES animated:YES];
        }

        barItem.title = _tableView.editing ? @"Done" : @"Edit";
    }
    
    if (barItem.tag == ADD_BAR_TAG) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Add Font" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *textField = [alertView textFieldAtIndex:0];
        textField.placeholder = @"Please add new font";
        [alertView show];
    }
}

#pragma mark - 数据源 UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdenitfier = nil;
    NSString *fontName = _dataSource[indexPath.row];
    if ([fontName hasSuffix:@"-New"]) {
        cellIdenitfier = @"NewFontCellIdenitfier";
    } else {
        cellIdenitfier = @"CellIdenitfier";
    }
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenitfier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellIdenitfier] autorelease];
        
        if ([cellIdenitfier isEqualToString:@"NewFontCellIdenitfier"]) {
            cell = [[[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:cellIdenitfier] autorelease];
            
            cell.textLabel.text = [fontName stringByReplacingOccurrencesOfString:@"-New" withString:@""];
            
        } else {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:cellIdenitfier] autorelease];
            cell.textLabel.text = fontName;
        }
    }
    
    cell.imageView.image = [UIImage imageNamed:@"logo"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

// 指定的单元行是否支持编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES; // default is YES
}

// 指定单元行编辑类型
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

// 点击操作数据后调用该方法
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 数据删除
        [_dataSource removeObjectAtIndex:indexPath.row];
        // 界面删除
        [_tableView deleteRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

// 是否可以移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 用户排序完成会进行调用，进行数据层排序
- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [_dataSource exchangeObjectAtIndex:sourceIndexPath.row
                     withObjectAtIndex:destinationIndexPath.row];
}

#pragma mark - 委托方法 UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *detailVC = [[DetailViewController alloc]
                                      initWithTitle:_dataSource[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

// 单元行将要显示
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.transform = CGAffineTransformMakeTranslation(-100, -30);
    [UIView animateWithDuration:0.2f animations:^{
        cell.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - <UIAlertViewDelegate>

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [alertView firstOtherButtonIndex]) {
        NSString *fontName = [alertView textFieldAtIndex:0].text;
        NSString *objName = [fontName stringByAppendingString:@"-New"];
        
        if (fontName.length > 0 && ![_dataSource containsObject:objName]) {
            [_dataSource addObject:objName];
            [_dataSource sortUsingSelector:@selector(caseInsensitiveCompare:)];
            NSInteger index = [_dataSource indexOfObject:objName];
            [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}


@end
