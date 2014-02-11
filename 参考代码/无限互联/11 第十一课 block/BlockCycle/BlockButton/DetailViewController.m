//
//  DetailViewController.m
//  BlockButton
//
//  Created by wei.chen on 13-1-4.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "DetailViewController.h"
#import "BlockButton.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

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
    self.view.backgroundColor = [UIColor grayColor];
    
    BlockButton *button = [[BlockButton alloc] initWithFrame:CGRectMake(20, 40, 100, 20)];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    
    //使用block修饰的局部变量，block不会将此变量retain
    __block UIViewController *viewcontroler = self;
    NSLog(@"%d",self.retainCount);
    button.block = ^(BlockButton *btn){
        //block将当前对象self， retain了一下
        [viewcontroler dismissModalViewControllerAnimated:YES];
        
        
        //如果使用self的属性或者方法，block会将self retain一下, 正是这个retain导致了循环引用
//        [self dismissModalViewControllerAnimated:YES];
        NSLog(@"%d",viewcontroler.retainCount);
    };

    [self.view addSubview:button];
    [button release];
    
}

- (void)clickActon {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc {
    NSLog(@"DetailViewController 销毁了");
    [super dealloc];
}

@end
