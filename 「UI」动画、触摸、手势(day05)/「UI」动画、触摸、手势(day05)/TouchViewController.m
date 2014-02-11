//
//  TouchViewController.m
//  「UI」动画、触摸、手势(day05)
//
//  Created by cuan on 14-2-11.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "TouchViewController.h"
#import "GestureViewController.h"

@interface TouchViewController ()

@property (retain, nonatomic) UIImageView *imageView;

- (void)initUserInterface;
- (void)nextButtonPressed;
- (void)toggleAnimation;

@end

@implementation TouchViewController

- (void)dealloc
{
    [_imageView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)init
{
    if (self = [super init])
    {
        self.title =  @"UIView Touch";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUserInterface];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.toolbarHidden = YES;
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc]
                             initWithTitle:@"Next"
                             style:UIBarButtonItemStylePlain
                             target:self
                             action:@selector(nextButtonPressed)];
    self.navigationItem.rightBarButtonItem = next;
    [next release];
    
    UIBarButtonItem *toggleAnimationButton = [[UIBarButtonItem alloc] initWithTitle:@"Stop Animation" style:UIBarButtonItemStylePlain target:self action:@selector(toggleAnimation)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    self.toolbarItems = @[space, toggleAnimationButton, space];
    [toggleAnimationButton release];
    [space release];
    
#pragma mark  UIImageView

    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < IMAGES_COUNT; i++)
    {
        NSString *iamgeName = [NSString stringWithFormat:@"%d.png", i];
        
        // UIImage imageNamed: 把图片从文件系统加载到内存，保留在内存中，不自动释放
        
        // NSBundle:束，表示工程文件束，文件夹
        //        NSString *path = [[NSBundle mainBundle] pathForResource:iamgeName ofType:@"png"];
        NSString *path = [[NSBundle mainBundle] pathForAuxiliaryExecutable:iamgeName];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [images addObject:image];
    }
  
    // 根据传入图片的大小来指定UIImageView的大小
    _imageView = [[UIImageView alloc] init];
    _imageView.bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.frame) - 40, CGRectGetWidth(self.view.frame) - 40);
    _imageView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
//    _imageView.backgroundColor = [UIColor yellowColor];
//    // 内容布局模式
//    _imageView.contentMode = UIViewContentModeScaleAspectFill;
//    // 截取模式
//    _imageView.clipsToBounds = YES;
    
    _imageView.animationImages = images;
    [images release];
    _imageView.animationDuration = 5.0f;
    _imageView.animationRepeatCount = 0; // 0 无限次重复
    [_imageView startAnimating];
    
    // 开启用户交互
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
}

- (void)nextButtonPressed
{
    GestureViewController *gestureVC = [[GestureViewController alloc] init];
    [self.navigationController pushViewController:gestureVC animated:YES];
    [gestureVC release];
}

- (void)toggleAnimation
{
    UIBarButtonItem *toggleAnimationButton = self.toolbarItems[1];
    if ([_imageView isAnimating])
    {
        [_imageView stopAnimating];
        toggleAnimationButton.title = @"Start Animation";
        
    }
    else
    {
        [_imageView startAnimating];
        toggleAnimationButton.title = @"Stop Animation";
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    UITouch *touch = [touches anyObject];
    if (touch.view == _imageView) // 判断触摸产生的View是否为_imageView
    {
        CGPoint previousLoaction = [touch previousLocationInView:_imageView];
        CGPoint currentLocation  = [touch locationInView:_imageView];
        CGPoint offSet = CGPointMake(currentLocation.x - previousLoaction.x, currentLocation.y - previousLoaction.y);
        _imageView.center = CGPointMake(_imageView.center.x + offSet.x, _imageView.center.y + offSet.y);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
