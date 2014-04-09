//
//  DDNaviCell.h
//  LighterReader
//
//  Created by 萧川 on 14-4-8.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDNaviCell : UITableViewCell

@property (nonatomic, strong, readonly) UIButton *imageButton;
@property (nonatomic, strong, readonly) UIImageView *leftImageView;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *commentLabel;

@property (nonatomic, strong) void (^imageButtonAction)(UIButton *sender);

@property (nonatomic, assign, getter = isExpandable) BOOL expandable;
@property (nonatomic, assign, getter = isExpanded) BOOL expanded;

@end
