//
//  DDViewController.m
//  面试职通车
//
//  Created by 萧川 on 14-4-16.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDViewController.h"

@interface DDViewController ()
@end

@implementation DDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIImage *backBarImage = DDImageWithName(@"title_return");
        UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc]
                                        initWithImage:backBarImage
                                        style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(backBarItemAction)];
        
        UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil
                                       action:nil];
        fixedSpace.width = -20;
        self.navigationItem.leftBarButtonItems = @[fixedSpace, backBarItem];
    }
    return self;
}

- (void)backBarItemAction {
    
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
