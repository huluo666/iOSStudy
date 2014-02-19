//
//  AudioRecorderViewController.m
//  2014.2.18
//
//  Created by 张鹏 on 14-2-18.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "AudioRecorderViewController.h"

@interface AudioRecorderViewController ()

- (void)initializeUserInterface;

@end

@implementation AudioRecorderViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"AudioRecorder";
        
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
}

@end
