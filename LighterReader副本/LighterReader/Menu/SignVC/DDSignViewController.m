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
#import "DDRootViewController.h"
#import "DDAppDelegate.h"

@interface DDSignViewController ()

// cancel sign
- (void)cancelSingup:(UIButton *)sender;
// submit sign infos
- (void)submitSingup:(UIButton *)sender;

// record textfields
@property (retain, nonatomic) NSMutableArray *textFields;

// check email
-(BOOL)isValidateEmail:(NSString *)email;
// check password
-(BOOL)isValidatePassword:(NSString *)password;

// alert view
- (void)alertWithMessage:(NSString *)message;

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
    NSArray *titles = @[@"Email", @"Password"];
    NSArray *placeholders = @[@"Please enter a valid email",
                              @"Please enter your password"];
    // titles center x
    CGPoint lastTextFiledCenter = CGPointZero;
    for (int i = 0; i < 2; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.bounds = CGRectMake(0, 0, 80, 30);
        label.center = CGPointMake(CGRectGetMidX(label.bounds),
                                   150 + i * (CGRectGetHeight(label.bounds)+ 5));
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentRight;
        label.text = titles[i];
        [self.view addSubview:label];
        [label release];
        
        UITextField *textField = [[UITextField alloc] init];
        textField.bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) -
                                      CGRectGetWidth(label.bounds) - 6, 30);
        textField.center = CGPointMake(CGRectGetMaxX(label.frame) +
                                       CGRectGetMidX(textField.bounds) + 3,
                                       CGRectGetMidY(label.frame));
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textField.layer.borderWidth = 1;
        textField.layer.cornerRadius = 5;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.clearsOnBeginEditing = YES;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        if (0 == i) {
            [textField becomeFirstResponder];
        }
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
    
    // Cancel button
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancel.bounds = CGRectMake(0, 0, 60, 30);
    cancel.center = CGPointMake(lastTextFiledCenter.x -
                                CGRectGetMidX(cancel.bounds) - 5,
                                lastTextFiledCenter.y +
                                CGRectGetMaxY(cancel.bounds) + 5);
    cancel.tintColor = [UIColor grayColor];
    cancel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cancel.layer.borderWidth = 1;
    cancel.layer.cornerRadius = 3;
    [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancel addTarget:self
               action:@selector(cancelSingup:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancel];

    
    // Submit button
    UIButton *submit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submit.bounds = CGRectMake(0, 0, 60, 30);
    submit.center = CGPointMake(lastTextFiledCenter.x +
                                CGRectGetMidX(cancel.bounds) + 5,
                                lastTextFiledCenter.y +
                                CGRectGetMaxY(submit.bounds) + 5);
    submit.tintColor = [UIColor grayColor];
    submit.layer.borderColor = [UIColor lightGrayColor].CGColor;
    submit.layer.borderWidth = 1;
    submit.layer.cornerRadius = 3;
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submit addTarget:self
               action:@selector(submitSingup:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submit];
}

#pragma mark - private messags

- (void)cancelSingup:(UIButton *)sende {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)submitSingup:(UIButton *)sender {
    
    // get email address, password
    NSString *emailAddress = ((UITextField *)_textFields[0]).text;
    NSString *password = ((UITextField *)_textFields[1]).text;

    if (!emailAddress || 0 == emailAddress.length) {
        return;
    }

    if (!password || 0 == password.length) {
        return;
    }
    
    // check email
    BOOL emailLegal = [self isValidateEmail:emailAddress];
    if (!emailLegal) {
        [self alertWithMessage:@"Email format error, please try again"];
        return;
    }
    // check password
    BOOL passwordLegal = [self isValidatePassword:password];
    if (!passwordLegal) {
        [self alertWithMessage:@"Password format error, please try again"];
        return;
    }

    NSLog(@"emailAddress =  %@, password = %@", emailAddress, password);
    // encrypt password
    NSString *encryptionPassword = [DDEncryption encryptString:password];
    NSLog(@"emailAddress =  %@， encryptionPassword = %@", emailAddress, encryptionPassword);
    
    NSDictionary *postDict = @{@"emailAddress":emailAddress,
                               @"encryptionPassword":encryptionPassword};
    if (DDSignTypeSignup == _signtype) {
        /* singn up */
        // start http request insert user infos
        [DDHTTPManager startAsynchronousRequestWithURLString:kSignupURL
                                                      params:postDict
                                           completionHandler:^(BOOL success, id content) {
            if (success) {
                NSString *successMessage = [NSString stringWithFormat:@"%@, please sing in!", content];
                [self alertWithMessage:successMessage];
                [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
            } else {
                NSString *failureMessage = [NSString stringWithFormat:@"Sign up failure with `%@`",
                                          content];
                [self alertWithMessage:failureMessage];
            }
        }];
        
    } else {
        /* sign in */
        // start http request ask sign in
        [DDHTTPManager startAsynchronousRequestWithURLString:kSigninURL
                                                      params:postDict
                                           completionHandler:^(BOOL success, id content) {
            if (!success) {
                // failure
                NSString *failureMessage = [NSString stringWithFormat:@"sign in failure with `%@`", content];
                [self alertWithMessage:failureMessage];
            } else {
                // set logined
                DDRootViewController *rootVC = (DDRootViewController *)[[((DDAppDelegate *)[[UIApplication sharedApplication] delegate]) window] rootViewController];
                [rootVC setLogin:YES];
                [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
            }
        }];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

#pragma mark - regex

// check email
-(BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",
                              emailRegex];
    return [emailTest evaluateWithObject:email];
}

// check password
- (BOOL)isValidatePassword:(NSString *)password {

    NSString *passwordRegex = @"^[A-Za-z0-9]{6,15}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",
                                 passwordRegex];
    return [passwordTest evaluateWithObject:password];
}

#pragma mark - alert

- (void)alertWithMessage:(NSString *)message {

    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Alert"
                              message:message
                              delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:nil];
    
    [alertView show];
    [alertView release];
    
    // wait 1.2 seconds dismiss
    NSMethodSignature *signature = [UIAlertView instanceMethodSignatureForSelector:
                                    @selector(dismissWithClickedButtonIndex:animated:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:alertView];
    [invocation setSelector:@selector(dismissWithClickedButtonIndex:animated:)];
    NSInteger index = 0;
    [invocation setArgument:&index atIndex:2];
    BOOL animated = YES;
    [invocation setArgument:&animated atIndex:3];
    [invocation retainArguments];
    [invocation performSelector:@selector(invoke) withObject:nil afterDelay:2.2];
}

@end
