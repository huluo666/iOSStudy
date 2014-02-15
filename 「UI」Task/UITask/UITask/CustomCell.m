//
//  CustomCell.m
//  UITask
//
//  Created by 萧川 on 14-2-15.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "CustomCell.h"

@interface CustomCell ()

@property (retain, nonatomic) UIImageView *customImageView;
@property (retain, nonatomic) UILabel *customTextLabel;

@end

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = [UIColor greenColor];
        self.selectedBackgroundView = backView;
        [backView release];
        self.detailTextLabel.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backS"]];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        _customImageView = [[UIImageView alloc] init];
        _customImageView.bounds = CGRectMake(0, 0, 30, 30);
        _customImageView.center = CGPointMake(20, CELL_ROW_HEIGHT / 2);
        [self.contentView addSubview:_customImageView];

        _customTextLabel = [[UILabel alloc] init];
        _customTextLabel.bounds = CGRectMake(0, 0, 120, CELL_ROW_HEIGHT);
        _customTextLabel.center = CGPointMake(105, CELL_ROW_HEIGHT / 2);
        _customTextLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_customTextLabel];
    }
    
    return self;
}

- (void)dealloc
{
    [_customImage release];
    [_customText release];
    [_customImageView release];
    [_customTextLabel release];
    [super dealloc];
}

- (void)setCustomImage:(UIImage *)customImage
{
    if (customImage != _customImage) {
        [_customImage release];
        _customImage = [customImage retain];
        _customImageView.image = _customImage;
    }
}

- (void) setCustomText:(NSString *)customText
{
    if (customText != _customText) {
        [_customText release];
        _customText = [customText retain];
        _customTextLabel.text = _customText;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
