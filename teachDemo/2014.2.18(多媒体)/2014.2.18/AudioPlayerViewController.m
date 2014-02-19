//
//  AudioPlayerViewController.m
//  2014.2.18
//
//  Created by 张鹏 on 14-2-18.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "AudioPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>

#define FUNCTION_BUTTON_TAG 10

@interface AudioPlayerViewController () {
    
    UILabel *_titleDisplay;
    UISlider *_progressIndicator;
    
    AVAudioPlayer *_audioPlayer;
    NSMutableArray *_musicNameList;
    NSInteger _currentMusicIndex;
    
    BOOL _playing; // 跟踪播放器播放状态
    
    NSTimer *_timer;
    BOOL _shouldUpdateProgressIndicator; // 跟踪当前是否需要更新进度指示
}

@property (retain, nonatomic) AVAudioPlayer *audioPlayer;

- (void)initializeDataSource;
- (void)initializeUserInterface;
// 初始化播放器
- (void)initializeAudioPlayerWithMusicName:(NSString *)musicName
                            shouldAutoPlay:(BOOL)autoPlay;
// 切换音乐时刷新界面
- (void)updateUserInterface;

- (void)buttonPressed:(UIButton *)sender;
// 处理播放状态，播放/暂停
- (void)processMusicPlayState:(UIButton *)sender;
// 上一首
- (void)previousMusic;
// 下一首
- (void)nextMusic;
// 计算真实索引
- (NSInteger)realIndexWithIndex:(NSInteger)index;

// 开始计时
- (void)startTimer;
// 暂停计时
- (void)pauseTimer;
// 停止计时
- (void)stopTimer;
- (void)processTimer:(NSTimer *)timer;

- (void)processSliderTouchDown:(UISlider *)sender;
- (void)processSliderTouchUpInside:(UISlider *)sender;

@end

@implementation AudioPlayerViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"AudioPlayer";
        _currentMusicIndex = 0;
        _playing = NO;
        _shouldUpdateProgressIndicator = YES;
        
    }
    return self;
}

- (void)dealloc {
    
    [_titleDisplay      release];
    [_progressIndicator release];
    [_audioPlayer       release];
    [_musicNameList     release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeDataSource];
    [self initializeUserInterface];
}

- (void)setAudioPlayer:(AVAudioPlayer *)audioPlayer {
    
    if (_audioPlayer != audioPlayer) {
        // 判断当前是否处于播放状态
        if (_audioPlayer.playing) {
            [_audioPlayer stop];
        }
        [_audioPlayer release];
        _audioPlayer = [audioPlayer retain];
    }
}

- (void)initializeDataSource {
    
    _musicNameList = [[NSMutableArray alloc] initWithObjects:@"Deemo Title Song - Website Version", @"Release My Soul", @"Rё.L", @"Wings of piano", nil];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect bounds = self.view.bounds;
    
    _titleDisplay = [[UILabel alloc] init];
    _titleDisplay.bounds = CGRectMake(0, 0, CGRectGetWidth(bounds), 100);
    _titleDisplay.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMinY(bounds) + 100 + CGRectGetMidY(_titleDisplay.bounds));
    _titleDisplay.textAlignment = NSTextAlignmentCenter;
    _titleDisplay.font = [UIFont systemFontOfSize:25];
    _titleDisplay.backgroundColor = [UIColor clearColor];
    _titleDisplay.numberOfLines = 0;
    _titleDisplay.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:_titleDisplay];
    
    // 初始化进度指示器
    _progressIndicator = [[UISlider alloc] init];
    _progressIndicator.bounds = CGRectMake(0, 0, 200, 30);
    _progressIndicator.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    _progressIndicator.value = 0;
    _progressIndicator.maximumValue = 0;
    _progressIndicator.minimumValue = 0;
    _progressIndicator.maximumTrackTintColor = [UIColor lightGrayColor];
    _progressIndicator.minimumTrackTintColor = [UIColor lightGrayColor];
    [_progressIndicator setThumbImage:[UIImage imageNamed:@"indicator.png"]
                             forState:UIControlStateNormal];
    
    [_progressIndicator addTarget:self
                           action:@selector(processSliderTouchDown:)
                 forControlEvents:UIControlEventTouchDown];
    [_progressIndicator addTarget:self
                           action:@selector(processSliderTouchUpInside:)
                 forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_progressIndicator];
    
    // 播放/暂停
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playButton.bounds = CGRectMake(0, 0, 40, 40);
    playButton.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMaxY(bounds) - 200);
    [playButton setBackgroundImage:[UIImage imageNamed:@"play.png"]
                          forState:UIControlStateNormal];
    [playButton setBackgroundImage:[UIImage imageNamed:@"pause.png"]
                          forState:UIControlStateSelected];
    [playButton addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    playButton.tag = FUNCTION_BUTTON_TAG;
    [self.view addSubview:playButton];
    
    // 上一首
    UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    previousButton.bounds = CGRectMake(0, 0, 40, 40);
    previousButton.center = CGPointMake(CGRectGetMidX(bounds) - 70 - CGRectGetMidX(previousButton.bounds), CGRectGetMaxY(bounds) - 200);
    [previousButton setBackgroundImage:[UIImage imageNamed:@"back.png"]
                              forState:UIControlStateNormal];
    [previousButton addTarget:self
                       action:@selector(buttonPressed:)
             forControlEvents:UIControlEventTouchUpInside];
    previousButton.tag = FUNCTION_BUTTON_TAG + 1;
    [self.view addSubview:previousButton];
    
    // 下一首
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.bounds = CGRectMake(0, 0, 40, 40);
    nextButton.center = CGPointMake(CGRectGetMidX(bounds) + 70 + CGRectGetMidX(nextButton.bounds), CGRectGetMaxY(bounds) - 200);
    [nextButton setBackgroundImage:[UIImage imageNamed:@"next.png"]
                          forState:UIControlStateNormal];
    [nextButton addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    nextButton.tag = FUNCTION_BUTTON_TAG + 2;
    [self.view addSubview:nextButton];
    
    
    [self initializeAudioPlayerWithMusicName:_musicNameList[_currentMusicIndex] shouldAutoPlay:_playing];
}

- (void)initializeAudioPlayerWithMusicName:(NSString *)musicName
                            shouldAutoPlay:(BOOL)autoPlay {
    
    // 初始化音频资源地址
    NSURL *musicURL = [[NSBundle mainBundle] URLForResource:musicName withExtension:@"mp3"];
    if (!musicURL) {
        return;
    }
    // 系统错误处理对象
    NSError *error = nil;
    // 初始化播放器
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:&error];
    // 断言：在条件为假的时候抛出异常，在控制台打印自定义错误信息
    NSAssert(!error, @"Initialize audio player failed with error message '%@'.", [error localizedDescription]);
    // 配置音乐循环次数，当为负数时无限循环
    _audioPlayer.numberOfLoops = -1;
    // 准备播放
    [_audioPlayer prepareToPlay];
    if (autoPlay) {
        [_audioPlayer play];
    }
    
    // 更新界面显示
    [self updateUserInterface];
}

- (void)updateUserInterface {
    
    // 更新标题显示
    _titleDisplay.text = _musicNameList[_currentMusicIndex];
    // 更新进度指示器
    _progressIndicator.value = 0;
    // duration：音乐总时长，NSTimeInterval = double
    _progressIndicator.maximumValue = _audioPlayer.duration;
    _progressIndicator.minimumValue = 0;
}

- (void)buttonPressed:(UIButton *)sender {
    
    NSInteger index = sender.tag - FUNCTION_BUTTON_TAG;
    switch (index) {
            // 播放暂停
        case 0: [self processMusicPlayState:sender]; break;
            // 上一首
        case 1: [self previousMusic]; break;
            // 下一首
        case 2: [self nextMusic]; break;
        default: break;
    }
}

- (void)processMusicPlayState:(UIButton *)sender {
    
    _playing = !_playing;
    if (_playing) {
        // 播放
        [_audioPlayer play];
        [self startTimer];
    }
    else {
        // 暂停
        [_audioPlayer pause];
        [self pauseTimer];
    }
    // 更新按钮显示
    sender.selected = _playing;
}

- (void)previousMusic {
    
    _currentMusicIndex = [self realIndexWithIndex:--_currentMusicIndex];
    [self initializeAudioPlayerWithMusicName:_musicNameList[_currentMusicIndex]
                              shouldAutoPlay:_playing];
}

- (void)nextMusic {
    
    _currentMusicIndex = [self realIndexWithIndex:++_currentMusicIndex];
    [self initializeAudioPlayerWithMusicName:_musicNameList[_currentMusicIndex]
                              shouldAutoPlay:_playing];
}

- (NSInteger)realIndexWithIndex:(NSInteger)index {
    
    NSInteger maximumIndex = [_musicNameList count] - 1;
    // 超出最大索引
    if (index > maximumIndex) {
        index = 0;
    }
    // 小于最小索引
    else if (index < 0) {
        index = maximumIndex;
    }
    return index;
}

#pragma mark - Process timer methods

- (void)startTimer {
    
    if (!_timer) {
        _timer = [[NSTimer scheduledTimerWithTimeInterval:1.0
                                                   target:self
                                                 selector:@selector(processTimer:)
                                                 userInfo:nil
                                                  repeats:YES] retain];
    }
    // 配置计时器启动时间
    [_timer setFireDate:[NSDate date]];
}

- (void)pauseTimer {
    
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)stopTimer {
    
    // 判断当前timer是否激活，若激活则停止
    if (_timer && [_timer isValid]) {
        [_timer invalidate];
    }
}

- (void)processTimer:(NSTimer *)timer {
    
    if (_shouldUpdateProgressIndicator && _playing && _audioPlayer) {
        // currentTime:播放器当前播放时间
        _progressIndicator.value = _audioPlayer.currentTime;
    }
}

- (void)processSliderTouchDown:(UISlider *)sender {
    
    // 配置当前进度指示无法被刷新
    _shouldUpdateProgressIndicator = NO;
}

- (void)processSliderTouchUpInside:(UISlider *)sender {
    
    // 配置当前进度指示可以被刷新
    _shouldUpdateProgressIndicator = YES;
    // 更新播放进度
    _audioPlayer.currentTime = sender.value;
}

@end
























