//
//  HomePageViewController.m
//  「UI」UITest
//
//  Created by 萧川 on 14-2-20.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "HomePageViewController.h"
#import "LoginViewController.h"
#import "AudioPlayer.h"

@interface HomePageViewController () <UIScrollViewDelegate>

@property (retain, nonatomic) UIScrollView *adScrollView;
@property (retain, nonatomic) UIScrollView *introduceScrollView;
@property (assign, nonatomic) NSInteger currentPageIndex;
@property (retain, nonatomic) NSMutableArray *imageNameList;
@property (retain, nonatomic) NSMutableArray *imageViewList;

// 加载数据源
- (void)loadDataSource;

// 初始化用户界面
- (void)initUserInterface;

// 加载广告栏
- (void)loadAdScrollView;
// 设置自动播放
- (void)autoPlay;
// 获取实际的图片索引
- (NSInteger)realIndexWithIndex:(NSInteger)index;
// 更新图片显示
- (void)updateUserInterfaceWithScrollViewContentOffset:(CGPoint)contentOffset;

// 加载介绍视图
- (void)loadIntroduceScrollView;
// 根据文本内容多少获取内容尺寸
- (CGSize)sizeWithString:(NSString *)string
                    font:(UIFont *)font
          constraintSize:(CGSize)constraintSize;

// 加载图片
- (CGFloat)addPicWihtName:(NSString *)picName yCoordinate:(CGFloat)yCoor;
// 加载文本
- (CGFloat)addTextViewWith:(NSString *)content yCoordinate:(CGFloat)yCoor;

@end

@implementation HomePageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
         UITabBarItem *tabBarItem = [[UITabBarItem alloc]
                                     initWithTitle:@"主页"
                                     image:[UIImage imageNamed:@"item1"]
                                     tag:11];
        self.tabBarItem = tabBarItem;
        [tabBarItem release];
    }
    return self;
}

- (void)dealloc
{
    [_adScrollView release];
    [_introduceScrollView release];
    [_imageViewList release];
    [_imageViewList release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	[self loadDataSource];
    [self initUserInterface];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    _logined = YES;
    if (!_logined) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
        [loginVC release];
        
        self.title = @"首页";
    }
}

#pragma mark - 私有方法

- (void)loadDataSource
{
    _imageNameList = [[NSMutableArray alloc] init];
    for (int i = 0; i < 6; i++) {
        NSString *imageName = [NSString stringWithFormat:@"adv%d.png", i + 1];
        [_imageNameList addObject:imageName];
    }
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadAdScrollView];
    [self loadIntroduceScrollView];
}

- (void)loadAdScrollView
{
    _adScrollView = [[UIScrollView alloc] init];
    _adScrollView.frame = CGRectMake(0, 20, 320, 160);
    self.automaticallyAdjustsScrollViewInsets = NO;
    _adScrollView.contentSize = CGSizeMake(CGRectGetWidth(_adScrollView.frame) * 3,
                                         CGRectGetHeight(_adScrollView.frame));
    _adScrollView.contentOffset = CGPointMake(CGRectGetWidth(_adScrollView.frame), 0);
    _adScrollView.showsHorizontalScrollIndicator = NO;
    _adScrollView.showsVerticalScrollIndicator = NO;
    
    _currentPageIndex = 0;
    
    _imageViewList = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                                  CGRectMake(CGRectGetWidth(
                                    _adScrollView.frame) * i,
                                    0,
                                    CGRectGetWidth(_adScrollView.frame),
                                    CGRectGetHeight(_adScrollView.frame))];
        NSInteger index  = [self realIndexWithIndex:_currentPageIndex + i - 1];
        NSString *path = [[NSBundle mainBundle]
                          pathForAuxiliaryExecutable:_imageNameList[index]];
        imageView.image = [UIImage imageWithContentsOfFile:path];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_adScrollView addSubview:imageView];
        [_imageViewList addObject:imageView];
        [imageView release];
    }
    [self.view addSubview:_adScrollView];
    [self performSelector:@selector(autoPlay) withObject:nil afterDelay:1.5f];
}

- (void)autoPlay
{
    double index = _adScrollView.contentOffset.x  + 320;
    
    if (index == 320 * 8) {
        index = 0;
    }
    [_adScrollView setContentOffset:CGPointMake(index, 0) animated:YES];
    [self updateUserInterfaceWithScrollViewContentOffset:_adScrollView.contentOffset];
    [self performSelector:_cmd withObject:nil afterDelay:1.0f];
}

- (NSInteger)realIndexWithIndex:(NSInteger)index
{
    NSInteger maximumIndex = [_imageNameList count] - 1;
    // 判断真实索引位置
    if (index > maximumIndex) {
        index = 0;
    } else if (index < 0) {
        index = maximumIndex;
    }
    return index;
}

- (void)updateUserInterfaceWithScrollViewContentOffset:(CGPoint)contentOffset
{
    BOOL shouldUpdate = NO;
    
    if (contentOffset.x >= CGRectGetWidth(_adScrollView.bounds) * 2) {
        shouldUpdate = YES;
        _currentPageIndex = [self realIndexWithIndex:++_currentPageIndex];
    } else if (contentOffset.x <= 0) {
        shouldUpdate = YES;
        _currentPageIndex = [self realIndexWithIndex:--_currentPageIndex];
    }
    
    if (!shouldUpdate) {
        return;
    }
    
    for (int i = 0; i < 3; i++) {
        NSInteger index  = [self realIndexWithIndex:_currentPageIndex + i - 1];
        NSString *path = [[NSBundle mainBundle]
                          pathForAuxiliaryExecutable:_imageNameList[index]];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        ((UIImageView *)_imageViewList[i]).image = image;
    }
    
    _adScrollView.contentOffset =
        CGPointMake(CGRectGetWidth(_adScrollView.bounds), 0);
}

- (void)loadIntroduceScrollView
{
    _introduceScrollView = [[UIScrollView alloc] init];
    _introduceScrollView.frame = CGRectMake(0,
                                            CGRectGetMaxY(_adScrollView.frame),
                                            320,
                                            568);
    _introduceScrollView.showsVerticalScrollIndicator = YES;
    _introduceScrollView.contentSize = CGSizeMake(320, 1200);
    [self.view addSubview:_introduceScrollView];
    
    CGFloat yCoor1 = [self addPicWihtName:@"text_pic1" yCoordinate:0];
    CGFloat yCoor2 = [self addTextViewWith:introduce_ONE yCoordinate:yCoor1];
    
    CGFloat yCoor3 = [self addPicWihtName:@"text_pic2" yCoordinate:yCoor2];
    CGFloat yCoor4 = [self addTextViewWith:introduce_TWO yCoordinate:yCoor3];
    
    CGFloat yCoor5 = [self addPicWihtName:@"text_pic3" yCoordinate:yCoor4];
    [self addTextViewWith:introduce_THREE yCoordinate:yCoor5];

}

- (CGFloat)addPicWihtName:(NSString *)picName yCoordinate:(CGFloat)yCoor
{
    UIImageView *imageView = [[UIImageView alloc]
                              initWithImage:[UIImage imageNamed:picName]];
    imageView.frame = CGRectMake(0, yCoor, 320, imageView.frame.size.height);
    [_introduceScrollView addSubview:imageView];
    return imageView.frame.origin.y + imageView.frame.size.height;
}

- (CGFloat)addTextViewWith:(NSString *)content yCoordinate:(CGFloat)yCoor
{
    CGSize maxSize = CGSizeMake(320, 2000);
    CGSize size = [self sizeWithString:content font:
                   [UIFont systemFontOfSize:12.0f] constraintSize:maxSize];
    UILabel *label        = [[UILabel alloc]
                             initWithFrame:CGRectMake(0, yCoor, 320, size.height)];
    label.text            = content;
    label.textAlignment   = NSTextAlignmentLeft;
    label.font            = [UIFont systemFontOfSize:15];
    label.textColor       = [UIColor grayColor];
    label.numberOfLines   = 0; //文本显示行数，0表示不限制
    label.lineBreakMode   = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    [_introduceScrollView addSubview:label];
    
    return label.frame.origin.y + size.height;
}


- (CGSize)sizeWithString:(NSString *)string
                    font:(UIFont *)font
          constraintSize:(CGSize)constraintSize
{
    CGRect rect = [string boundingRectWithSize:constraintSize
                                       options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesFontLeading |
                   NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                       context:nil];
    return rect.size;
}

@end
