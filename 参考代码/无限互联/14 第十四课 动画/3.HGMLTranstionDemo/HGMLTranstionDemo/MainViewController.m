//
//  MainViewController.m
//  HGMLTranstionDemo
//
//  Created by wei.chen on 13-1-8.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MainViewController.h"
#import "Switch3DTransition.h"
#import "HMGLTransitionManager.h"
#import "DoorsTransition.h"
#import "ModalViewController.h"

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_myView release];
    [super dealloc];
}
- (IBAction)transtionAction:(id)sender {
    //创建动画类型对象
//    Switch3DTransition *animation = [[Switch3DTransition alloc] init];
    DoorsTransition *animation = [[DoorsTransition alloc] init];
    
    //设置动画类型对象
    [[HMGLTransitionManager sharedTransitionManager] setTransition:animation];
    
    //设置动画需要添加的视图
    [[HMGLTransitionManager sharedTransitionManager] beginTransition:self.myView];
    
    
    [[HMGLTransitionManager sharedTransitionManager] commitTransition];
    
    //切换视图
    [self.myView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
}

- (IBAction)modalAction:(id)sender {
    
    DoorsTransition *animation = [[DoorsTransition alloc] init];
    
    [[HMGLTransitionManager sharedTransitionManager] setTransition:animation];
    
    ModalViewController *viewCtrl = [[ModalViewController alloc] init];
    
    
    [[HMGLTransitionManager sharedTransitionManager] presentModalViewController:viewCtrl onViewController:self];
    
    
    
}
@end
