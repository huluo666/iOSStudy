//
//  AudioPlayerViewController.h
//  UITask
//
//  Created by 萧川 on 14-2-18.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioPlayerViewController : UIViewController

@property (retain, nonatomic) NSArray *audioNameList;
@property (assign, nonatomic) NSInteger currentAudioIndex;

- (id)initWithDataSource:(NSArray *)dataSource
       currentAudioIndex:(NSInteger)currentAudioIndex;

@end
