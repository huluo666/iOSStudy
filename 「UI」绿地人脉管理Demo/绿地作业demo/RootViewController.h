//
//  RootViewController.h
//  绿地作业demo
//
//  Created by 张鹏 on 14-2-12.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController {
    
    BOOL _login;
}

@property (assign, nonatomic, getter = isLogin) BOOL login;

@end
