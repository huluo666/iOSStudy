//
//  AudioPlayerViewController.m
//  UITask
//
//  Created by 萧川 on 14-2-18.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "AudioPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AudioPlayer.h"

@interface AudioPlayerViewController ()

@property (retain, nonatomic) UILabel *displayLabel;
@property (retain, nonatomic) AVAudioPlayer *audioPlayer;
@property (assign, nonatomic, getter = isPlaying) BOOL playing;
@property (assign, nonatomic) UISlider *slider;
@property (retain, nonatomic) NSTimer *timer;
@property (assign, nonatomic, getter = isShouldUpdateIndicator) BOOL shouldUpdateIndicator;
@property (retain, nonatomic) UILabel *currentTimeLabel;
@property (retain, nonatomic) UILabel *leftTimeLabel;

- (void)initUserInterface; // 初始化用户界面
- (void)initPlayerWithAudioName:(NSString *)audioName shouldAutoPlay:(BOOL)autoPlay; // 初始化音频播放
- (void)updateUserInterface; // 更新界面显示数据
- (void)buttonPressed:(UIButton *)sender; // 上一首、下一首、暂停(播放)
- (void)processAudioPlayState:(UIButton *)sender; // 处理播放状态
- (void)previousAudio; // 上一首
- (void)nextAudio; // 下一首
- (NSInteger)realIndexWithIndex:(NSInteger)index; // 获取应该播放的音频的索引
- (void)startTiming;  // 开始计时器
- (void)pauseTiming; // 暂停计时
- (void)stopTiming; // 停止计时
- (void)processTimer:(NSTimer *)timer; // 处理计时器
- (void)processSliderTouchDown:(UISlider *)sender; // 按下进度条
- (void)processSliderTouchUpInside:(UISlider *)sender; // 按下并抬起进度条
- (NSString *)timeFormatedWithSecond:(NSInteger)seconds; // 以播放时长和剩余时间
- (void)adjustTimeDsiplay;

@end

@implementation AudioPlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)initWithDataSource:(NSArray *)dataSource
       currentAudioIndex:(NSInteger)currentAudioIndex
{
    if (self = [super init]) {
        self.title = @"音频播放器";
        _playing = YES;
        _shouldUpdateIndicator = YES;
        self.audioNameList = dataSource;
        self.currentAudioIndex = currentAudioIndex;
    }
    
    return self;
}

- (void)setAudioPlayer:(AVAudioPlayer *)audioPlayer
{
    if (audioPlayer != _audioPlayer) {
        if (_audioPlayer.isPlaying) {
            [_audioPlayer stop];
        }
        [_audioPlayer release];
        _audioPlayer = [audioPlayer retain];
    }
}

- (void)dealloc
{
    [_displayLabel release];
    [_audioPlayer release];
    [_audioNameList release];
    [_slider release];
    [_timer release];
    [_currentTimeLabel release];
    [_leftTimeLabel release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUserInterface];
    [self initPlayerWithAudioName:_audioNameList[_currentAudioIndex]
                   shouldAutoPlay:_playing];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_audioPlayer stop];
    
    AudioPlayer *player = [AudioPlayer sharedSingleton];
    if ([player isPlaying]) {
        [player stop];
    }
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    _displayLabel = [[UILabel alloc] init];
    _displayLabel.bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 150);
    _displayLabel.center = CGPointMake(CGRectGetMidX(self.view.frame), 170);
    _displayLabel.textAlignment = NSTextAlignmentCenter;
    _displayLabel.numberOfLines = 0;
    _displayLabel.textColor = [UIColor grayColor];
    _displayLabel.font = [UIFont systemFontOfSize:22.0f];
    [self.view addSubview:_displayLabel];
    [_displayLabel release];
    
    UIButton *state = [UIButton buttonWithType:UIButtonTypeCustom];
    state.bounds = CGRectMake(0, 0, 30, 30);
    state.center = CGPointMake(CGRectGetMidX(self.view.frame),
                               CGRectGetMaxY(_displayLabel.frame) + 120);
    state.tag = 10;
    [state setBackgroundImage:[UIImage imageNamed:@"pause"]
                     forState:UIControlStateNormal];
    [state setBackgroundImage:[UIImage imageNamed:@"play"]
                     forState:UIControlStateSelected];
    [state addTarget:self
              action:@selector(buttonPressed:)
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:state];
    
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.bounds = CGRectMake(0, 0, 30, 30);
    back.tag = 11;
    back.center = CGPointMake(CGRectGetMinX(state.frame) - 70,
                              CGRectGetMaxY(_displayLabel.frame) + 120);
    [back setBackgroundImage:[UIImage imageNamed:@"back"]
                    forState:UIControlStateNormal];
    [back addTarget:self
             action:@selector(buttonPressed:)
   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    UIButton *next = [UIButton buttonWithType:UIButtonTypeCustom];
    next.bounds = CGRectMake(0, 0, 30, 30);
    next.center = CGPointMake(CGRectGetMaxX(state.frame) + 70,
                              CGRectGetMaxY(_displayLabel.frame) + 120);
    next.tag = 12;
    [next setBackgroundImage:[UIImage imageNamed:@"next"]
                    forState:UIControlStateNormal];
    [next addTarget:self
             action:@selector(buttonPressed:)
   forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:next];
    
    _slider = [[UISlider alloc] init];
    _slider.bounds = CGRectMake(0, 0, 200, 20);
    _slider.center = CGPointMake(CGRectGetMidX(self.view.frame),
                                 CGRectGetMinY(state.frame) - 80);
    _slider.value = 0;
    _slider.maximumTrackTintColor = [UIColor lightGrayColor];
    _slider.minimumTrackTintColor = [UIColor lightGrayColor];
    [_slider setThumbImage:[UIImage imageNamed:@"indicator"]
                  forState:UIControlStateNormal];
    [_slider addTarget:self
                action:@selector(processSliderTouchDown:)
      forControlEvents:UIControlEventTouchDown];
    [_slider addTarget:self
                action:@selector(processSliderTouchUpInside:)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_slider];
    
    _currentTimeLabel = [[UILabel alloc] init];
    _currentTimeLabel.bounds = CGRectMake(0, 0, 30, 30);
    _currentTimeLabel.center = CGPointMake(CGRectGetMinX(_slider.frame) - 20,
                                           CGRectGetMidY(_slider.frame));
    _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    _currentTimeLabel.font = [UIFont systemFontOfSize:12.0f];
    _currentTimeLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:_currentTimeLabel];
    
    _leftTimeLabel = [[UILabel alloc] init];
    _leftTimeLabel.bounds = CGRectMake(0, 0, 30, 30);
    _leftTimeLabel.center = CGPointMake(CGRectGetMaxX(_slider.frame) + 20,
                                        CGRectGetMidY(_slider.frame));
    _leftTimeLabel.textAlignment = NSTextAlignmentCenter;
    _leftTimeLabel.font = [UIFont systemFontOfSize:12.0f];
    _leftTimeLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:_leftTimeLabel];
}

- (void)initPlayerWithAudioName:(NSString *)audioName shouldAutoPlay:(BOOL)autoPlay
{
    NSURL *audioURL = [[NSBundle mainBundle] URLForResource:audioName
                                              withExtension:@"mp3"];
    if (!audioURL) {
        return;
    }
    
    NSError *error = nil;

    self.audioPlayer = [[AVAudioPlayer alloc]
                        initWithContentsOfURL:audioURL
                        error:&error];

    _audioPlayer.numberOfLoops = -1;
    [_audioPlayer prepareToPlay];
    if (autoPlay) {
        [_audioPlayer play];
    }
    _currentAudioIndex = [_audioNameList indexOfObject:audioName];
    [self startTiming];
    [self updateUserInterface];
}

- (void)updateUserInterface
{
    // 更新标题显示
    _displayLabel.text = _audioNameList[_currentAudioIndex];
    
    // 更新进度显示
    _slider.value = 0;
    _slider.minimumValue = 0;
    _slider.maximumValue = _audioPlayer.duration;
    [self adjustTimeDsiplay];
}

- (void)buttonPressed:(UIButton *)sender
{
    NSInteger index = sender.tag - 10;
    switch (index) {
        case 0:
            [self processAudioPlayState:sender];
            break;
        case 1:
            [self previousAudio];
            break;
        case 2:
            [self nextAudio];
            break;
        default:
            break;
    }
}

- (void)processAudioPlayState:(UIButton *)sender
{
    sender.selected = _playing;
    
    _playing = !_playing;
    if (_playing) {
        [_audioPlayer play];
        [self startTiming];
    } else {
        [_audioPlayer pause];
        [self pauseTiming];
    }
}

- (NSInteger)realIndexWithIndex:(NSInteger)index
{
    NSInteger maxIndex = [_audioNameList count] - 1;
    if (index > maxIndex) {
        index = 0;
    } else if (index < 0 ) {
        index = maxIndex;
    }
    return index;
}

- (void)nextAudio
{
    NSInteger index = [self realIndexWithIndex:_currentAudioIndex + 1];
    [self initPlayerWithAudioName:_audioNameList[index]
                   shouldAutoPlay:_playing];
}

- (void)previousAudio
{
    NSInteger index = [self realIndexWithIndex:_currentAudioIndex - 1];
    [self initPlayerWithAudioName:_audioNameList[index]
                   shouldAutoPlay:_playing];
}

#pragma mark - process timer messages

- (void)startTiming
{
    if (!_timer) {
        _timer = [[NSTimer scheduledTimerWithTimeInterval:1.0f
                                                   target:self
                                                 selector:@selector(processTimer:)
                                                 userInfo:nil
                                                  repeats:YES] retain];
    }
    
    // 配置启动事件
    [_timer setFireDate:[NSDate date]];
}

- (void)pauseTiming
{
    [_timer setFireDate:[NSDate distantFuture]];
}


- (void)stopTiming
{
    if (_timer && [_timer isValid]) {
        [_timer invalidate];
    }
}

- (void)processTimer:(NSTimer *)timer
{
    if (_playing && _audioPlayer && _shouldUpdateIndicator) {
        _slider.value = _audioPlayer.currentTime;
        
        [self adjustTimeDsiplay];
        
        NSInteger leftTime = _audioPlayer.duration - _slider.value;
        // 自动播放下一首
        if (!leftTime) {
            [self nextAudio];
        }
    }
}

- (void)processSliderTouchDown:(UISlider *)sender
{
    _shouldUpdateIndicator = NO;
}

- (void)processSliderTouchUpInside:(UISlider *)sender
{
    _shouldUpdateIndicator = YES;
    _audioPlayer.currentTime = sender.value;
    
    [self adjustTimeDsiplay];
}

- (NSString *)timeFormatedWithSecond:(NSInteger)seconds
{
    NSInteger hours = seconds / 3600;
    NSInteger minutes = seconds / 60;
    NSInteger leftSeconds = seconds % 60;
    NSString *timeFormated = [NSString stringWithFormat:@"%ld:%ld",
                              minutes, leftSeconds];
    if (hours) {
        timeFormated = [NSString stringWithFormat:@"%ld:%ld:%ld",
                        hours, minutes, leftSeconds];
    }
    return timeFormated;
}

- (void)adjustTimeDsiplay
{
    NSInteger leftTime = _audioPlayer.duration - _slider.value;
    _currentTimeLabel.text = [self timeFormatedWithSecond:_slider.value];
    _leftTimeLabel.text = [NSString stringWithFormat:@"-%@",
                           [self timeFormatedWithSecond:leftTime]];
}

@end
