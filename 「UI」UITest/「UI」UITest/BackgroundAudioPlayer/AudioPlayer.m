//
//  AudioPlayer.m
//  UITask
//
//  Created by 萧川 on 14-2-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "AudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface AudioPlayer ()

@property (retain, nonatomic) AVAudioPlayer *audioPlayer;
@property (retain, nonatomic) NSArray *audioNameList;
@property (assign, nonatomic) NSInteger currentAudioIndex;
@property (assign, nonatomic, getter = isPlaying) BOOL playing;
@property (assign, nonatomic, getter = isShouldUpdateIndicator) BOOL shouldUpdateIndicator;

@end

static AudioPlayer *audioPlayer = nil;

@implementation AudioPlayer

+ (AudioPlayer *)sharedSingleton {
    
    @synchronized(self) {
        if (!audioPlayer) {
            audioPlayer = [[self alloc] init];
        }
    }
    return audioPlayer;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    
    @synchronized(self) {
        if (!audioPlayer) {
            audioPlayer = [super allocWithZone:zone];
            return audioPlayer;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    
    return self;
}

- (id)retain {
    
    return self;
}

- (NSUInteger)retainCount {
    
    return NSUIntegerMax;
}

- (id)autorelease {
    
    return self;
}

- (oneway void)release {
    
}

- (void)dealloc
{
    [_audioPlayer release];
    [_audioNameList release];
    [_currentTime release];
    [_leftTime release];
    [super dealloc];
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

// 加载播放列表
- (void)loadNameList:(NSArray *)nameList
{
    self.audioNameList = nameList;
}

// 播放指定音乐
- (void)playAudioName:(NSString *)audioName type:(NSString *)type
{
    
    NSURL *audioURL = [[NSBundle mainBundle] URLForResource:audioName
                                              withExtension:type];
    if (!audioURL) {
        return;
    }
    
    NSError *error = nil;
    
    self.audioPlayer = [[[AVAudioPlayer alloc]
                        initWithContentsOfURL:audioURL
                        error:&error] autorelease];
    
    _audioPlayer.numberOfLoops = -1;
    [_audioPlayer prepareToPlay];
    [_audioPlayer play];
    _currentAudioIndex = [_audioNameList indexOfObject:audioName];
}

- (void)stop
{
    [_audioPlayer stop];
}
@end
