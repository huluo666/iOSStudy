//
//  DDSignupViewController.m
//  LighterReader
//
//  Created by 萧川 on 14-3-27.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDSignViewController.h"
#import "DDEncryption.h"
#import "DDHTTPManager.h"

@interface DDSignViewController ()

// submit signup infos
- (void)submitSingup:(UIButton *)sender;

@property (retain, nonatomic) NSMutableArray *textFields; // record textfields

@end

@implementation DDSignViewController

- (void)dealloc
{
    [_textFields release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _textFields = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.863 alpha:1.000];
    
    // Signup、singin UI
    NSArray *titles = @[@"邮箱", @"密码"];
    NSArray *placeholders = @[@"请输入有效邮箱地址", @"请输入您的密码"];
    // titles center x
    CGPoint lastTextFiledCenter = CGPointZero;
    for (int i = 0; i < 2; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.bounds = CGRectMake(0, 0, 60, 30);
        label.center = CGPointMake(CGRectGetMidX(label.bounds), 150 + i * (CGRectGetHeight(label.bounds)+ 5));
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentRight;
        label.text = titles[i];
        [self.view addSubview:label];
        [label release];
        
        UITextField *textField = [[UITextField alloc] init];
        textField.bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) - CGRectGetWidth(label.bounds) - 6, 30);
        textField.center = CGPointMake(CGRectGetMaxX(label.frame) +
                                       CGRectGetMidX(textField.bounds) + 3, CGRectGetMidY(label.frame));
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textField.layer.borderWidth = 1;
        textField.layer.cornerRadius = 5;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.clearsOnBeginEditing = YES;
        if (1 == i) {
            textField.secureTextEntry = YES;
            lastTextFiledCenter = CGPointMake(CGRectGetMidX(textField.frame),
                                              CGRectGetMidY(textField.frame));
        }
        
        [self.view addSubview:textField];
        [_textFields addObject:textField];
        [textField release];
        textField.placeholder = placeholders[i];
    }
    
    // Submit button
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submit.bounds = CGRectMake(0, 0, 60, 30);
    submit.center = CGPointMake(lastTextFiledCenter.x, lastTextFiledCenter.y + CGRectGetMaxY(submit.bounds) + 5);
    submit.tintColor = [UIColor grayColor];
    submit.layer.borderColor = [UIColor lightGrayColor].CGColor;
    submit.layer.borderWidth = 1;
    submit.layer.cornerRadius = 3;
    [submit setTitle:@"确认提交" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitSingup:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
}

- (void)submitSingup:(UIButton *)sender
{
//    // get email address, password
//    NSString *emailAddress = ((UITextField *)_textFields[0]).text;
//    NSString *password = ((UITextField *)_textFields[1]).text;
//    NSLog(@"emailAddress =  %@， password = %@", emailAddress, password);
//    // encrypt password
//    NSString *encryptionPassword = [DDEncryption encryptString:password];
//    NSLog(@"emailAddress =  %@， encryptionPassword = %@", emailAddress, encryptionPassword);
//    
//    if (!emailAddress || 0 == emailAddress.length) {
//        return;
//    }
//
//    if (!password || 0 == password.length) {
//        return;
//    }
//    
//    // check email
//    // code...
//
//    if (DDSignTypeSignup == _signtype) {
//        // singn up
//        
//        // start http request
//        NSDictionary *postDict = @{@"emailAddress":emailAddress, @"encryptionPassword":encryptionPassword};
//        [DDHTTPManager startAsynchronousRequestWithURLString:kSignupURL params:postDict completionHandler:^(BOOL sucess, id content) {
//            if (sucess) {
//                NSLog(@"get somethings = %@", content);
//            };
//        }];
//        
//    } else {
//        NSLog(@"sign in");
//    }
    
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
    
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
