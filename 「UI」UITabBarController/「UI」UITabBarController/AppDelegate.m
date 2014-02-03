//
//  AppDelegate.m
//  「UI」UITabBarController
//
//  Created by cuan on 14-1-30.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
#import "ViewController5.h"
#import "ViewController6.h"

#define SELECTED_TABBARITEM_KEY @"selected"
#define SORTED_TITLES_KEY @"titles"
#define SORTED_VIEWCONTROLLS_KEY @"sortedArray"

@interface AppDelegate ()

@property (assign, nonatomic) BOOL isChanged;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
 
#pragma mark 由于没有图片素材，所有图片项设置为nil
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController1 *vc1 = [[ViewController1 alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc1];
    [vc1 release];
    
//    navigationController.navigationItem.title = @"界面一";
//    navigationController.tabBarItem.title = @"界面一";
  
#pragma mark 初始化ViewController

    // 相当于对tabBarItem.title和navigationItem.title同时赋值
    navigationController.title = @"界面一" ;
    navigationController.tabBarItem.image = [UIImage imageNamed:nil];
    
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    vc2.title = @"界面二";
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:nil];
    vc2.tabBarItem.image = [UIImage imageNamed:nil];
    
    ViewController3 *vc3 = [[ViewController3 alloc] init];
    vc3.title = @"界面三";
    vc3.tabBarItem.image = [UIImage imageNamed:nil];
    
    ViewController4 *vc4 = [[ViewController4 alloc] init];
    vc4.title = @"界面四";
    vc4.tabBarItem.image = [UIImage imageNamed:nil];
    vc4.tabBarItem.badgeValue = @"5"; // 设置徽标
    
    ViewController5 *vc5 = [[ViewController5 alloc] init];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFavorites tag:100];
    vc5.title = @"界面五";
    vc5.tabBarItem = item1; //通过系统样式设置tabBar样式
    // 通过系统样式设置tabBar样式后，再通过属性设置title、image无效(无法显示，但是可以取到值)
    vc5.tabBarItem.title = @"界面五";
    vc5.tabBarItem.image = [UIImage imageNamed:nil];
    [item1 release];
    
    /*
    ViewController6 *vc6 = [[ViewController6 alloc] init];
//    vc6.title = @"界面六"; // 这种方式设置title会造成tabBar消失....
    // 通过这种方式初始化，等同于直接为tabBarItem.title、tabBarItem.image赋值。一般不用这种方式
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"界面六" image:[UIImage imageNamed:nil] selectedImage:[UIImage     imageNamed:nil]];
    vc6.tabBarItem = item2;
    [item2 release];
     */
    ViewController6 *vc6 = [[ViewController6 alloc] init];
    vc6.title = @"界面六";
    vc6.tabBarItem.image = [UIImage imageNamed:nil];
    
#pragma mark 将各个ViewController加载到UITabBarController中管理
    
    NSArray *controllers = @[navigationController, vc2, vc3, vc4, vc5, vc6];
    [navigationController release];
    [vc2 release];
    [vc3 release];
    [vc4 release];
    [vc5 release];
    [vc6 release];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = controllers;
    
#pragma mark 对tabBar进行定制显示效果
    
    // items, selectedItem属性由tabBarController来管理，不能对其进行外部赋值
//    tabBarController.tabBar.items = @[vc1.tabBarItem, vc2.tabBarItem, vc3.tabBarItem]; // invalid, crack
//    tabBarController.tabBar.selectedItem = vc2.tabBarItem; // invalid, crack
    
    // 不能通过对backgroundColor赋值来改变标签栏颜色
//    tabBarController.tabBar.backgroundColor = [UIColor redColor]; // invalid
    
    // 改变tabBar色调
    tabBarController.tabBar.tintColor = [UIColor blueColor]; // 文字颜色
//    tabBarController.tabBar.barTintColor = [UIColor colorWithRed:0.479 green:0.500 blue:0.243 alpha:1.000]; // bar颜色
    
    // 改变taBbar背景图片
//    tabBarController.tabBar.backgroundImage = [UIImage imageNamed:nil];
    tabBarController.tabBar.selectedImageTintColor = [UIColor redColor];
    tabBarController.tabBar.selectionIndicatorImage = [UIImage imageNamed:nil]; // tabBar选中后的指示图片
    
    // 将appDelegate作为tabBarController的代理(委托对象)
    tabBarController.delegate = self;
    
    // 设置第几个tabBarItem处于选中状态, 默认值是0
//    tabBarController.selectedIndex = 1;
    
    // 通过指定视图控制器的方式来指定选中的tabBarItem
//    tabBarController.selectedViewController = vc3;

#pragma mark 对tabBarItem进行操作
    
    // 记录上次选中的tabBarItem
    NSString *viewControllerTitle = [[NSUserDefaults standardUserDefaults] objectForKey:SELECTED_TABBARITEM_KEY];
    if (viewControllerTitle)
    {
        for (UIViewController *vc in controllers)
        {
            if ([vc.title isEqualToString:viewControllerTitle])
            {
                tabBarController.selectedViewController = vc;
            }
        }
    }
    
    // 记录标签栏视图控制器编辑后的顺序
    NSArray *titles = [[NSUserDefaults standardUserDefaults] objectForKey:SORTED_TITLES_KEY];
    if (titles)
    {
        NSMutableArray *newViewControllers = [[NSMutableArray alloc] init];
        for (NSString *title in titles)
        {
            for (UIViewController *vc in controllers)
            {
                if ([vc.title isEqualToString:title])
                {
                    [newViewControllers addObject:vc];
                }
            }
        }
        
        tabBarController.viewControllers = newViewControllers;
        [newViewControllers release];
    }
    
    
//    if (_isChanged)
//    {
//        tabBarController.viewControllers = [[NSUserDefaults standardUserDefaults] objectForKey:SORTED_VIEWCONTROLLS_KEY];
//    }
    
    self.window.rootViewController = tabBarController;
    [tabBarController release];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    // **********************************************************************
    //          THELL　ME WHY ?
    // **********************************************************************//
    
//    NSLog(@"---------------------------");
//    NSArray *array = @[vc1, vc2, vc3];
//    NSUserDefaults *userDeafult = [NSUserDefaults standardUserDefaults];
//    [userDeafult setObject:array forKey:@"test"];
//    [userDeafult synchronize];
//    NSLog(@"%@", [userDeafult objectForKey:@"test"]);
    
    
    // 字典可以存储....
//    NSArray *array = @[vc1, vc2, vc3];
////    NSDictionary *dict = @{@"test":array}; // valid
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    [dict setObject:array forKey:@"test"];
//    NSLog(@"%@", [dict objectForKey:@"test"]);

    
    
    return YES;
}

#pragma mark - <UITabBarControllerDelegate>

// 是否允许选择不同的item触发后续操作
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    return YES;
}

// 每次点击tabBarItem后触发该方法
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (viewController.title)
    {
        [userDefaults setObject:viewController.title forKey:SELECTED_TABBARITEM_KEY];
        [userDefaults synchronize];
    }
}

// 当点击moreNavigationController的Edit按钮的时候触发
- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

// 当点击Done按钮时触发该方法
// changed 标记各个viewController的顺序是否改变
// viewControllers返回最新的tabBarController中的viewControllers数组
- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    if (changed)
    {
        NSLog(@"chagned");
        
        NSMutableArray *titles = [[NSMutableArray alloc] init];
        for (UIViewController *vc in viewControllers)
        {
            NSString *title = vc.title;
            NSLog(@"title = %@", title);
            [titles addObject:title];
        }
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:titles forKey:SORTED_TITLES_KEY];
        [titles release];
        [userDefaults synchronize];
         
        
        // 通过上面我发现存title问题多多，为什么不直接存已经排序的viewControllers数组？？？
//        NSUserDefaults *userDefauts = [NSUserDefaults standardUserDefaults];
////        [userDefauts setObject:viewControllers forKey:SORTED_VIEWCONTROLLS_KEY];
//        [userDefauts setValue:viewControllers forKey:SORTED_VIEWCONTROLLS_KEY];   // 发现NSUserDefaults不能够存储UIViewController实例,tell me why?
//        [userDefauts synchronize];
//        _isChanged = YES;
//        NSLog(@"%@", viewControllers);
    }
    else
    {
        NSLog(@"not changed");
    }
    
    NSLog(@"%@", viewControllers);
}

@end
