//
//  AudioPlayer.h
//  UITask
//
//  Created by 萧川 on 14-2-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioPlayer : NSObject <NSCopying>

@property (nonatomic, copy) NSString *currentTime;
@property (nonatomic, copy) NSString *leftTime;

+ (AudioPlayer *)sharedSingleton;
+ (id)allocWithZone:(struct _NSZone *)zone;
- (id)copyWithZone:(NSZone *)zone;
- (id)retain;
- (NSUInteger)retainCount;
- (oneway void)release;
- (id)autorelease;

// 加载播放列表
- (void)loadNameList:(NSArray *)nameList;
// 播放音乐
- (void)playAudioName:(NSString *)audioName type:(NSString *)type;
// 停止播放
- (void)stop;

@end
