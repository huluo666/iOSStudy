//
//  DDShopCartCell.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-20.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDShopCartCell.h"

@interface DDShopCartCell ()

@property (nonatomic ,retain) NSMutableArray *labels;

@end

@implementation DDShopCartCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _labels = [[NSMutableArray alloc] init];
        NSArray *widths = @[@(100), @(200), @(550)];
        CGFloat lastMaxX = 0;
        for (int i = 0; i < widths.count; i++) {
            UILabel *label = [[UILabel alloc] init];
            label.bounds = CGRectMake(0,
                                      0,
                                      [widths[i] floatValue],
                                      CGRectGetHeight(self.contentView.bounds));
            label.center = CGPointMake(lastMaxX + CGRectGetMidX(label.bounds),
                                       CGRectGetMidY(self.contentView.bounds));
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
            [label release];
            lastMaxX = CGRectGetMaxX(label.frame);
            label.layer.borderWidth = 1;
            label.layer.borderColor = [UIColor redColor].CGColor;
            
            [_labels addObject:label];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSDictionary *)data
{
    UILabel *label1 = (UILabel *)_labels[0];
    label1.text = [NSString stringWithFormat:@"%@个", data[@"buynumber"]];
    
    UILabel *label2 = (UILabel *)_labels[1];
    NSString *fkbg = nil;
    if ([data[@"buyProductInfo"] isKindOfClass:[NSArray class]]) {
        fkbg = data[@"buyProductInfo"][0][@"categoryName"];
    } else if ([data[@"buyProductInfo"] isKindOfClass:[NSDictionary class]]) {
        fkbg = data[@"buyProductInfo"][@"categoryName"];
    }
    label2.text = [NSString stringWithFormat:@"%@",fkbg ? fkbg : @"无力吐槽"];
    
    UILabel *label3 = (UILabel *)_labels[2];
    NSString *fkbgAgain = nil;
    if ([data[@"buyProductInfo"] isKindOfClass:[NSArray class]]) {
        fkbgAgain = data[@"buyProductInfo"][0][@"info"];
    } else if ([data[@"buyProductInfo"] isKindOfClass:[NSDictionary class]]) {
        fkbgAgain = data[@"buyProductInfo"][@"info"];
    }
    label3.text = [NSString stringWithFormat:@"%@",
                   fkbgAgain ? fkbgAgain : @"再次无力吐槽"];
}

@end
