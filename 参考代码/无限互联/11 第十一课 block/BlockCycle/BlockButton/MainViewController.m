//
//  MainViewController.m
//  BlockButton
//
//  Created by wei.chen on 13-1-4.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MainViewController.h"
#import "BlockButton.h"
#import "DetailViewController.h"

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

    BlockButton *button = [[BlockButton alloc] initWithFrame:CGRectMake(20, 40, 100, 20)];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"按钮" forState:UIControlStateNormal];
    button.block = ^(BlockButton *btn){
        DetailViewController *detail = [[DetailViewController alloc] init];
        [self presentViewController:detail animated:YES completion:^{
            NSLog(@"模态视图已经弹出");
        }];
        [detail release];

//        [UIView animateWithDuration:0.5 animations:^{
//            btn.frame = CGRectMake(20, 200, 100, 20);
//        }];
        
//        [UIView animateWithDuration:0.5 animations:^{
//            btn.frame = CGRectMake(20, 200, 100, 20);
//        } completion:^(BOOL finish){
//            //动画结束以后调用的block
//            NSLog(@"动画结束");
//        }];
        
    };
    [self.view addSubview:button];
    [button release];
    
    
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5];
//    
//    //....
//    [UIView setAnimationDelegate:self];
//    [UIView setAnimationDidStopSelector:@selector(<#selector#>)];
//    
//    [UIView commitAnimations];
    
    

    
    
}

@end
