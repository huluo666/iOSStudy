//
//  VideoViewController.m
//  「UI」多媒体(day10)
//
//  Created by 萧川 on 14-2-18.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "VideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface VideoViewController ()

@property (retain, nonatomic) MPMoviePlayerController *moviePlayer;


- (void)initDataSource;
- (void)initUserInterface;

- (void)buttonPressed:(UIButton *)sender;

@end

@implementation VideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"视频播放器";
    }
    return self;
}

- (void)dealloc
{
    [_moviePlayer release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDataSource];
    [self initUserInterface];
}

- (void)initDataSource
{

}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *directPlay = [UIButton buttonWithType:UIButtonTypeSystem];
    directPlay.bounds = CGRectMake(0, 0, 60, 30);
    directPlay.center = CGPointMake(CGRectGetMidX(self.view.frame) - 80, 450);
    directPlay.tag = 100;
    [directPlay setTitle:@"直接播放" forState:UIControlStateNormal];
    [directPlay addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:directPlay];
    
    UIButton *fullScreenPlay = [UIButton buttonWithType:UIButtonTypeSystem];
    fullScreenPlay.bounds = CGRectMake(0, 0, 60, 30);
    fullScreenPlay.center = CGPointMake(CGRectGetMidX(self.view.frame) + 80, 450);
    fullScreenPlay.tag = 101;
    [fullScreenPlay setTitle:@"全屏播放" forState:UIControlStateNormal];
    [fullScreenPlay addTarget:self
                       action:@selector(buttonPressed:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fullScreenPlay];
}

- (void)buttonPressed:(UIButton *)sender
{
    // 避免多次点击
    if (_moviePlayer && _moviePlayer.view.superview) {
        [_moviePlayer stop];
        [_moviePlayer.view removeFromSuperview];
    }
    
    NSURL *movieURL = [[NSBundle mainBundle] URLForResource:@"宣传资料" withExtension:@"mp4"];
    NSInteger index = sender.tag - 100;
    
    if (!index) {
        if (!_moviePlayer) { // MPMoviePlayerController可重用
            _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
            _moviePlayer.view.frame = CGRectMake(0, 64, 320, 200);
            _moviePlayer.controlStyle = MPMovieControlStyleDefault; // 控制界面风格
            _moviePlayer.scalingMode = MPMovieScalingModeAspectFit; // 内容拉伸模式
        }
        
        [_moviePlayer prepareToPlay];
        [_moviePlayer play];
        [self.view addSubview:_moviePlayer.view];
        
    } else { // 全屏播放
        MPMoviePlayerViewController *moviePlayVC = [[MPMoviePlayerViewController alloc]
                                                    initWithContentURL:movieURL];
        [self presentMoviePlayerViewControllerAnimated:moviePlayVC];
        [moviePlayVC release];
    }
    
}


@end
