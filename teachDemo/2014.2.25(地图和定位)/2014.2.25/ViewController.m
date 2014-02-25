//
//  ViewController.m
//  2014.2.25
//
//  Created by 张鹏 on 14-2-25.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#define BUTTON_TAG 10

@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate> {
    
    CLLocationManager *_locationManager; // 定位功能管理类
    MKMapView *_mapView;
}

- (void)initializeUserInterface;
- (void)initializeLocationService;

- (void)updateUserInterfaceWithLocation:(CLLocation *)location;

- (void)barButtonPressed:(UIBarButtonItem *)sender;
- (void)showCurrentLocation;
// 获取用户当前位置详细信息（地理位置逆编码）
- (void)showCurrentLocationDetailInformation;

- (void)processControl:(UISegmentedControl *)sender;
- (void)processLongPressGesture:(UILongPressGestureRecognizer *)longPress;

// 地理位置逆编码
- (void)reverseGeocodeWithLocation:(CLLocation *)location
                 completionHandler:(void (^)(BOOL success, id content))completion;

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = @"MapView";
        
    }
    return self;
}

- (void)dealloc {
    
    [_locationManager release];
    [_mapView         release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeUserInterface];
    [self initializeLocationService];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.toolbarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.toolbarHidden = YES;
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    // 定位
    UIBarButtonItem *showCurrentLocationItem = [[UIBarButtonItem alloc]
                                                initWithTitle:@"定位"
                                                style:UIBarButtonItemStylePlain
                                                target:self
                                                action:@selector(barButtonPressed:)];
    showCurrentLocationItem.tag = BUTTON_TAG;
    self.navigationItem.leftBarButtonItem = showCurrentLocationItem;
    [showCurrentLocationItem release];
    
    
    // 详细信息
    UIBarButtonItem *showDetailInformationItem = [[UIBarButtonItem alloc]
                                                  initWithTitle:@"详细信息"
                                                  style:UIBarButtonItemStylePlain
                                                  target:self
                                                  action:@selector(barButtonPressed:)];
    showDetailInformationItem.tag = BUTTON_TAG + 1;
    self.navigationItem.rightBarButtonItem = showDetailInformationItem;
    [showDetailInformationItem release];
    
    
    // 切换地图显示类型
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"标准", @"卫星", @"混合"]];
    segmentedControl.bounds = CGRectMake(0, 0, 200, 25);
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self
                         action:@selector(processControl:)
               forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *segmentedItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
    [segmentedControl release];
    
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc]
                                     initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                     target:nil
                                     action:NULL];
    
    self.toolbarItems = @[flexibleItem, segmentedItem, flexibleItem];
    [flexibleItem  release];
    [segmentedItem release];
    
    
    // 初始化地图界面
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    // 配置委托对象
    _mapView.delegate = self;
    // 配置是否显示用户当前位置
    _mapView.showsUserLocation = YES;
    // 配置地图显示风格
    _mapView.mapType = MKMapTypeStandard;
    [self.view addSubview:_mapView];
    
    
    // 添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(processLongPressGesture:)];
    // 触发长按手势需要的最短时间
    longPress.minimumPressDuration = 1.0;
    [_mapView addGestureRecognizer:longPress];
    [longPress release];
}

- (void)initializeLocationService {
    
    // 判断定位功能是否可用
    if (![CLLocationManager locationServicesEnabled]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"定位失败，定位功能未开启！"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return;
    }
    // 初始化定位
    _locationManager = [[CLLocationManager alloc] init];
    // 配置委托
    _locationManager.delegate = self;
    // 配置位置过滤
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    // 配置定位精度
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // 开始定位
    [_locationManager startUpdatingLocation];
}

- (void)updateUserInterfaceWithLocation:(CLLocation *)location {
    
    // 为空判断
    if (!location) {
        return;
    }
    // MKCoordinateRegion:表示地图显示位置及大小区域的结构体
    // MKCoordinateSpan:表示地图显示区域大小
    [_mapView setRegion:MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.05, 0.05))
               animated:YES];
    
    // 更新用户当前位置标注
    _mapView.userLocation.title = @"当前位置";
    _mapView.userLocation.subtitle = [NSString stringWithFormat:@"%.2f, %.2f",
                                      location.coordinate.latitude,
                                      location.coordinate.longitude];
}

#pragma mark - Button function methods

- (void)barButtonPressed:(UIBarButtonItem *)sender {
    
    NSInteger index = sender.tag - BUTTON_TAG;
    // 定位
    if (index == 0) {
        [self showCurrentLocation];
    }
    // 详细信息
    else {
        [self showCurrentLocationDetailInformation];
    }
}

- (void)showCurrentLocation {
    
    [_locationManager startUpdatingLocation];
}

- (void)showCurrentLocationDetailInformation {
    
    // 获取用户当前位置
    CLLocation *currentLocation = _locationManager.location;
    [self reverseGeocodeWithLocation:currentLocation completionHandler:^(BOOL success, id content) {
        if (success) {
            DetailViewController *detailVC = [[DetailViewController alloc] initWithAddressDictionary:content];
            [self.navigationController pushViewController:detailVC animated:YES];
            [detailVC release];
        }
    }];
}

- (void)processControl:(UISegmentedControl *)sender {
    
    _mapView.mapType = sender.selectedSegmentIndex;
}

- (void)processLongPressGesture:(UILongPressGestureRecognizer *)longPress {
    
    // 手势开始时
    if (longPress.state == UIGestureRecognizerStateBegan) {
        // 获取长按手势在视图中的坐标点
        CGPoint point = [longPress locationInView:_mapView];
        // 把视图坐标系转化为经纬度坐标系
        CLLocationCoordinate2D coordinate = [_mapView convertPoint:point toCoordinateFromView:_mapView];
        CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude
                                                          longitude:coordinate.longitude];
        // 逆编码
        [self reverseGeocodeWithLocation:location completionHandler:^(BOOL success, id content) {
            if (success) {
                // 初始化标注数据源
                MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                annotation.coordinate = coordinate;
                annotation.title = content[@"Name"];
                annotation.subtitle = [NSString stringWithFormat:@"%.2f, %.2f", coordinate.latitude, coordinate.longitude];
                // 添加标注到地图之上
                [_mapView addAnnotation:annotation];
                [annotation release];
            }
        }];
        [location release];
    }
}

- (void)reverseGeocodeWithLocation:(CLLocation *)location
                 completionHandler:(void (^)(BOOL, id))completion {

    if (!location) {
        return;
    }
    // 地理位置逆编码
    CLGeocoder *coder = [[CLGeocoder alloc] init];
    // 逆编码操作是非常耗时的操作，系统默认在后台线程执行
    [coder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (completion) {
            // 若逆编码成功
            if (!error) {
                // 获取地理位置详情
                CLPlacemark *placemark = [placemarks lastObject];
                NSLog(@"%@", placemark.addressDictionary);
                completion(YES, placemark.addressDictionary);
            }
            else {
                completion(NO, [error localizedDescription]);
            }
        }
    }];
    [coder release];
}

#pragma mark - <CLLocationManagerDelegate>

// 定位成功返回位置信息
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    // 当前位置在locations数组末尾
    CLLocation *currentLocation = [locations lastObject];
    // 刷新地图显示
    [self updateUserInterfaceWithLocation:currentLocation];
    // 及时停止定位功能（定位功能相当消耗设备电量）
    [manager stopUpdatingLocation];
}

// 定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"Location manager locate did failed with error message '%@'.", [error localizedDescription]);
}

#pragma mark - <MKMapViewDelegate>

// 初始化标注视图
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    // 避免用户当前位置标注被替换
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *identifier = @"PinAnnotation";
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView) {
        // 创建大头针标注
        annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:identifier] autorelease];
        // 配置大头针颜色
        [(MKPinAnnotationView *)annotationView setPinColor:MKPinAnnotationColorPurple];
        // 配置是否需要坠落动画
        [(MKPinAnnotationView *)annotationView setAnimatesDrop:YES];
        // 配置是否支持附件展开
        [(MKPinAnnotationView *)annotationView setCanShowCallout:YES];
        // 配置附件视图
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        button.bounds = CGRectMake(0, 0, 20, 20);
        [(MKPinAnnotationView *)annotationView setRightCalloutAccessoryView:button];
    }
    annotationView.annotation = annotation;
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView
        annotationView:(MKAnnotationView *)view
        calloutAccessoryControlTapped:(UIControl *)control {
    
    CLLocationCoordinate2D coordinate = [view.annotation coordinate];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude
                                                      longitude:coordinate.longitude];
    [self reverseGeocodeWithLocation:location completionHandler:^(BOOL success, id content) {
        if (success) {
            DetailViewController *detailVC = [[DetailViewController alloc] initWithAddressDictionary:content];
            [self.navigationController pushViewController:detailVC animated:YES];
            [detailVC release];
        }
    }];
    [location release];
}

@end























