//
//  MainViewController.m
//  MPMoviePlayerDemo
//
//  Created by wei.chen on 13-1-9.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MainViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "PlayerViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playDidChangeNotification:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    }
    return self;
}

- (void)playDidChangeNotification:(NSNotification *)notification {
    MPMoviePlayerController *moviePlayer = notification.object;
    MPMoviePlaybackState playState = moviePlayer.playbackState;
    if (playState == MPMoviePlaybackStateStopped) {
        NSLog(@"停止");
    } else if(playState == MPMoviePlaybackStatePlaying) {
        NSLog(@"播放");
    } else if(playState == MPMoviePlaybackStatePaused) {
        NSLog(@"暂停");
    }

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSString *urlstring = @"http://tv.flytv.com.cn/seg/17.m3u8";
//    NSURL *url = [NSURL URLWithString:urlstring];
//    
//    MPMoviePlayerController *moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
//    moviePlayer.view.frame = CGRectMake(0, 0, 320, 200);
//    moviePlayer.backgroundView.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:moviePlayer.view];
//    
//    [moviePlayer play];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playAction:(id)sender {
    NSString *urlstring = @"http://tv.flytv.com.cn/seg/17.m3u8";
    NSURL *url = [NSURL URLWithString:urlstring];
    
    MPMoviePlayerViewController *playerViewController = [[PlayerViewController alloc] initWithContentURL:url];
    
//    [self presentViewController:playerViewController animated:YES completion:NULL];
    [self presentMoviePlayerViewControllerAnimated:playerViewController];
    
}
@end
