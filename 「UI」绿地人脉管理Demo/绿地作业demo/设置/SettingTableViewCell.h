//
//  SettingTableViewCell.h
//  绿地作业demo
//
//  Created by 张鹏 on 14-2-15.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTableViewCell : UITableViewCell {
    
    UIImageView *_titleImageView;
    UILabel *_titleDisplay;
    UILabel *_subTitleDisplay;
}

@property (retain, nonatomic) UIImageView *titleImageView;
@property (retain, nonatomic) UILabel *titleDisplay;
@property (retain, nonatomic) UILabel *subTitleDisplay;

@end
