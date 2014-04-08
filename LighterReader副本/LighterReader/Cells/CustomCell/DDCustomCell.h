//
//  DDCustomCell.h
//  LighterReader
//
//  Created by 萧川 on 14-4-3.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDCustomCell : UITableViewCell

@property (strong, nonatomic, readonly) UILabel *titleLabel;
@property (strong, nonatomic, readonly) UILabel *reviewLabel;
@property (strong, nonatomic, readonly) UILabel *hintLabel;

@property (strong, nonatomic, readonly) UIImage *leftImage;

@end
