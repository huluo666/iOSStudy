//
//  DDListEditViewController.m
//  「Demo」StoryBoard
//
//  Created by 萧川 on 14-4-17.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDListEditViewController.h"

@interface DDListEditViewController ()

@property (copy, nonatomic) NSDictionary *selection;
@property (weak, nonatomic) id preViewController;

@end

@implementation DDListEditViewController

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
    _editText.text = [_selection objectForKey:@"object"];
    [_editText becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    if ([_preViewController respondsToSelector:@selector(setEditedSelection:)]) {
        //结束编辑
        [_editText endEditing:YES];
        NSIndexPath *indexPath = [_selection objectForKey:@"indexPath"];
        id object = _editText.text;
        NSDictionary *editedSelection = [NSDictionary dictionaryWithObjectsAndKeys:
                                         indexPath, @"indexPath",
                                         object, @"object",
                                         nil];
        //设置上一个ViewController中的editedSelection，由于设置editedSelection方法
        //已经重写，从而对应在表格中的数据会发生变化
        [_preViewController setValue:editedSelection forKey:@"editedSelection"];
    }
}

@end
