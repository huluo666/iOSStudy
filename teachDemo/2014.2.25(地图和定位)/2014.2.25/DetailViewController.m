//
//  DetailViewController.m
//  2014.2.25
//
//  Created by 张鹏 on 14-2-25.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () {
    
    NSDictionary *_addressDictinary;
}

- (void)initializeUserInterface;

@end

@implementation DetailViewController

- (instancetype)initWithAddressDictionary:(NSDictionary *)addressDictionary {
    
    self = [super init];
    if (self) {
        
        _addressDictinary = [addressDictionary retain];
        self.title = addressDictionary[@"Name"];
        
    }
    return self;
}

- (void)dealloc {
    
    [_addressDictinary release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeUserInterface];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect bounds = self.view.bounds;
    
    NSArray *itemList = @[@"City", @"Country", @"CountryCode",
                          @"Name", @"State", @"Street",
                          @"SubLocality", @"SubThoroughfare", @"Thoroughfare"];
    CGFloat offset_y = CGRectGetMinY(bounds) + 100;
    for (int i = 0; i < [itemList count]; i++) {
        
        NSString *item = _addressDictinary[itemList[i]];
        if (item.length == 0) {
            continue;
        }
        UIFont *font = [UIFont systemFontOfSize:15];
        
        // key
        UILabel *itemLabel = [[UILabel alloc] init];
        // lineHeight：字体行高
        itemLabel.bounds = CGRectMake(0, 0, 150, font.lineHeight);
        itemLabel.center = CGPointMake(CGRectGetMinX(bounds) + CGRectGetMidX(itemLabel.bounds),
                                       offset_y + CGRectGetMidY(itemLabel.bounds));
        itemLabel.text = [itemList[i] stringByAppendingString:@"："];
        itemLabel.textAlignment = NSTextAlignmentRight;
        itemLabel.font = font;
        itemLabel.backgroundColor = [UIColor clearColor];
        [self.view addSubview:itemLabel];
        [itemLabel release];
        
        
        CGRect textRect = [item boundingRectWithSize:CGSizeMake(200, 200)
                                             options:NSStringDrawingTruncatesLastVisibleLine |
                                                     NSStringDrawingUsesFontLeading |
                                                     NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName: font}
                                             context:nil];
        
        // value
        UILabel *itemDisplay = [[UILabel alloc] init];
        itemDisplay.bounds = CGRectMake(0, 0, CGRectGetWidth(textRect), CGRectGetHeight(textRect));
        itemDisplay.center = CGPointMake(CGRectGetMaxX(itemLabel.frame) + CGRectGetMidX(itemDisplay.bounds), CGRectGetMinY(itemLabel.frame) + CGRectGetMidY(itemDisplay.bounds));
        itemDisplay.text = item;
        itemDisplay.textAlignment = NSTextAlignmentLeft;
        itemDisplay.font = font;
        itemDisplay.backgroundColor = [UIColor clearColor];
        itemDisplay.numberOfLines = 0;
        itemDisplay.lineBreakMode = NSLineBreakByWordWrapping;
        [self.view addSubview:itemDisplay];
        [itemDisplay release];
        
        offset_y = CGRectGetMaxY(itemDisplay.frame) + 20;
    }
}

@end















