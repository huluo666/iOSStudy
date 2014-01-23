//
//  ViewController.m
//  UIDemoDay03
//
//  Created by cuan on 14-1-23.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"

@interface ViewController ()

- (void)initializeUserInteface;
- (IBAction)buttonPressed:(UIButton *)sender;
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font constraintSize:(CGSize)constraintSize;
- (void)replaceTextStringToLabel;

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self initializeUserInteface];
}

#pragma mark - 监听事件处理方法

- (void)initializeUserInteface
{
    // 下一页按钮
    UIButton *nextPageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    nextPageButton.bounds    = CGRectMake(0, 0, 80, 50);
    nextPageButton.center    = CGPointMake(CGRectGetMaxX(self.view.bounds) - 30, CGRectGetMinY(self.view.bounds) + 40);
    nextPageButton.tag       = 11;
    [nextPageButton setTitle:@"下一页" forState:UIControlStateNormal];
    [nextPageButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextPageButton];
    
    // 切换灯按钮
    UIButton *lightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lightButton.bounds    = CGRectMake(0, 0, 30, 30);
    lightButton.center    = CGPointMake(CGRectGetMinX(self.view.bounds) + 30, CGRectGetMinY(self.view.bounds) + 35);

    lightButton.tag       = 12;
    
    [lightButton setTitle:@"on" forState:UIControlStateNormal];
    [lightButton setTitle:@"off" forState:UIControlStateHighlighted];
    
//    [lightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [lightButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [lightButton setImage:[UIImage imageNamed:@"开灯"] forState:UIControlStateNormal];
    [lightButton setImage:[UIImage imageNamed:@"关灯"] forState:UIControlStateHighlighted]; // 高亮状态
    [lightButton setImage:[UIImage imageNamed:@"关灯"] forState:UIControlStateSelected]; // 选中状态
    
    [lightButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lightButton];
    
    //左侧label
    NSString *string = @"乔布斯是改变世界的天才，他凭敏锐的触觉和过人的智慧，勇于变革，不断创新，引领全球资讯科技和电子产品的潮流，把电脑和电子产品不断变得简约化、平民化，让曾经是昂贵稀罕的电子产品变为现代人生活的一部分。";
    
    UILabel *leftLabel      = [[UILabel alloc] initWithFrame:CGRectMake(5, 250, 150, 30)];
    leftLabel.backgroundColor = [UIColor greenColor];
    leftLabel.tag = 13;
    leftLabel.text          = string;
    leftLabel.textAlignment = NSTextAlignmentLeft;
    leftLabel.font          = [UIFont systemFontOfSize:15];
    
    //获取系统字体列表
//    NSArray *fontList = [UIFont familyNames];
//    NSLog(@"%@", fontList);
    
    leftLabel.textColor = [UIColor blackColor];
    [self.view addSubview:leftLabel];
    [leftLabel release];
    
    // 右侧label
    // 获取文本内容所占空间大小
    // before IOS 7
//    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(150, 568) lineBreakMode:NSLineBreakByWordWrapping];
    
    // IOS 7
    CGSize size = [self sizeWithString:string font:[UIFont systemFontOfSize:15] constraintSize:CGSizeMake(150, 568)];
    
    UILabel *rightLabel      = [[UILabel alloc] initWithFrame:CGRectMake(165, 250, size.width, size.height)];
    rightLabel.backgroundColor = [UIColor greenColor];
    rightLabel.tag = 14;
    rightLabel.text          = string;
    rightLabel.textAlignment = NSTextAlignmentLeft;
    rightLabel.font          = [UIFont systemFontOfSize:15];
    rightLabel.textColor     = [UIColor grayColor];
    rightLabel.numberOfLines = 0; //文本显示行数，0表示不限制
    rightLabel.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail; // 单词换行|末尾"..."
    [self.view addSubview:rightLabel];
    [rightLabel release];
    
    // UITextField
    UITextField *textField           = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.view.frame) + 50, CGRectGetMinY(self.view.frame) + 150, 200, 25)];
    textField.tag = 15;
    textField.borderStyle            = UITextBorderStyleRoundedRect;
    textField.placeholder            = @"请输入文本....";
    textField.font                   = [UIFont systemFontOfSize:10];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;    // 自动大写
    textField.autocorrectionType     = UITextAutocorrectionTypeNo;          // 自动更正
    textField.tintColor              = [UIColor redColor];                  // 主色调
    textField.keyboardType           = UIKeyboardTypeDefault;               // 键盘类型
    textField.returnKeyType          = UIReturnKeyDone;                     // return键类型
    textField.clearButtonMode        = UITextFieldViewModeWhileEditing;     // 清除模式
    textField.delegate               = self;                                // 设置委托
    [self.view addSubview:textField];
}

- (IBAction)buttonPressed:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    if (11 == tag)
    {
        NextViewController *nextPageViewController = [[[NextViewController alloc] init] autorelease];
        [self presentViewController:nextPageViewController animated:YES completion:^{
            NSLog(@"切换到下一页");
        }];
    }
    else // 点击关灯按钮
    {
        UIButton *nextPageButton = (UIButton *)[self.view viewWithTag:11];
        UILabel *leftLabel  = (UILabel *)[self.view viewWithTag:13];
        UILabel *rightLabel = (UILabel *)[self.view viewWithTag:14];
        UITextField *textField = (UITextField *)[self.view viewWithTag:15];
        BOOL isHidden         = nextPageButton.hidden == YES ? NO : YES;
        nextPageButton.hidden = isHidden;
        leftLabel.hidden = isHidden;
        rightLabel.hidden = isHidden;
        textField.hidden = isHidden;
        
        sender.selected = !sender.selected;
        self.view.backgroundColor = sender.selected ? [UIColor grayColor] : [UIColor whiteColor];
    }
    
}

// 根据字符内容多少获取Rect的size
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font constraintSize:(CGSize)constraintSize
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(150, 568)
                                       options:NSStringDrawingTruncatesLastVisibleLine |
                                                NSStringDrawingUsesFontLeading |
                                                NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                       context:nil];
    return rect.size;
}

- (void)replaceTextStringToLabel
{
    UITextField *textField = (UITextField *) [self.view viewWithTag:15];
    if (!textField.text || textField.text.length == 0)
    {
        NSLog(@"Are you kidding me?");
        return;
    }
    UILabel *leftLabel  = (UILabel *)[self.view viewWithTag:13];
    leftLabel.text      = textField.text;
    
    UILabel *rightLabel = (UILabel *)[self.view viewWithTag:14];
    CGSize size         = [self sizeWithString:textField.text font:[UIFont systemFontOfSize:15] constraintSize:CGSizeMake(150, 568)];
    rightLabel.frame    = CGRectMake(165, 250, size.width, size.height);
    rightLabel.text     = textField.text;
    
    textField.text = nil;
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 关闭键盘
    // solution 1
//    [textField resignFirstResponder];
    
    //solution 2
    [self.view endEditing:YES];
    NSLog(@"%@", NSStringFromSelector(_cmd));
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self replaceTextStringToLabel];
}

#define NUMBER_SET @"0123456789"

// 限制长度，过滤输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location >= 11)
    {
        return NO;
    }
    
    if ([NUMBER_SET rangeOfString:string].location == NSNotFound)
    {
        return NO;
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
