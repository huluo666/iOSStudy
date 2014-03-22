//
//  DDFinancingProductsCell.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-14.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDFinancingProductsCell.h"

@implementation DDFinancingProductsCell

- (void)dealloc
{
    NSLog(@"%@ is dealloced", [self class]);
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImage *backgroundImage = kImageWithName(@"line_15");
        UIImageView *backgroundView = [[UIImageView alloc]
                                       initWithImage:backgroundImage];
        self.backgroundView = backgroundView;
        [backgroundView release];

        UIImage *selectedBackgroundImage = kImageWithName(@"选中new");
        UIImageView *selectedBackgroundView = [[UIImageView alloc]
                                               initWithImage:selectedBackgroundImage];
        self.selectedBackgroundView = selectedBackgroundView;
        [selectedBackgroundView release];
        
        // 配置contentView
        NSArray *labelsWidth = @[@"71", @"165", @"55", @"65", @"45", @"94",
                                 @"94", @"93", @"93", @"52", @"50"];
        CGFloat lastLabelMaxX = 0;
        for (int i = 0; i < labelsWidth.count; i++) {
            UILabel *label = [[UILabel alloc] init];
            label.bounds = CGRectMake(0,
                                      0,
                                      [labelsWidth[i] floatValue],
                                      CGRectGetHeight(self.contentView.bounds));
            label.center = CGPointMake(lastLabelMaxX + CGRectGetMidX(label.bounds),
                                       CGRectGetMidY(self.contentView.bounds));
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"2013-08-12";
            label.numberOfLines = 2;
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor grayColor];
            lastLabelMaxX = CGRectGetMaxX(label.frame);
            [self.contentView addSubview:label];
            [label release];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
