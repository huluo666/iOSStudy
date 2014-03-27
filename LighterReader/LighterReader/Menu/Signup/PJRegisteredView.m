//
//  PJLoginView.m
//  LighterReader
//
//  Created by rimi on 14-3-27.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "PJRegisteredView.h"

@implementation PJRegisteredView{
    
    NSMutableArray *_mutableArray;
    
    NSMutableArray *_mutableArray1;
    
    UILabel *_lable;
    
    UITextField *_textField;
}

- (void) buttonPressed:(UIButton *)sender{
    
    [_textField resignFirstResponder];
    
    NSString *text = _textField.text;
    
    if (!text || text.length == 0) {
        return;
        
    }
    
}

- (void) dealloc{
    
    [_lable         release];
    [_textField     release];
    [_mutableArray  release];
    [_mutableArray1 release];
    
    [super          dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        // 注册
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = self.frame;
        imageView.backgroundColor = [UIColor brownColor];
        imageView.image = DDImageWithName(@"loginBackgroundIPadPortrait@2x.jpg");
        
        [self addSubview:imageView];
        
        _mutableArray = [NSMutableArray arrayWithObjects:@"用户名",@"密码",@"邮箱", nil];
        
        _mutableArray1 = [NSMutableArray arrayWithObjects:@"请输入用户名",@"请输入密码",@"请输入邮箱",nil];
        
        for (int i = 0; i<3; i++) {
            
            _lable = [[UILabel alloc] init];
            
            _lable.bounds = CGRectMake(CGRectGetMinX(self.bounds)+20,
                                          CGRectGetMinY(self.bounds)+20, 35, 30);
            
            _lable.center = CGPointMake(80, 200+(20+20)*(i/1));
            _lable.text = _mutableArray[i];
            _lable.layer.cornerRadius = 5;
            _lable.textAlignment = NSTextAlignmentCenter;
            _lable.font = [UIFont systemFontOfSize:10];
            _lable.backgroundColor = [UIColor brownColor];
            [self addSubview:_lable];
            
            _textField = [[UITextField alloc] init];
            
            _textField.bounds = CGRectMake(CGRectGetMinY(self.bounds)+60,
                                              CGRectGetMinY(self.bounds)+60, 160, 30);
            
            _textField.center = CGPointMake(180, 200+(20+20)*(i/1));
            _textField.clearButtonMode = UITextFieldViewModeAlways;
            _textField.text = _mutableArray1[i];
            _textField.delegate = self;
            _textField.tag =120+i;
            _textField.layer.cornerRadius = 5;
            _textField.textAlignment = NSTextAlignmentLeft;
            _textField.font = [UIFont systemFontOfSize:10];
            _textField.backgroundColor = [UIColor grayColor];
            [self addSubview:_textField];
            
//            CGFloat height = [[UIScreen mainScreen] bounds].size.height;
//            NSLog(@"height= %f", height);
//            
//            if (height <=480) {
//                _lable.center = CGPointMake(80, 120+(20+20)*(i/1));
//                _textField.center = CGPointMake(180, 120+(20+20)*(i/1));
//            }
        }
        UIButton *registeredButton = [UIButton buttonWithType:UIButtonTypeCustom];
        registeredButton.frame = CGRectMake(150, 320, 60, 30);
        registeredButton.tag = 124;
        registeredButton.layer.cornerRadius = 5;
        registeredButton.backgroundColor = [UIColor brownColor];
        [registeredButton setTitle:@"注册" forState:UIControlStateNormal];
        [registeredButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:registeredButton];
        
        CGFloat height = [[UIScreen mainScreen] bounds].size.height;
        NSLog(@"height= %f", height);
        
        if (height <=480) {
            
           
        }

    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
