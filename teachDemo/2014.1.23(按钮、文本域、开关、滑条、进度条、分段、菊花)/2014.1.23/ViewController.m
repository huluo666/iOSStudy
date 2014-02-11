//
//  ViewController.m
//  2014.1.23
//
//  Created by 张鹏 on 14-1-23.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

- (void)initializeUserInterface;

- (void)buttonPressed:(UIButton *)sender;

- (CGSize)sizeWithString:(NSString *)string
                    font:(UIFont *)font
          constraintSize:(CGSize)constraintSize;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeUserInterface];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeSystem];
    nextButton.bounds = CGRectMake(0, 0, 80, 30);
    nextButton.center = CGPointMake(CGRectGetMaxX(self.view.bounds) - 20 - CGRectGetMidX(nextButton.bounds), CGRectGetMinY(self.view.bounds) + 20 + CGRectGetMidY(nextButton.bounds));
    [nextButton setTitle:@"下一页" forState:UIControlStateNormal];
    [nextButton addTarget:self
                   action:@selector(buttonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    nextButton.tag = 10;
    [self.view addSubview:nextButton];
    
    // 关灯按钮
    UIButton *lightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    // buttonWithType: 指定按钮类型、无需手动管理内存
    // initWithFrame: UIButtonTypeCustom、指定按钮大小位置
    lightButton.bounds = CGRectMake(0, 0, 40, 40);
    lightButton.center = CGPointMake(40, 40);
    // 设置标题文字
//    [lightButton setTitle:@"on" forState:UIControlStateNormal];
//    [lightButton setTitle:@"off" forState:UIControlStateHighlighted];
    // 设置标题文字颜色
//    [lightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [lightButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    // 设置按钮图片，title和image只能存在一个
//    [lightButton setImage:[UIImage imageNamed:@"开灯.png"]
//                 forState:UIControlStateNormal];
//    [lightButton setImage:[UIImage imageNamed:@"关灯.png"]
//                 forState:UIControlStateHighlighted];
    
    // 设置普通状态背景图
    [lightButton setBackgroundImage:[UIImage imageNamed:@"开灯.png"]
                           forState:UIControlStateNormal];
    // 设置高亮状态背景图
    [lightButton setBackgroundImage:[UIImage imageNamed:@"关灯.png"]
                           forState:UIControlStateHighlighted];
    // 设置选中状态背景图
    [lightButton setBackgroundImage:[UIImage imageNamed:@"关灯.png"]
                           forState:UIControlStateSelected];
    
    [lightButton addTarget:self
                    action:@selector(buttonPressed:)
          forControlEvents:UIControlEventTouchUpInside];
    lightButton.tag = 11;
    
    // 设置控件是否启用
//    lightButton.enabled = NO;
    [self.view addSubview:lightButton];
    
    NSString *string = @"乔布斯是改变世界的天才，他凭敏锐的触觉和过人的智慧，勇于变革，不断创新，引领全球资讯科技和电子产品的潮流，把电脑和电子产品不断变得简约化、平民化，让曾经是昂贵稀罕的电子产品变为现代人生活的一部分。";
    
    // 标签
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 270, 150, 30)];
    // 设置显示的文本
    leftLabel.text = string;
    // 设置背景色
    leftLabel.backgroundColor = [UIColor clearColor];
    // 设置文本对齐
    leftLabel.textAlignment = NSTextAlignmentLeft;
    // 设置字体
    leftLabel.font = [UIFont systemFontOfSize:15];
    
    // 获取系统字体名称列表
//    NSArray *fontList = [UIFont familyNames];
//    NSLog(@"%@", fontList);
    
    // 设置文本色
    leftLabel.textColor = [UIColor blackColor];
    leftLabel.tag = 12;
    [self.view addSubview:leftLabel];
    [leftLabel release];
    
    
    CGSize size = [self sizeWithString:string
                                  font:[UIFont systemFontOfSize:15]
                        constraintSize:CGSizeMake(150, 568)];
    
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(165, 270, size.width, size.height)];
    // 设置显示的文本
    rightLabel.text = string;
    // 设置背景色
    rightLabel.backgroundColor = [UIColor clearColor];
    // 设置文本对齐
    rightLabel.textAlignment = NSTextAlignmentLeft;
    // 设置字体
    rightLabel.font = [UIFont systemFontOfSize:15];
    // 设置文本色
    rightLabel.textColor = [UIColor blackColor];
    // 配置文本显示行数，0表示不限制
    rightLabel.numberOfLines = 0;
    // 设置换行模式
    rightLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    rightLabel.tag = 13;
    [self.view addSubview:rightLabel];
    [rightLabel release];
    
    
    // UITextField
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(60, 150, 200, 25)];
    // 设置边框类型
    textField.borderStyle = UITextBorderStyleRoundedRect;
    // 设置占位符
    textField.placeholder = @"请输入文本...";
    // 设置字体类型
    textField.font = [UIFont systemFontOfSize:15];
    // 设置自动更正方案
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    // 设置自动大写方案
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    // 设置主色调
    textField.tintColor = [UIColor redColor];
    // 设置键盘类型
    textField.keyboardType = UIKeyboardTypeDefault;
    // 设置返回，确认键类型
    textField.returnKeyType = UIReturnKeyDone;
    // 设置清除按钮模式
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    // 设置委托
    textField.delegate = self;
    textField.secureTextEntry = YES;
    
    [self.view addSubview:textField];
    [textField release];
}

- (void)buttonPressed:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    // 下一页
    if (tag == 10) {
        DetailViewController *detailVC = [[DetailViewController alloc] init];
        [self presentViewController:detailVC animated:YES completion:nil];
        [detailVC release];
    }
    // 开关灯
    else {
        // 设置按钮是否选中
        sender.selected = !sender.selected;
        self.view.backgroundColor = sender.selected ? [UIColor blackColor] : [UIColor whiteColor];
    }
}

- (CGSize)sizeWithString:(NSString *)string
                    font:(UIFont *)font
          constraintSize:(CGSize)constraintSize {
    
    // 获取文本内容所占空间大小
    // iOS 7 之前：
    //    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:15]
    //                     constrainedToSize:CGSizeMake(150, 568)
    //                         lineBreakMode:NSLineBreakByWordWrapping];
    
    // iOS 7：
    CGRect rect = [string boundingRectWithSize:constraintSize
                                       options:NSStringDrawingTruncatesLastVisibleLine |
                                               NSStringDrawingUsesFontLeading |
                                               NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName: font}
                                       context:nil];
    CGSize size = CGSizeMake(CGRectGetWidth(rect), CGRectGetHeight(rect));
    
    return size;
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
//    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    // 关闭键盘：
    // 方法1:
//    [textField resignFirstResponder];
    // 方法2:
    [self.view endEditing:YES];
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
//    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
//    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
//    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
//    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    UILabel *leftLabel  = (UILabel *)[self.view viewWithTag:12];
    UILabel *rightLabel = (UILabel *)[self.view viewWithTag:13];
    NSString *text = textField.text;
    if (text && text.length > 0) {
        leftLabel.text  = text;
        rightLabel.text = text;
        
        CGSize size = [self sizeWithString:text
                                      font:[UIFont systemFontOfSize:15]
                            constraintSize:CGSizeMake(150, 568)];
        CGRect frame = rightLabel.frame;
        frame.size = size;
        rightLabel.frame = frame;
        textField.text  = nil;
    }
}

#define NUMBER_SET @"1234567890"

// 1:限制长度
// 2:过滤输入
- (BOOL)textField:(UITextField *)textField
        shouldChangeCharactersInRange:(NSRange)range
        replacementString:(NSString *)string {
    
    NSLog(@"rang lcoation:%u  length:%u  string:%@", range.location, range.length, string);
    
    if (range.location >= 10) {
        return NO;
    }
    
    if ([NUMBER_SET rangeOfString:string].location != NSNotFound) {
        return NO;
    }
    return YES;
}

@end












