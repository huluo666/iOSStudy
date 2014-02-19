//
//  AudioRecorderViewController.m
//  音频、视频播放
//
//  Created by 张鹏 on 14-2-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "AudioRecorderViewController.h"
#import <AVFoundation/AVFoundation.h>

#define FUNCTION_BUTTON_TAG 30

@interface AudioRecorderViewController () <UIAlertViewDelegate> {
    
    AVAudioRecorder *_audioRecorder;
    AVAudioPlayer *_audioPlayer;
}

@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

- (void)initializeAudioSession;
- (void)initializeUserInterface;

- (void)buttonPressed:(UIButton *)sender;
- (void)startRecording;
- (void)stop;

@end

@implementation AudioRecorderViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"AudioRecorder";
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeAudioSession];
    [self initializeUserInterface];
}

- (void)setAudioRecorder:(AVAudioRecorder *)audioRecorder {
    
    if (_audioRecorder != audioRecorder) {
        if (_audioRecorder.isRecording) {
            [_audioRecorder stop];
        }
        [_audioRecorder deleteRecording];
        _audioRecorder = audioRecorder;
    }
}

- (void)setAudioPlayer:(AVAudioPlayer *)audioPlayer {
    
    if (_audioPlayer != audioPlayer) {
        if (_audioPlayer.isPlaying) {
            [_audioPlayer stop];
        }
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

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *recordButton = [UIButton buttonWithType:UIButtonTypeSystem];
    recordButton.bounds = CGRectMake(0, 0, 70, 40);
    recordButton.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    [recordButton setTitle:@"开始录音" forState:UIControlStateNormal];
    [recordButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    recordButton.tag = FUNCTION_BUTTON_TAG;
    [self.view addSubview:recordButton];
    
    UIButton *stopButton = [UIButton buttonWithType:UIButtonTypeSystem];
    stopButton.bounds = CGRectMake(0, 0, 70, 40);
    stopButton.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) + 50);
    [stopButton setTitle:@"停止" forState:UIControlStateNormal];
    [stopButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    stopButton.tag = FUNCTION_BUTTON_TAG + 1;
    [self.view addSubview:stopButton];
}

- (void)buttonPressed:(UIButton *)sender {
    
    NSInteger index = sender.tag - FUNCTION_BUTTON_TAG;
    if (index == 0) {
        [self startRecording];
    }
    else {
        [self stop];
    }
}

- (void)startRecording {
    
    self.audioPlayer = nil;
    
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *outPutPath = [documentDirectory stringByAppendingPathComponent:@"RecordOutputFile.caf"];
    NSURL *outPutURL = [NSURL fileURLWithPath:outPutPath];
    NSError *error = nil;
    self.audioRecorder = [[AVAudioRecorder alloc] initWithURL:outPutURL settings:nil error:&error];
    NSAssert(!error, @"Initialize audio recorder failed with error message '%@'.", [error localizedDescription]);
    [_audioRecorder prepareToRecord];
    [_audioRecorder record];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"录音中"
                                                    message:@"正在录音..."
                                                   delegate:self
                                          cancelButtonTitle:@"结束"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)stop {
    
    self.audioPlayer = nil;
    self.audioRecorder = nil;
}

#pragma mark - <UIAlertViewDelegate>

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [_audioRecorder stop];
    NSError *error = nil;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_audioRecorder.url error:&error];
    NSAssert(!error, @"Initialize audio palyer failed with error message '%@'.", [error localizedDescription]);
    _audioPlayer.numberOfLoops = -1;
    [_audioPlayer prepareToPlay];
    [_audioPlayer play];
}

@end
