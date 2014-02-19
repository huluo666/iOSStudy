//
//  MoviePlayerViewController.m
//  2014.2.18
//
//  Created by 张鹏 on 14-2-18.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "MoviePlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

#define FUNCTION_BUTTON_TAG 20

@interface MoviePlayerViewController () {
    
    MPMoviePlayerController *_moviePlayer;
}

- (void)initializeUserInterface;
- (void)buttonPressed:(UIButton *)sender;

@end

@implementation MoviePlayerViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"MoviePlayer";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeUserInterface];
}

- (void)dealloc {
    
    [_moviePlayer release];
    
    [super dealloc];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeSystem];
    playButton.bounds = CGRectMake(0, 0, 100, 30);
    playButton.center = CGPointMake(CGRectGetMidX(self.view.bounds) - 60,
                                    CGRectGetMidY(self.view.bounds) + 100);
    [playButton setTitle:@"直接播放" forState:UIControlStateNormal];
    [playButton addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    playButton.tag = FUNCTION_BUTTON_TAG;
    [self.view addSubview:playButton];
    
    UIButton *fullscreenPlayButton = [UIButton buttonWithType:UIButtonTypeSystem];
    fullscreenPlayButton.bounds = CGRectMake(0, 0, 100, 30);
    fullscreenPlayButton.center = CGPointMake(CGRectGetMidX(self.view.bounds) + 60,
                                              CGRectGetMidY(self.view.bounds) + 100);
    [fullscreenPlayButton setTitle:@"全屏播放" forState:UIControlStateNormal];
    [fullscreenPlayButton addTarget:self
                             action:@selector(buttonPressed:)
                   forControlEvents:UIControlEventTouchUpInside];
    fullscreenPlayButton.tag = FUNCTION_BUTTON_TAG + 1;
    [self.view addSubview:fullscreenPlayButton];
}

- (void)buttonPressed:(UIButton *)sender {
    
    // 避免多次点击
    if (_moviePlayer && _moviePlayer.view.superview) {
        [_moviePlayer stop];
        [_moviePlayer.view removeFromSuperview];
    }
    
    NSURL *movieURL = [[NSBundle mainBundle] URLForResource:@"宣传资料" withExtension:@"mp4"];
    
    NSInteger index = sender.tag - FUNCTION_BUTTON_TAG;
    // 直接播放
    if (index == 0) {
        // MPMoviePlayerController可以重用
        if (!_moviePlayer) {
            // 初始化播放器
            _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
            _moviePlayer.view.frame = CGRectMake(0, 64, 320, 200);
            // 配置默认控制界面风格
            _moviePlayer.controlStyle = MPMovieControlStyleDefault;
            // 配置播放内容的拉伸模式
            _moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
        }
        [_moviePlayer prepareToPlay];
        [_moviePlayer play];
        [self.view addSubview:_moviePlayer.view];
    }
    // 全屏播放
    else {
        MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
        [self presentMoviePlayerViewControllerAnimated:moviePlayer];
        [moviePlayer release];
    }
}

@end














