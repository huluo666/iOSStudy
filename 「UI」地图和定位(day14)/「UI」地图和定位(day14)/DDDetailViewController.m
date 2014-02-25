//
//  DDDetailViewController.m
//  「UI」地图和定位(day14)
//
//  Created by 萧川 on 14-2-25.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "DDDetailViewController.h"

@interface DDDetailViewController (){
    
    NSDictionary *_dataSource;
    NSArray *_keyList;
}

- (void)initUserInterface;

@end

@implementation DDDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithDataSource:(NSDictionary *)dataSource
{
    if (self = [super init]) {
        _dataSource = dataSource;
        _keyList = @[@"City", @"Country", @"CountryCode", @"Name", @"State", @"Street", @"SubLocality", @"SubThoroughfare", @"Thoroughfare"];
        self.title = @"详细信息";
    }
    
    return self;
}

- (void)dealloc
{
    _dataSource = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self initUserInterface];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat coorY = 70.0f;
    for (NSInteger i = 0; i < _keyList.count; i++) {
        // key
        UILabel *keyLabel = [[UILabel alloc] init];
        // 获取高度
        CGFloat lineHeight = [self sizeWithString:_dataSource[_keyList[i]]];
        keyLabel.bounds = CGRectMake(0, 0, 160, lineHeight);
        keyLabel.center = CGPointMake(CGRectGetMidX(self.view.frame) / 2, lineHeight / 2 + coorY + 20);
        keyLabel.textAlignment = NSTextAlignmentRight;
        keyLabel.text = [NSString stringWithFormat:@"%@:", _keyList[i]];
        [self.view addSubview:keyLabel];
        
        // value
        UILabel *valueLabel = [[UILabel alloc] init];
        // 获取高度
        valueLabel.bounds = CGRectMake(0, 0, 160, lineHeight);
        valueLabel.center = CGPointMake(CGRectGetMidX(self.view.frame) / 2 * 3, lineHeight / 2 + coorY + 20);
        valueLabel.textAlignment = NSTextAlignmentLeft;
        valueLabel.numberOfLines = 0;
        valueLabel.font = [UIFont systemFontOfSize:15.0f];
        valueLabel.lineBreakMode = NSLineBreakByWordWrapping;
        valueLabel.text = _dataSource[_keyList[i]];
        [self.view addSubview:valueLabel];
        
        coorY = CGRectGetMaxY(keyLabel.frame); // 记录上一label y坐标
    }
}

- (CGFloat)sizeWithString:(NSString *)string
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(150, 400)
                                       options:NSStringDrawingTruncatesLastVisibleLine |
                                                NSStringDrawingUsesFontLeading |
                                                NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                       context:nil];
    return rect.size.height;
}

@end
