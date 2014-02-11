//
//  MainViewController.m
//  AVAudioPlayerDemo
//
//  Created by wei.chen on 13-1-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MainViewController.h"

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

    //播放远程地址
//    NSString *mp3Url = @"http://zhangmenshiting.baidu.com/data2/music/32197650/23473715212400128.mp3?xcode=048460eee5f7d0205f13a00e1cf710fe";
//    NSURL *url = [NSURL URLWithString:mp3Url];
//    
//    AVPlayer *player = [[AVPlayer alloc] initWithURL:url];
//    [player play];
//
    
    
    //播放本地文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"第一夫人" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    AVPlayer *player = [[AVPlayer alloc] initWithURL:url];
    [player play];
}

- (void)timerAction:(NSTimer *)timer {
    
    if (audioPlayer.playing) {
        NSString *currentTime = [NSString stringWithFormat:@"%.0f",audioPlayer.currentTime];
        _timeLabel.text = currentTime;
        
        _currentSlider.value = audioPlayer.currentTime;        
    }
    
}

- (void)dealloc {
    [_volumeSlider release];
    [_timeLabel release];
    [_currentSlider release];
    [super dealloc];
}
- (IBAction)volumeAction:(UISlider *)sender {
    //设置播放器的音量
    audioPlayer.volume = sender.value;
}

- (IBAction)currentAction:(UISlider *)sender {
    //设置当前的播放进度时间
    audioPlayer.currentTime = sender.value;
}

- (IBAction)playAction:(UIButton *)sender {
    //播放器是否正在播放
    BOOL playing = audioPlayer.playing;
    if (playing) { //正在播放
        [audioPlayer pause];
        [sender setTitle:@"播放" forState:UIControlStateNormal];
    } else {
        [audioPlayer play];
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
    }
}

#pragma mark - AVAudioPlayer delegate
//播放结束调用
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"播放结束");
    
    
}

@end
