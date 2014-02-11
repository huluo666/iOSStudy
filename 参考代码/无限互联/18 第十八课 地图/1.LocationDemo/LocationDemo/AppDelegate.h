//
//  AppDelegate.h
//  LocationDemo
//
//  Created by wei.chen on 13-1-14.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,MKReverseGeocoderDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
