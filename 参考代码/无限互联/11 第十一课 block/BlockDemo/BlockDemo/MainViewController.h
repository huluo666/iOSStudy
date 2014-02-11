//
//  MainViewController.h
//  BlockDemo
//
//  Created by wei.chen on 13-1-4.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
//定义一个block类型
typedef int(^MyBlock)(int);

@interface MainViewController : UIViewController {
    int number;
}

@end
