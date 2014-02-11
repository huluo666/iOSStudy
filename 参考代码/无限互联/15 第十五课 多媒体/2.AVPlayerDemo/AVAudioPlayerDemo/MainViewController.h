//
//  MainViewController.h
//  AVAudioPlayerDemo
//
//  Created by wei.chen on 13-1-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MainViewController : UIViewController<AVAudioPlayerDelegate> {
    AVAudioPlayer *audioPlayer;
}

@property (retain, nonatomic) IBOutlet UISlider *volumeSlider;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UISlider *currentSlider;
- (IBAction)volumeAction:(UISlider *)sender;
- (IBAction)currentAction:(UISlider *)sender;

- (IBAction)playAction:(UIButton *)sender;
@end
