//
//  DDSignupViewController.m
//  LighterReader
//
//  Created by 萧川 on 14-3-27.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDSignupViewController.h"
#import "PJRegisteredView.h"

@interface DDSignupViewController ()

@end

@implementation DDSignupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        PJRegisteredView *registeView= [[PJRegisteredView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:registeView];
        [registeView release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

@end
