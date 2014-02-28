//
//  ViewController.m
//  相册和照相机
//
//  Created by 张鹏 on 13-12-6.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import "ViewController.h"
#import "ImagePickerManager.h"
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>

#define Function_Button_Tag  100

@interface ViewController () <UIActionSheetDelegate> {
    
    UIImageView *_imageView;
}

- (void)buttonPressed:(UIButton *)sender;

@end

@implementation ViewController

- (void)dealloc {
    
    [_imageView release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _imageView = [[UIImageView alloc] init];
    [_imageView setBounds:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetMidY(self.view.bounds) + 100)];
    [_imageView setCenter:CGPointMake(CGRectGetMidX(self.view.bounds),
                                      CGRectGetMinY(self.view.bounds) + CGRectGetMidY(_imageView.bounds))];
    [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    [_imageView setClipsToBounds:YES];
    [self.view addSubview:_imageView];
    
    UIButton *takePictureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [takePictureButton setBounds:CGRectMake(0, 0, 100, 30)];
    [takePictureButton setCenter:CGPointMake(CGRectGetMidX(self.view.bounds) - CGRectGetMidX(takePictureButton.bounds) - 50,
                                             CGRectGetMaxY(_imageView.frame) + 50)];
    [takePictureButton setTitle:@"选取照片" forState:UIControlStateNormal];
    [takePictureButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [takePictureButton setTag:Function_Button_Tag + 0];
    [self.view addSubview:takePictureButton];
    
    UIButton *takeMovieButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [takeMovieButton setBounds:CGRectMake(0, 0, 100, 30)];
    [takeMovieButton setCenter:CGPointMake(CGRectGetMidX(self.view.bounds) + CGRectGetMidX(takeMovieButton.bounds) + 50,
                                           CGRectGetMaxY(_imageView.frame) + 50)];
    [takeMovieButton setTitle:@"拍摄视频" forState:UIControlStateNormal];
    [takeMovieButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [takeMovieButton setTag:Function_Button_Tag + 1];
    [self.view addSubview:takeMovieButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonPressed:(UIButton *)sender {
    
    NSInteger index = sender.tag - Function_Button_Tag;
    // 选取照片
    if (index == 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选取照片"
                                                                 delegate:self
                                                        cancelButtonTitle:@"取消"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"相册", @"拍照", nil];
        [actionSheet showInView:self.view];
        [actionSheet release];
    }
    // 拍摄视频
    else {
        [[ImagePickerManager shareImagePickerManager] takePictureWithType:ImagePickerManagerTypeMovie
                                                               completion:^(BOOL success, id content) {
            if (success) {
                MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:content];
                [Root_View_Controller presentMoviePlayerViewControllerAnimated:moviePlayer];
                [moviePlayer release];
            }
        }];
    }
}

#pragma mark - <UIActionSheetDelegate>

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    // 相册
    if (buttonIndex == 0) {
        [[ImagePickerManager shareImagePickerManager] takePictureWithType:ImagePickerManagerTypePhotoLibrary
                                                               completion:^(BOOL success, id content) {
            if (success) {
                [_imageView setImage:content];
            }
        }];
    }
    // 拍照
    else if (buttonIndex == 1) {
        [[ImagePickerManager shareImagePickerManager] takePictureWithType:ImagePickerManagerTypeCamera
                                                               completion:^(BOOL success, id content) {
            if (success) {
                [_imageView setImage:content];
            }
        }];
    }
}

@end
