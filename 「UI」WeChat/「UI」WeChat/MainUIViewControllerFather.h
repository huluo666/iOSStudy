//
//  MainViewController.h
//  「UI」WeChat
//
//  Created by cuan on 14-2-1.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainUIViewControllerFather;
// 写一个显示设置选项TableView的协议
@protocol MianVCDelegate <NSObject>

- (void)mainUIViewCotrollerFatherShowSettingTableView:(MainUIViewControllerFather *)mainVCfather;

@end


@interface MainUIViewControllerFather : UIViewController

@property (nonatomic, assign) id<MianVCDelegate> delegate;

@end
