//
//  ViewController.m
//  2014.2.14
//
//  Created by 张鹏 on 14-2-14.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "NewFontCell.h"
#import "DefaultCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate> {
    
    UITableView *_tableView;
    NSMutableArray *_dataSource;
}

- (void)initializeDataSource;
- (void)initializeUserInterface;

- (void)barButtonPressed:(UIBarButtonItem *)sender;

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"Font List";
        
    }
    return self;
}

- (void)dealloc {
    
    [_tableView  release];
    [_dataSource release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)initializeDataSource {
    
    _dataSource = [[NSMutableArray arrayWithArray:[UIFont familyNames]] retain];
    [_dataSource sortUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                              style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    // 编辑状态切换
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc]
                                 initWithTitle:@"Edit"
                                 style:UIBarButtonItemStylePlain
                                 target:self
                                 action:@selector(barButtonPressed:)];
    editItem.tag = 10;
    self.navigationItem.leftBarButtonItem = editItem;
    [editItem release];
    
    // 添加新字体
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self
                                action:@selector(barButtonPressed:)];
    addItem.tag = 11;
    self.navigationItem.rightBarButtonItem = addItem;
    [addItem release];
}

- (void)barButtonPressed:(UIBarButtonItem *)sender {
    
    NSInteger index = sender.tag - 10;
    // 表视图编辑
    if (index == 0) {
        [_tableView setEditing:!_tableView.editing animated:YES];
        sender.title = _tableView.editing ? @"Done" : @"Edit";
    }
    // 新字体插入
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"添加新字体"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        // 设置警告框类型
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        // 设置文本输入框占位符
        UITextField *textField = [alert textFieldAtIndex:0];
        textField.placeholder = @"请输入字体名称...";
        [alert show];
        [alert release];
    }
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 首先取出字体并判断其类型
    NSString *font = _dataSource[indexPath.row];
    // 根据当前字体判断所需的单元行标识
    NSString *cellIdentifier = nil;
    // 新字体
    if ([font hasSuffix:@"-New"]) {
        cellIdentifier = @"NewFontCell";
    }
    // 原有字体
    else {
        cellIdentifier = @"Cell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    // if语句内实现界面的自定义
    if (!cell) {
        
        // 新字体cell
        if ([cellIdentifier isEqualToString:@"NewFontCell"]) {
            //1. 提高了代码的重用性
            //2. 降低了代码之间的耦合性
            cell = [[[NewFontCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:cellIdentifier] autorelease];
        }
        // 原始字体
        else {
            cell = [[[DefaultCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:cellIdentifier] autorelease];
        }
    }
    
    // if语句外实现数据的替换
    cell.textLabel.text = font;
    cell.imageView.image = [UIImage imageNamed:@"logo.png"];
    
    return cell;
}

// 配置指定单元行是否支持编辑，默认所有都可以编辑，return YES
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

// 配置指定单元行编辑类型
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

// 执行对应的数据层及界面层的编辑操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 表视图数据删除：首先删除数据层，再删除界面层
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 数据删除
        [_dataSource removeObjectAtIndex:indexPath.row];
        // 界面删除
//        [tableView reloadData];
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

// 配置指定单元行是否支持排序，默认不支持
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

// 用户排序完成会进行调用，此方法中进行数据层排序
- (void)tableView:(UITableView *)tableView
        moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
        toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    // 对数据集合排序
    [_dataSource exchangeObjectAtIndex:sourceIndexPath.row
                     withObjectAtIndex:destinationIndexPath.row];
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailViewController *detailVC = [[DetailViewController alloc] initWithFontName:_dataSource[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
    [detailVC release];
}

// 单元行将要显示
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.transform = CGAffineTransformMakeTranslation(-100, -30);
    
    [UIView animateWithDuration:0.2 animations:^{
        cell.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - <UIAlertViewDelegate>

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // 点击确定按钮插入数据
    if (buttonIndex == [alertView firstOtherButtonIndex]) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        NSString *font = textField.text;
        // 判断输入正确性和是否已存在该字体名称
        if (font.length > 0 && ![_dataSource containsObject:font]) {
            // 将字体添加到正确的索引位置
            font = [font stringByAppendingString:@"-New"];
            [_dataSource addObject:font];
            [_dataSource sortUsingSelector:@selector(caseInsensitiveCompare:)];
            NSInteger index = [_dataSource indexOfObject:font];
            [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}

@end
























