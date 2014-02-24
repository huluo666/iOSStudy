//
//  ZPAudioPlayerManager.m
//  绿地作业demo
//
//  Created by 张鹏 on 14-2-19.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ZPAudioPlayerManager.h"
#import <AVFoundation/AVFoundation.h>

static ZPAudioPlayerManager * singletonInstance = nil;

NSString * const ZPAudioPlayerManagerDidFinishPlayingNotification = @"ZPAudioPlayerManagerDidFinishPlayingNotification";

@interface ZPAudioPlayerManager () <AVAudioPlayerDelegate> {
    
    AVAudioPlayer *_audioPlayer;
}

@property (retain, nonatomic) AVAudioPlayer *audioPlayer;

// 根据索引初始化播放器
- (void)initializeAudioPlayerWithMusicIndex:(NSInteger)index;
// 计算当前播放索引
- (NSInteger)acurateIndexWithIndex:(NSInteger)index;

@end

@implementation ZPAudioPlayerManager

#pragma mark - Singleton methods

+ (instancetype)sharedZPAudioPlayerManager {
    
    @synchronized(self) {
        if (!singletonInstance) {
            singletonInstance = [[ZPAudioPlayerManager alloc] init];
        }
    }
    return singletonInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    
    @synchronized(self) {
        if (!singletonInstance) {
            singletonInstance = [super allocWithZone:zone];
            return singletonInstance;
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

- (oneway void)release {
    
    // ...
}

- (id)autorelease {
    
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        _currentTime = 0.0;
        _duration = 0.0;
        _currentMusicIndex = 0;
        _musicList = [[NSMutableArray alloc] init];
        _playing = NO;
        _circulate = NO;
    }
    return self;
}

- (void)setAudioPlayer:(AVAudioPlayer *)audioPlayer {
    
    if (_audioPlayer != audioPlayer) {
        if (_audioPlayer.playing) {
            [_audioPlayer stop];
        }
        [_audioPlayer release];
        _audioPlayer = [audioPlayer retain];
    }
}

- (NSString *)musicName {
    
    if (_audioPlayer) {
        _musicName = _musicList[_currentMusicIndex];
    }
    return _musicName;
}

- (void)setCurrentTime:(NSTimeInterval)currentTime {
    
    if (_audioPlayer) {
        _currentTime = currentTime;
        _audioPlayer.currentTime = currentTime;
    }
    else {
        _currentTime = 0;
    }
}

- (NSTimeInterval)currentTime {
    
    if (_audioPlayer) {
        _currentTime = _audioPlayer.currentTime;
    }
    else {
        _currentTime = 0;
    }
    return _currentTime;
}

- (NSTimeInterval)duration {
    
    if (_audioPlayer) {
        _duration = _audioPlayer.duration;
    }
    else {
        _duration = 0;
    }
    return _duration;
}

- (NSInteger)currentMusicIndex {
    
    return _currentMusicIndex;
}

- (BOOL)isPlaying {
    
    return _playing;
}

#pragma mark - Process dataSource methods

- (void)addMusicList:(NSArray *)list {
    
    if (_musicList && [list count] > 0) {
        [_musicList addObjectsFromArray:list];
    }
}

- (void)clearMusicList {
    
    if (_musicList && [_musicList count] > 0) {
        [_musicList removeAllObjects];
    }
}

#pragma mark - Audio player control methods

- (void)initializeAudioPlayerWithMusicIndex:(NSInteger)index {
    
    if (!_musicList ||
        [_musicList count] == 0 ||
        index > [_musicList count] - 1) {
        return;
    }
    // 更新当前播放索引
    _currentMusicIndex = index;
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:_musicList[index] withExtension:@"mp3"];
    if (!url) {
        return;
    }
    NSError *error = nil;
    self.audioPlayer = [[[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error] autorelease];
    // 错误判断
    if (error) {
        NSLog(@"Initialize audio player failed with error message '%@'.", [error localizedDescription]);
        return;
    }
    _audioPlayer.delegate = self;
    [_audioPlayer prepareToPlay];
    // 判断是否需要自动播放
    if (_playing) {
        [_audioPlayer play];
    }
}

- (void)playAtIndex:(NSInteger)index {
    
    _playing = YES;
    [self initializeAudioPlayerWithMusicIndex:[self acurateIndexWithIndex:index]];
}

- (void)play {
    
    _playing = YES;
    
    if (!_audioPlayer) {
        [self initializeAudioPlayerWithMusicIndex:_currentMusicIndex];
    }
    else if (!_audioPlayer.playing){
        [_audioPlayer play];
    }
}

- (void)pause {
    
    if (_audioPlayer && _audioPlayer.playing) {
        _playing = NO;
        [_audioPlayer pause];
    }
}

- (void)stop {
    
    if (_audioPlayer && _audioPlayer.playing) {
        _playing = NO;
        [_audioPlayer stop];
    }
}

- (void)previous {
    
    _currentMusicIndex = [self acurateIndexWithIndex:--_currentMusicIndex];
    [self initializeAudioPlayerWithMusicIndex:_currentMusicIndex];
}

- (void)next {
    
    _currentMusicIndex = [self acurateIndexWithIndex:++_currentMusicIndex];
    [self initializeAudioPlayerWithMusicIndex:_currentMusicIndex];
}

#pragma mark - Process data methods

- (NSInteger)acurateIndexWithIndex:(NSInteger)index {
    
    NSInteger maximumIndex = [_musicList count] - 1;
    if (index > maximumIndex) {
        index = 0;
    }
    else if (index < 0) {
        index = maximumIndex;
    }
    return index;
}

#pragma mark - <AVAudioPlayerDelegate>

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
    // 判断是否需要循环播放，否则播放下一曲
    if (_circulate) {
        [self initializeAudioPlayerWithMusicIndex:_currentMusicIndex];
    }
    else {
        [self next];
    }
    // 发送播放完成通知
    [[NSNotificationCenter defaultCenter] postNotificationName:ZPAudioPlayerManagerDidFinishPlayingNotification
                                                        object:self
                                                      userInfo:nil];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    
    NSLog(@"Audio player decode error did occur with error message '%@'.", [error localizedDescription]);
}

@end
