//
//  DDShopCartCell.h
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-20.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDShopCartCell : UITableViewCell

@property (retain, nonatomic) NSDictionary *data;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier;

@end
