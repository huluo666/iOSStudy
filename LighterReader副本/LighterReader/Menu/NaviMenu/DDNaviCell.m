    //
//  DDNaviCell.m
//  LighterReader
//
//  Created by 萧川 on 14-4-8.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDNaviCell.h"

@interface DDNaviCell ()

@property (nonatomic, strong, readwrite) UIButton *imageButton;
@property (nonatomic, strong, readwrite) UIImageView *leftImageView;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *commentLabel;

- (void)imageButtonAction:(UIButton *)sender;

@end

@implementation DDNaviCell

@synthesize imageButton = _imageButton;
@synthesize leftImageView = _leftImageView;
@synthesize titleLabel = _titleLabel;
@synthesize commentLabel = _commentLabel;

- (void)dealloc {
    
    NSLog(@"%@", [self class]);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat width = [[UIScreen mainScreen] bounds].size.width;
        self.contentView.bounds = CGRectMake(0, 0, width - 40, 44);
        
        _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageButton.frame = CGRectMake(0, 0, 44, 44);
        [_imageButton addTarget:self action:@selector(imageButtonAction:)
                   forControlEvents:UIControlEventTouchUpInside];
        [self.imageButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [self.contentView addSubview:_imageButton];
        
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [self.contentView addSubview:_leftImageView];
        
        _titleLabel = [[UILabel alloc]
                       initWithFrame:CGRectMake(44,
                                                0,
                                                CGRectGetWidth(self.contentView.bounds) - 44 - 44,
                                                44)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        
        _commentLabel = [[UILabel alloc]
                         initWithFrame:CGRectMake(CGRectGetMaxX(_titleLabel.frame),
                                                    0,
                                                    CGRectGetWidth(self.contentView.bounds) -
                                                    CGRectGetMaxX(_titleLabel.frame),
                                                    44)];
        _commentLabel.textColor = [UIColor grayColor];
        _commentLabel.font = [UIFont systemFontOfSize:15];
        _commentLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_commentLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)imageButtonAction:(UIButton *)sender {

    sender.selected = sender.isSelected ? NO : YES;
    if (_imageButtonAction) {
        _imageButtonAction(sender);
    }
}

@end
