//
//  AudioViewController.m
//  音频、视频播放
//
//  Created by 张鹏 on 13-12-11.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import "AudioViewController.h"
#import "ZPAudioPlayerManager.h"

#define BUTTON_TAG 10

@interface AudioViewController () {
    
    NSTimer *_timer; // 计时器
    UILabel *_titleDisplay; // 当前音乐播放名称显示
    UILabel *_currentTimeDisplay; // 播放当前时间显示
    UILabel *_remainTimeDisplay; // 播放剩余时间显示
    UISlider *_progressIndicator; // 播放进度指示器
    BOOL _stopUpdatingProgress; // 跟踪是否需要停止更新指示器
    
    ZPAudioPlayerManager *_audioPlayerManager;
}

// 初始化用户界面
- (void)initializeUserInterface;
// 刷新用户界面显示
- (void)updateUserInterface;
// 根据指定音乐更新标题显示
- (void)updateTitleDisplayWithMusic:(NSString *)music;
// 更新进度指示器显示
- (void)updateProgressIndicator;
// 更新时间显示
- (void)updateTimeDisplayWithDuration:(NSTimeInterval)duration currentTime:(NSTimeInterval)currentTime;
// 处理时间
- (NSDictionary *)processTime:(NSTimeInterval)time;

// 按钮点击
- (void)buttonPressed:(UIButton *)sender;
// 播放/暂停
- (void)handlePlaying:(UIButton *)sender;
// 上一首
- (void)previousSound;
// 下一首
- (void)nextSound;

// 处理指示器时间，完成播放进度调整
- (void)sliderValueChanged:(UISlider *)sender;
// 指示器按钮按下
- (void)sliderTouchDown:(UISlider *)sender;
// 指示器按钮按下抬起
- (void)sliderTouchUpInside:(UISlider *)sender;

// 启动计时器
- (void)startTimer;
// 暂停计时器
- (void)pauseTimer;
// 停止时器
- (void)stopTimer;


@end

@implementation AudioViewController

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self setTitle:NSStringFromClass([self class])];
        
        _audioPlayerManager = [ZPAudioPlayerManager sharedZPAudioPlayerManager];
        // 注册播放完成通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateUserInterface)
                                                     name:ZPAudioPlayerManagerDidFinishPlayingNotification
                                                   object:_audioPlayerManager];
        
    }
    return self;
}

- (void)dealloc {
    
    [_titleDisplay       release];
    [_currentTimeDisplay release];
    [_remainTimeDisplay  release];
    [_progressIndicator  release];
    [_timer              release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"%@ dealloced.", NSStringFromClass([self class]));
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    // 初始化用户界面
    [self initializeUserInterface];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    // 界面将要推出时停止计时器刷新
    [self stopTimer];
}

#pragma mark - Initialize methods

- (void)initializeUserInterface {
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    // 当前播放歌曲名称显示
    _titleDisplay = [[UILabel alloc] init];
    _titleDisplay.bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 10);
    _titleDisplay.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                       CGRectGetMinY(self.view.bounds) + 150 + CGRectGetMidY(_titleDisplay.bounds));
    _titleDisplay.font = [UIFont systemFontOfSize:20];
    _titleDisplay.textAlignment = NSTextAlignmentCenter;
    _titleDisplay.backgroundColor = [UIColor clearColor];
    _titleDisplay.numberOfLines = 0;
    _titleDisplay.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:_titleDisplay];
    
    
    // 播放进度指示器
    _progressIndicator = [[UISlider alloc] init];
    _progressIndicator.bounds = CGRectMake(0, 0, 200, 20);
    _progressIndicator.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                              CGRectGetMaxY(_titleDisplay.frame) + 100 + CGRectGetMidY(_progressIndicator.bounds));
    _progressIndicator.maximumTrackTintColor = [UIColor lightGrayColor];
    _progressIndicator.minimumTrackTintColor = [UIColor lightGrayColor];
    [_progressIndicator setThumbImage:[UIImage imageNamed:@"indicator.png"]
                             forState:UIControlStateNormal];
    // 为slider添加一个拖动事件，以达到播放进度调整
    [_progressIndicator addTarget:self
                           action:@selector(sliderValueChanged:)
                 forControlEvents:UIControlEventValueChanged];
    // slider按下后停止刷新进度
    [_progressIndicator addTarget:self
                           action:@selector(sliderTouchDown:)
                 forControlEvents:UIControlEventTouchDown];
    // slider按下抬起后继续刷新进度
    [_progressIndicator addTarget:self
                           action:@selector(sliderTouchUpInside:)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_progressIndicator];
    
    
    // 播放时间显示
    _currentTimeDisplay = [[UILabel alloc] init];
    _currentTimeDisplay.bounds = CGRectMake(0, 0, 60, 20);
    _currentTimeDisplay.center = CGPointMake(CGRectGetMinX(_progressIndicator.frame) - 10 - CGRectGetMidX(_currentTimeDisplay.bounds),
                                             CGRectGetMidY(_progressIndicator.frame));
    _currentTimeDisplay.textAlignment = NSTextAlignmentRight;
    _currentTimeDisplay.font = [UIFont systemFontOfSize:15];
    _currentTimeDisplay.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_currentTimeDisplay];
    
    
    // 剩余时间显示
    _remainTimeDisplay = [[UILabel alloc] init];
    _remainTimeDisplay.bounds = CGRectMake(0, 0, 60, 20);
    _remainTimeDisplay.center = CGPointMake(CGRectGetMaxX(_progressIndicator.frame) + 10 + CGRectGetMidX(_remainTimeDisplay.bounds),
                                            CGRectGetMidY(_progressIndicator.frame));
    _remainTimeDisplay.textAlignment = NSTextAlignmentLeft;
    _remainTimeDisplay.font = [UIFont systemFontOfSize:15];
    _remainTimeDisplay.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_remainTimeDisplay];
    
    
    // 播放按钮
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playButton.bounds = CGRectMake(0, 0, 40, 40);
    playButton.center = CGPointMake(CGRectGetMidX(self.view.bounds),
                                    CGRectGetMaxY(_progressIndicator.frame) + 100);
    playButton.selected = _audioPlayerManager.playing;
    [playButton setBackgroundImage:[UIImage imageNamed:@"play.png"]   forState:UIControlStateNormal];
    [playButton setBackgroundImage:[UIImage imageNamed:@"pause.png"]  forState:UIControlStateSelected];
    [playButton addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    playButton.tag = BUTTON_TAG;
    [self.view addSubview:playButton];
    
    // 上一首按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.bounds = CGRectMake(0, 0, 40, 40);
    backButton.center = CGPointMake(CGRectGetMidX(self.view.bounds) - 50 - CGRectGetMidX(backButton.bounds),
                                    CGRectGetMidY(playButton.frame));
    [backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backButton addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = BUTTON_TAG + 1;
    [self.view addSubview:backButton];
    
    // 下一首按钮
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setBounds:CGRectMake(0, 0, 40, 40)];
    [nextButton setCenter:CGPointMake(CGRectGetMidX(self.view.bounds) + 50 +
                                      CGRectGetMidX(nextButton.bounds),
                                      CGRectGetMidY(playButton.frame))];
    [nextButton setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
    [nextButton addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    [nextButton setTag:BUTTON_TAG + 2];
    [self.view addSubview:nextButton];
    
    [self updateUserInterface];
}

- (void)updateUserInterface {
    
    // 更新按钮显示
    [(UIButton *)[self.view viewWithTag:BUTTON_TAG] setSelected:_audioPlayerManager.playing];
    
    // 判断当前是否正在播放，若正在播放则更新指示器
    if (_audioPlayerManager.playing) {
        [self startTimer];
    }
    
    // 重置进度指示
    [_progressIndicator setValue:0.0];
    [_progressIndicator setMinimumValue:0.0];
    [_progressIndicator setMaximumValue:_audioPlayerManager.duration];
    
    // 更新标题
    [self updateTitleDisplayWithMusic:_audioPlayerManager.musicName];
    // 更新时间显示
    [self updateTimeDisplayWithDuration:_audioPlayerManager.duration
                            currentTime:_audioPlayerManager.currentTime];
}

#pragma mark - Data processing methods

- (void)updateTitleDisplayWithMusic:(NSString *)music {
    
    CGRect rect = [music boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.view.bounds), 200)
                                      options:NSStringDrawingTruncatesLastVisibleLine |
                                              NSStringDrawingUsesFontLeading |
                                              NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20]}
                                      context:nil];
    CGPoint center = _titleDisplay.center;
    [_titleDisplay setBounds:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    [_titleDisplay setCenter:center];
    [_titleDisplay setText:music];
}

- (NSDictionary *)processTime:(NSTimeInterval)time {
    
    NSMutableDictionary *timeInfoDict = [NSMutableDictionary dictionary];
    // 获取分
    NSInteger minutes = (NSInteger)time / 60;
    // 获取秒
    NSInteger seconds = (NSInteger)time % 60;
    // 打包字典
    [timeInfoDict setObject:@(minutes) forKey:@"minutes"];
    [timeInfoDict setObject:@(seconds) forKey:@"seconds"];
    
    return timeInfoDict;
}

#pragma mark - Audio handling methods

- (void)buttonPressed:(UIButton *)sender {
    
    NSInteger index = sender.tag - BUTTON_TAG;
    switch (index) {
            // 播放/暂停
        case 0: [self handlePlaying:sender]; break;
            // 上一首
        case 1: [self previousSound]; break;
            // 下一首
        case 2: [self nextSound]; break;
            
        default: break;
    }
}

- (void)handlePlaying:(UIButton *)sender {
    
    // 播放
    if (!_audioPlayerManager.playing) {
        [_audioPlayerManager play];
        [self startTimer];
    }
    // 暂停
    else {
        [_audioPlayerManager pause];
        [self pauseTimer];
    }
    [sender setSelected:_audioPlayerManager.playing];
}

- (void)previousSound {
    
    [_audioPlayerManager previous];
    [self updateUserInterface];
}

- (void)nextSound {
    
    [_audioPlayerManager next];
    [self updateUserInterface];
}

#pragma mark - Slider events handling methods

- (void)sliderValueChanged:(UISlider *)sender {
    
    [self updateTimeDisplayWithDuration:sender.maximumValue currentTime:sender.value];
}

- (void)sliderTouchDown:(UISlider *)sender {
    
    _stopUpdatingProgress = YES;
}

- (void)sliderTouchUpInside:(UISlider *)sender {
    
    _stopUpdatingProgress = NO;
    _audioPlayerManager.currentTime = sender.value;
}

- (void)updateProgressIndicator {
    
    // 在拖动slider的过程中，停止刷新播放进度
    if (!_stopUpdatingProgress) {
        // 更新进度指示
        _progressIndicator.value = _audioPlayerManager.currentTime;
        // 更新时间显示
        [self updateTimeDisplayWithDuration:_audioPlayerManager.duration
                                currentTime:_audioPlayerManager.currentTime];
    }
}

- (void)updateTimeDisplayWithDuration:(NSTimeInterval)duration currentTime:(NSTimeInterval)currentTime {
    
    // 处理当前时间
    NSDictionary *currentTimeInfoDict = [self processTime:currentTime];
    // 取出对应的分、秒组件
    NSInteger currentMinutes = [currentTimeInfoDict[@"minutes"] integerValue];
    NSInteger currentSeconds = [currentTimeInfoDict[@"seconds"] integerValue];
    NSString *currentFormateString = nil;
    if (currentSeconds < 10) {
        currentFormateString = @"%d:0%d";
    }
    else {
        currentFormateString = @"%d:%d";
    }
    NSString *currentTimeString = [NSString stringWithFormat:currentFormateString, currentMinutes, currentSeconds];
    [_currentTimeDisplay setText:currentTimeString];;
    
    // 处理当前时间
    NSDictionary *remainTimeInfoDict = [self processTime:duration - currentTime];
    // 取出对应的分、秒组件
    NSInteger remainMinutes = [remainTimeInfoDict[@"minutes"] integerValue];
    NSInteger remainSeconds = [remainTimeInfoDict[@"seconds"] integerValue];
    NSString *remainFormateString = nil;
    if (remainSeconds < 10) {
        remainFormateString = @"-%d:0%d";
    }
    else {
        remainFormateString = @"-%d:%d";
    }
    NSString *remianTimeString = [NSString stringWithFormat:remainFormateString, remainMinutes, remainSeconds];
    [_remainTimeDisplay setText:remianTimeString];;
}

#pragma mark - Timer handling methods

- (void)startTimer {
    
    if (!_timer) {
        _timer = [[NSTimer scheduledTimerWithTimeInterval:1.0
                                                   target:self
                                                 selector:@selector(updateProgressIndicator)
                                                 userInfo:nil
                                                  repeats:YES] retain];
    }
    // 激活timer
    [_timer setFireDate:[NSDate date]];
}

- (void)pauseTimer {
    
    // 暂停timer
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)stopTimer {
    
    if ([_timer isValid]) {
        [_timer invalidate];
    }
}
@end
