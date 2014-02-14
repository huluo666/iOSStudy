//
//  DefaultCell.m
//  2014.2.14
//
//  Created by 张鹏 on 14-2-14.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "DefaultCell.h"

@implementation DefaultCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        // 配置cell附件显示类型
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end








