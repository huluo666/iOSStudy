//
//  DetailViewController.m
//  2014.2.14
//
//  Created by 张鹏 on 14-2-14.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

- (void)initializeUserInterface;

@end

@implementation DetailViewController

- (id)initWithFontName:(NSString *)font {
    
    self = [super init];
    if (self) {
        
        self.title = font;
        
    }
    return self;
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
    label.text = self.title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:self.title size:30];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    [self.view addSubview:label];
    [label release];
}

@end
















