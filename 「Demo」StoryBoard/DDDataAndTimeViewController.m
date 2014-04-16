//
//  DDDataAndTimeViewController.m
//  「Demo」StoryBoard
//
//  Created by 萧川 on 14-4-16.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDDataAndTimeViewController.h"

@interface DDDataAndTimeViewController ()

@end

@implementation DDDataAndTimeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {

    NSDate *now = [NSDate date];
    _dateLabel.text = [NSDateFormatter
                      localizedStringFromDate:now
                      dateStyle:NSDateFormatterLongStyle
                      timeStyle:NSDateFormatterNoStyle];
    _timeLabel.text = [NSDateFormatter
                      localizedStringFromDate:now
                      dateStyle:NSDateFormatterNoStyle
                      timeStyle:NSDateFormatterLongStyle];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
