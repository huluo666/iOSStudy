//
//  ViewController.m
//  「UI」HelloWorld(task)
//
//  Created by cuan on 14-1-21.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_label release];
    [_textField release];
    [super dealloc];
}

- (IBAction)buttonPressed:(UIButton *)sender {
    
    [_textField resignFirstResponder];
    
    NSString *text = _textField.text;
    if (!text || text.length == 0)
    {
        return;
    }
    _label.text = text;
}
@end
