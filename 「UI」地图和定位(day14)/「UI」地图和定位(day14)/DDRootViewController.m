//
//  DDRootViewController.m
//  「UI」地图和定位(day14)
//
//  Created by 萧川 on 14-2-25.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "DDRootViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "DDDetailViewController.h"

@interface DDRootViewController () <CLLocationManagerDelegate, MKMapViewDelegate> {
    
    CLLocationManager *_locationManager; // 定位功能管理类
    MKMapView *_mapView;
}

- (void)initUserInterface;
- (void)initLoactionService;
- (void)initMapView;
- (void)refreshUserInterfaceWithLocation:(CLLocation *)location;
- (void)showCurrentLocation;

// 详细信息(地理位置逆编码)
- (void)currentLocationDeatilInformation;
// 长按手势识别
- (void)processLongPressGesture:(UILongPressGestureRecognizer *)longPress;
// 地理位置逆编码
- (void)reverseGeocodeWithLocation:(CLLocation *)location completionHandler:(void (^)(BOOL success, id content))completion;

@end

@implementation DDRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"MapView";
    }
    return self;
}

- (void)dealloc
{
    _locationManager = nil;
    _mapView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUserInterface];
    [self initLoactionService];
    [self initMapView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
}

#pragma mark - 私有方法

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *location = [[UIBarButtonItem alloc] initWithTitle:@"定位"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(barButtonPressed:)];
    location.tag = kLocaltionTag;
    self.navigationItem.leftBarButtonItem = location;
    
    UIBarButtonItem *detail = [[UIBarButtonItem alloc] initWithTitle:@"详细信息"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(barButtonPressed:)];
    detail.tag = kDetailTag;
    self.navigationItem.rightBarButtonItem = detail;
    
    NSArray *items = @[@"标准", @"卫星", @"混合"];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:items];
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self
                action:@selector(toggleType:)
      forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *segmentItem = [[UIBarButtonItem alloc] initWithCustomView:segment];
    UIBarButtonItem *FlexibleSpace = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil
                                      action:NULL];
    self.toolbarItems = @[FlexibleSpace, segmentItem, FlexibleSpace];
}

- (void)initMapView
{
    _mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    _mapView.delegate = self; // 委托
    _mapView.showsUserLocation = YES; // 是否显示当前位置
    _mapView.mapType = MKMapTypeStandard; // 风格
    [self.view addSubview:_mapView];
    // 添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(processLongPressGesture:)];
    // 触发长按手势需要的最短时间
    longPress.minimumPressDuration = 1.0f;
    [_mapView addGestureRecognizer:longPress];
}

- (void)processLongPressGesture:(UILongPressGestureRecognizer *)longPress
{
    // 手势开始时
    if (longPress.state == UIGestureRecognizerStateBegan) {
        // 获取长按手势在视图中的坐标点
        CGPoint point = [longPress locationInView:_mapView];
        // 把视图坐标系转化为经纬度坐标系
        CLLocationCoordinate2D coordinate = [_mapView convertPoint:point toCoordinateFromView:_mapView];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude
                                                          longitude:coordinate.longitude];
        
        [self reverseGeocodeWithLocation:location completionHandler:^(BOOL success, id content) {
            if (success) {
                // 初始化标注数据源
                MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                annotation.coordinate = coordinate;
                annotation.title = content[@"Name"];
                annotation.subtitle = [NSString stringWithFormat:@"%.2f, %.2f",
                                       coordinate.latitude, coordinate.longitude];
                [_mapView addAnnotation:annotation];
            }
            else {
                NSLog(@"%@", content);
            }
        }];
    }
}

- (void)refreshUserInterfaceWithLocation:(CLLocation *)location
{
    if (!location){
        return;
    }
    // MKCoordinateRegion表示地图显示位置和区域以及大小的结构体
    // MKCoordinateSpan表示地图显示区域大小
    [_mapView setRegion:MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.05, 0.05))
               animated:YES];
    // 更新用户当前位置标注
    _mapView.userLocation.title = @"当前位置";
    _mapView.userLocation.subtitle = [NSString stringWithFormat:@"%.2f, %.2f",
                                      location.coordinate.latitude,location.coordinate.longitude];
    _mapView.showsUserLocation = YES;
}

- (void)showCurrentLocation
{
    [_locationManager startUpdatingLocation];
}

- (void)currentLocationDeatilInformation
{
    // 获取用户当前位置
    CLLocation *currentLoaction = [_locationManager location];
    [self reverseGeocodeWithLocation:currentLoaction completionHandler:^(BOOL success, id content) {
        if (success) {
            DDDetailViewController *detail = [[DDDetailViewController alloc] initWithDataSource:content];
            [self.navigationController pushViewController:detail animated:YES];
        }
    }];
}

- (void)reverseGeocodeWithLocation:(CLLocation *)location completionHandler:(void (^)(BOOL, id))completion
{
    if (!location) {
        return;
    }
    
    // 地理位置逆编码
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    // 逆编码非常耗时，系统默认在后台执行
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (completion) {
            if (!error) {
                // 获取地理位置详情
                CLPlacemark *mark = [placemarks lastObject];
                completion(YES, mark.addressDictionary);
            } else {
                completion(NO, [error localizedDescription]);
            }
        }
    }];
}

#pragma mark - Button items methods

- (void)barButtonPressed:(UIBarButtonItem *)sender
{
    NSInteger index = sender.tag;
    if (index == kLocaltionTag) {
        [self showCurrentLocation];
    } else {
        [self currentLocationDeatilInformation];
    }
}

- (void)toggleType:(UISegmentedControl *)sender
{
    _mapView.mapType = sender.selectedSegmentIndex;
}

#pragma mark - 初始化定位服务

- (void)initLoactionService
{
    // 判断服务是否打开
    if (![CLLocationManager locationServicesEnabled]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"定位失败，定位功能不可用或者未打开"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    _locationManager = [[CLLocationManager alloc] init]; // 初始化定位
    _locationManager.delegate = self; // 设置委托
    _locationManager.distanceFilter = kCLDistanceFilterNone; // 位置过滤
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 定位精度
    [_locationManager startUpdatingLocation]; // 开始定位
}

#pragma mark - <CLLocationManagerDelegate>

// 定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currentLoaction = [locations lastObject]; // 当前位置在locations数组末尾
    NSLog(@"currentLoaction = %@", currentLoaction);
    // 刷新显示
    [self refreshUserInterfaceWithLocation:currentLoaction];
    // 停止定位，定位非常消耗电量
    [manager stopUpdatingLocation];
}

// 定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Location manager locate did failed with error message: %@", [error localizedDescription]);
}

#pragma mark - <MKMapViewDelegate>

// 初始化标注视图
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    // 避免用户当前位置被替换
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *identifier = @"PinAnnotation";
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView) {
        // 创建大头针标注
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                         reuseIdentifier:identifier];
        // 大头针颜色
        [(MKPinAnnotationView *)annotationView setPinColor:MKPinAnnotationColorPurple];
        // 是否需要坠落动画
        [(MKPinAnnotationView *)annotationView setAnimatesDrop:YES];
        // 是否支持附件展开
        [(MKPinAnnotationView *)annotationView setCanShowCallout:YES];
        // 配置附件视图
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        button.bounds = CGRectMake(0, 0, 20, 20);
        [(MKPinAnnotationView *)annotationView setRightCalloutAccessoryView:button];
    }
    
    annotationView.annotation = annotation;
    
    return annotationView;
}

// 标注视图详细信息
- (void)mapView:(MKMapView *)mapView
    annotationView:(MKAnnotationView *)view
    calloutAccessoryControlTapped:(UIControl *)control
{
    CLLocationCoordinate2D coordinate = [view.annotation coordinate];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude
                                                      longitude:coordinate.longitude];
    [self reverseGeocodeWithLocation:location completionHandler:^(BOOL success, id content) {
        if (success) {
            DDDetailViewController *deatilVC = [[DDDetailViewController alloc] initWithDataSource:content];
            [self.navigationController pushViewController:deatilVC animated:YES];
        }
    }];
}

@end
