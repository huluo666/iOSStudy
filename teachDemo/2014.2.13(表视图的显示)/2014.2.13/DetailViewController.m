//
//  DetailViewController.m
//  2014.2.13
//
//  Created by 张鹏 on 14-2-13.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () {
    
    NSString *_fontName;
}

- (void)initializeUserInterface;

@end

@implementation DetailViewController

- (id)initWithFontName:(NSString *)fontName {
    
    self = [super init];
    if (self) {
        
        _fontName = [fontName copy];
        self.title = _fontName;
        
    }
    return self;
}

- (void)dealloc {
    
    [_fontName release];
    
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = _fontName;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:_fontName size:30];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [self.view addSubview:label];
    [label release];
}

@end


















