//
//  MusicPlayerViewController.m
//  音频、视频播放
//
//  Created by 张鹏 on 14-2-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "MusicPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#define FUNCTION_BUTTON_TAG 10

static NSString * const kMinutesTimeInfoKey = @"Minutes";
static NSString * const kSecondsTimeInfoKey = @"Seconds";

@interface MusicPlayerViewController () {
    
    UILabel *_titleDisplay;
    UILabel *_currentTimeDisplay;
    UILabel *_remainTimeDisplay;
    UISlider *_progressIndicator;
    
    NSMutableArray *_musicNameList;
    NSInteger _currentMusicIndex;
    
    AVAudioPlayer *_audioPlayer;
    BOOL _playing; // 跟踪当前播放器是否正在播放音乐
    
    NSTimer *_timer;
    BOOL _shouldUpdateIndicator; // 跟踪当前是否需要更新进度指示器
    
    SystemSoundID _systemSoundID;
}

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

- (void)initializeAudioSession;
- (void)initializeDataSource;
- (void)initializeUserInterface;
- (void)initializeAudioPlayerWithMusicName:(NSString *)musicName shouldAutoPlay:(BOOL)autoPlay;

// 音乐切换时更新界面显示
- (void)updateUserInterface;
// 音乐播放时更新时间显示
- (void)updateTimeDisplayWithDuration:(NSTimeInterval)duration currentTime:(NSTimeInterval)currentTime;
// 时间处理
- (NSDictionary *)timeInfoWithTimeInterval:(NSTimeInterval)timeInterval;

- (void)buttonPressed:(UIButton *)sender;

- (void)processPlayerState;
- (void)processPreviousMusic;
- (void)processNextMusic;
- (NSInteger)realIndexWithIndex:(NSInteger)index;

- (void)processSliderValueChanged:(UISlider *)slider;
- (void)processSliderTouchDown:(UISlider *)slider;
- (void)processSliderTouchUpInside:(UISlider *)slider;

- (void)processTimer:(NSTimer *)timer;
- (void)startTimer;
- (void)pauseTimer;
- (void)stopTimer;

@end

@implementation MusicPlayerViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"AudioPlayer";
        
        _currentMusicIndex = 0;
        _playing = NO;
        _shouldUpdateIndicator = YES;
        
    }
    return self;
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
        [_audioPlayer stop];
        _audioPlayer = audioPlayer;
    }
}

- (void)initializeAudioSession {
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *error = nil;
    BOOL success = NO;
    success = [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    NSAssert(success, @"Set audio session category failed with error message '%@'.", [error localizedDescription]);
    success = [audioSession setActive:YES error:&error];
    NSAssert(!error, @"Set audio session active failed with error message '%@'.", [error localizedDescription]);
}

- (void)initializeDataSource {
    
    _musicNameList = [@[@"Deemo Title Song - Website Version",
                        @"Release My Soul",
                        @"Rё.L",
                        @"Wings of piano"] mutableCopy];
    
    NSURL *systemSoundURL = [[NSBundle mainBundle] URLForResource:@"SystemSound" withExtension:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)systemSoundURL, &_systemSoundID);
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect bounds = self.view.bounds;
    
    _titleDisplay = [[UILabel alloc] init];
    _titleDisplay.bounds = CGRectMake(0, 0, CGRectGetWidth(bounds), 100);
    _titleDisplay.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMinY(bounds) + 100 + CGRectGetMidY(_titleDisplay.bounds));
    _titleDisplay.font = [UIFont systemFontOfSize:25];
    _titleDisplay.textAlignment = NSTextAlignmentCenter;
    _titleDisplay.numberOfLines = 0;
    _titleDisplay.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:_titleDisplay];
    
    _progressIndicator = [[UISlider alloc] init];
    _progressIndicator.bounds = CGRectMake(0, 0, 200, 30);
    _progressIndicator.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    _progressIndicator.minimumValue = 0;
    _progressIndicator.maximumValue = 0;
    _progressIndicator.value = 0;
    _progressIndicator.minimumTrackTintColor = [UIColor lightGrayColor];
    _progressIndicator.maximumTrackTintColor = [UIColor lightGrayColor];
    [_progressIndicator setThumbImage:[UIImage imageNamed:@"indicator.png"] forState:UIControlStateNormal];
    [_progressIndicator addTarget:self action:@selector(processSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_progressIndicator addTarget:self action:@selector(processSliderTouchDown:) forControlEvents:UIControlEventTouchDown];
    [_progressIndicator addTarget:self action:@selector(processSliderTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_progressIndicator];
    
    _currentTimeDisplay = [[UILabel alloc] init];
    _currentTimeDisplay.bounds = CGRectMake(0, 0, 50, 30);
    _currentTimeDisplay.center = CGPointMake(CGRectGetMinX(_progressIndicator.frame) - 5 - CGRectGetMidX(_currentTimeDisplay.bounds),
                                             CGRectGetMidY(_progressIndicator.frame));
    _currentTimeDisplay.text = @"-:--";
    _currentTimeDisplay.textAlignment = NSTextAlignmentRight;
    _currentTimeDisplay.font = [UIFont systemFontOfSize:14];
    _currentTimeDisplay.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_currentTimeDisplay];
    
    _remainTimeDisplay = [[UILabel alloc] init];
    _remainTimeDisplay.bounds = CGRectMake(0, 0, 50, 30);
    _remainTimeDisplay.center = CGPointMake(CGRectGetMaxX(_progressIndicator.frame) + 5 + CGRectGetMidX(_remainTimeDisplay.bounds),
                                            CGRectGetMidY(_progressIndicator.frame));
    _remainTimeDisplay.text = @"--:--";
    _remainTimeDisplay.textAlignment = NSTextAlignmentLeft;
    _remainTimeDisplay.font = [UIFont systemFontOfSize:14];
    _remainTimeDisplay.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_remainTimeDisplay];
    
    // 播放/暂停
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playButton.bounds = CGRectMake(0, 0, 40, 40);
    playButton.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMaxY(bounds) - 200);
    [playButton setBackgroundImage:[UIImage imageNamed:@"play.png"]  forState:UIControlStateNormal];
    [playButton setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateSelected];
    [playButton addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    playButton.tag = FUNCTION_BUTTON_TAG;
    [self.view addSubview:playButton];
    
    // 上一首
    UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    previousButton.bounds = CGRectMake(0, 0, 40, 40);
    previousButton.center = CGPointMake(CGRectGetMidX(bounds) - 70, CGRectGetMaxY(bounds) - 200);
    [previousButton setBackgroundImage:[UIImage imageNamed:@"back.png"]  forState:UIControlStateNormal];
    [previousButton addTarget:self
                       action:@selector(buttonPressed:)
             forControlEvents:UIControlEventTouchUpInside];
    previousButton.tag = FUNCTION_BUTTON_TAG + 1;
    [self.view addSubview:previousButton];
    
    // 下一首
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.bounds = CGRectMake(0, 0, 40, 40);
    nextButton.center = CGPointMake(CGRectGetMidX(bounds) + 70, CGRectGetMaxY(bounds) - 200);
    [nextButton setBackgroundImage:[UIImage imageNamed:@"next.png"]  forState:UIControlStateNormal];
    [nextButton addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    nextButton.tag = FUNCTION_BUTTON_TAG + 2;
    [self.view addSubview:nextButton];
    
    [self initializeAudioPlayerWithMusicName:_musicNameList[_currentMusicIndex] shouldAutoPlay:NO];
}

- (void)initializeAudioPlayerWithMusicName:(NSString *)musicName shouldAutoPlay:(BOOL)autoPlay {
    
    NSURL *musicURL = [[NSBundle mainBundle] URLForResource:musicName withExtension:@"mp3"];
    if (!musicURL) {
        return;
    }
    NSError *error = nil;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:&error];
    NSAssert(!error, @"Initialize audio player failed with error message '%@'.", [error localizedDescription]);
    _audioPlayer.numberOfLoops = -1;
    [_audioPlayer prepareToPlay];
    if (autoPlay) {
        [_audioPlayer play];
    }
    [self updateUserInterface];
}

- (void)updateUserInterface {
    
    _titleDisplay.text = _musicNameList[_currentMusicIndex];
    
    _progressIndicator.value = _audioPlayer.currentTime;
    _progressIndicator.minimumValue = 0;
    _progressIndicator.maximumValue = _audioPlayer.duration;
    
    [self updateTimeDisplayWithDuration:_audioPlayer.duration currentTime:_audioPlayer.currentTime];
}

- (void)updateTimeDisplayWithDuration:(NSTimeInterval)duration currentTime:(NSTimeInterval)currentTime {
    
    // 跟心当前播放时间显示
    NSDictionary *currentTimeInfo = [self timeInfoWithTimeInterval:currentTime];
    NSInteger currentMinutes = [currentTimeInfo[kMinutesTimeInfoKey] integerValue];
    NSInteger currentSeconds = [currentTimeInfo[kSecondsTimeInfoKey] integerValue];
    NSString *timeFormate = nil;
    if (currentSeconds >= 10) {
        timeFormate = @"%d:%d";
    }
    else {
        timeFormate = @"%d:0%d";
    }
    NSString *currentTimeString = [NSString stringWithFormat:timeFormate, currentMinutes, currentSeconds];
    _currentTimeDisplay.text = currentTimeString;
    
    // 更新剩余时间显示
    NSDictionary *remianTimeInfo = [self timeInfoWithTimeInterval:duration - currentTime];
    NSInteger remianMinutes = [remianTimeInfo[kMinutesTimeInfoKey] integerValue];
    NSInteger remianSeconds = [remianTimeInfo[kSecondsTimeInfoKey] integerValue];
    if (remianSeconds >= 10) {
        timeFormate = @"-%d:%d";
    }
    else {
        timeFormate = @"-%d:0%d";
    }
    NSString *remianTimeString = [NSString stringWithFormat:timeFormate, remianMinutes, remianSeconds];
    _remainTimeDisplay.text = remianTimeString;
}

- (NSDictionary *)timeInfoWithTimeInterval:(NSTimeInterval)timeInterval {
    
    NSInteger minutes = (NSInteger)round(timeInterval) / 60;
    NSInteger seconds = (NSInteger)round(timeInterval) % 60;
    return @{
        kMinutesTimeInfoKey: @(minutes),
        kSecondsTimeInfoKey: @(seconds)
    };
}

#pragma mark - Process button methods

- (void)buttonPressed:(UIButton *)sender {
    
    AudioServicesPlaySystemSound(_systemSoundID);
    
    NSInteger index = sender.tag - FUNCTION_BUTTON_TAG;
    switch (index) {
        case 0: [self processPlayerState]; break;
        case 1: [self processPreviousMusic]; break;
        case 2: [self processNextMusic]; break;
        default: break;
    }
}

- (void)processPlayerState {
    
    _playing = !_playing;
    if (_playing) {
        [self startTimer];
        [_audioPlayer play];
    }
    else {
        [self pauseTimer];
        [_audioPlayer pause];
    }
    [(UIButton *)[self.view viewWithTag:FUNCTION_BUTTON_TAG] setSelected:_playing];
}

- (void)processPreviousMusic {
    
    _currentMusicIndex = [self realIndexWithIndex:--_currentMusicIndex];
    [self initializeAudioPlayerWithMusicName:_musicNameList[_currentMusicIndex] shouldAutoPlay:_playing];
}

- (void)processNextMusic {
    
    _currentMusicIndex = [self realIndexWithIndex:++_currentMusicIndex];
    [self initializeAudioPlayerWithMusicName:_musicNameList[_currentMusicIndex] shouldAutoPlay:_playing];
}

- (NSInteger)realIndexWithIndex:(NSInteger)index {
    
    NSInteger maximumIndex = [_musicNameList count] - 1;
    if (index > maximumIndex) {
        index = 0;
    }
    else if (index < 0) {
        index = maximumIndex;
    }
    return index;
}

#pragma mark - Process lider methods 

- (void)processSliderValueChanged:(UISlider *)slider {
    
    [self updateTimeDisplayWithDuration:slider.maximumValue currentTime:slider.value];
}

- (void)processSliderTouchDown:(UISlider *)slider {
    
    _shouldUpdateIndicator = NO;
}

- (void)processSliderTouchUpInside:(UISlider *)slider {
    
    _shouldUpdateIndicator = YES;
    _audioPlayer.currentTime = slider.value;
}

#pragma mark - Process timer methods

- (void)processTimer:(NSTimer *)timer {
    
    if (_shouldUpdateIndicator) {
        _progressIndicator.value = _audioPlayer.currentTime;
        [self updateTimeDisplayWithDuration:_audioPlayer.duration currentTime:_audioPlayer.currentTime];
    }
}

- (void)startTimer {
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(processTimer:)
                                                userInfo:nil
                                                 repeats:YES];
    }
    
    [_timer setFireDate:[NSDate date]];
}

- (void)pauseTimer {
    
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)stopTimer {
    
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

@end
