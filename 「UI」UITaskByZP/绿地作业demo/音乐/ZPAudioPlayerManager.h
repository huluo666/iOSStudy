//
//  ZPAudioPlayerManager.h
//  绿地作业demo
//
//  Created by 张鹏 on 14-2-19.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

// 播放完成通知
extern NSString * const ZPAudioPlayerManagerDidFinishPlayingNotification;

@interface ZPAudioPlayerManager : NSObject <NSCopying> {
    
    NSString *_musicName; // 当前播放歌曲名称
    NSTimeInterval _currentTime; // 当前播放时间
    NSTimeInterval _duration; // 当前歌曲总时长
    NSInteger _currentMusicIndex; // 当前歌曲索引
    NSMutableArray *_musicList; // 歌曲列表
    BOOL _playing; // 跟踪是否正在播放音乐
    BOOL _circulate; // 跟踪是否需要循环播放
}

@property (copy, nonatomic, readonly) NSString *musicName;
@property (assign, nonatomic) NSTimeInterval currentTime;
@property (assign, nonatomic, readonly) NSTimeInterval duration;
@property (assign, nonatomic) NSInteger currentMusicIndex;
@property (retain, nonatomic, readonly) NSMutableArray *musicList;
@property (assign, nonatomic, readonly, getter = isPlaying) BOOL playing;
@property (assign, nonatomic, getter = isCirculate) BOOL circulate;

- (id)init;

#pragma mark - 单利方法（完整单例）

+ (instancetype)sharedZPAudioPlayerManager;
+ (id)allocWithZone:(struct _NSZone *)zone;
- (id)copyWithZone:(NSZone *)zone;
- (id)retain;
- (NSUInteger)retainCount;
- (oneway void)release;
- (id)autorelease;

#pragma mark - 歌曲列表操作

- (void)addMusicList:(NSArray *)list;
- (void)clearMusicList;

#pragma mark - 播放控制

// 播放指定索引的歌曲
- (void)playAtIndex:(NSInteger)index;

- (void)play;
- (void)pause;
- (void)stop;
- (void)previous;
- (void)next;

@end
