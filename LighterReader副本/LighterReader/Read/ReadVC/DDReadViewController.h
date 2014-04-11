//
//  DDReadViewController.h
//  LighterReader
//
//  Created by 萧川 on 14-4-10.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDReadViewController : UIViewController

@property (nonatomic, strong) id dataSource;
- (id)initWithDataSource:(id)dataSource;

@end
