//
//  AppDelegate.m
//  DatePickerDemo
//
//  Created by wei.chen on 13-1-4.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 480-216, 0, 0)];
    datePicker.tag = 100;
    datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:-60*60*24*365*10];
    datePicker.maximumDate = [NSDate date];
    datePicker.date = [NSDate dateWithTimeIntervalSinceNow:-60*60*24];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [self.window addSubview:datePicker];
    [datePicker release];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(100, 100, 20, 20);
    [button addTarget:self action:@selector(clickActon) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:button];
    
    return YES;
}

- (void)clickActon{
    UIDatePicker *datePicker = (UIDatePicker *)[self.window viewWithTag:100];
    NSDate *date = datePicker.date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSLog(@"%@",dateString);
    [dateFormatter release];
}

@end
