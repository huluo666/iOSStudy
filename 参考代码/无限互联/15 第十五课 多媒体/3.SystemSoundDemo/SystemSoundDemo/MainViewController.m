//
//  MainViewController.m
//  SystemSoundDemo
//
//  Created by wei.chen on 13-1-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MainViewController.h"
#import <AVFoundation/AVFoundation.h>

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

- (IBAction)playAction:(id)sender {
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"44th Street Medium" ofType:@"caf"];
//    NSURL *url = [NSURL fileURLWithPath:filePath];
//    
////    SystemSoundID soundId;
//    unsigned long soundId;
    
    //为url地址注册系统声音
//    AudioServicesCreateSystemSoundID((CFURLRef)url, &soundId);
    
    //播放系统声音
//    AudioServicesPlaySystemSound(soundId);
    
    
    //播放震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
