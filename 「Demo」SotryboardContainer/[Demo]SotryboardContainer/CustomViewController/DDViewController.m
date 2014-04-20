//
//  DDViewController.m
//  [Demo]SotryboardContainer
//
//  Created by 萧川 on 14-4-20.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDViewController.h"

@interface DDViewController ()

@end

@implementation DDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    self.view.backgroundColor = kRandomColor;
}

@end
