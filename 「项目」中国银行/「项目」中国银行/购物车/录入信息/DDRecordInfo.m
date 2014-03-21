//
//  DDRecordInfo.m
//  「项目」中国银行
//
//  Created by 萧川 on 14-3-20.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDRecordInfo.h"
#import "DDAppDelegate.h"

@interface DDRecordInfo ()
@property (retain, nonatomic) NSMutableArray *fields;
@end

@implementation DDRecordInfo

- (void)dealloc
{
    [_doSomeThing release];
    [_fields release];
    [_data release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect frame = CGRectMake(0, 0, kRootViewWidth, kRootViewHeight);
        self.bounds = frame;
        self.center = CGPointMake(CGRectGetMidX(self.bounds), 3 * CGRectGetMidY(self.bounds));
        
        UIView *view = [[UIView alloc] initWithFrame:frame];
        view.userInteractionEnabled = NO;
        view.alpha = 0.5;
        [self addSubview:view];
        [view release];
        
        UIImage *backgroundImage = kImageWithName(@"record_info");
        UIImageView *backgroundView = [[UIImageView alloc] initWithImage:backgroundImage];
        backgroundView.bounds = CGRectMake(0, 0, 855, 633);
        backgroundView.center = CGPointMake(CGRectGetMidX(self.bounds),
                                            CGRectGetMidY(self.bounds));
        backgroundView.userInteractionEnabled = YES;
        [self addSubview:backgroundView];
        
        [UIView animateWithDuration:kAnimateDuration
                         animations:^{
                             self.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
                         }];
        _fields = [[NSMutableArray alloc] init];
        for (int i = 0; i < 3; i++) {
            UITextField *field = [[UITextField alloc] init];
            field.bounds = CGRectMake(0, 0, 450, 40);
            field.center = CGPointMake(CGRectGetMidX(self.bounds) + 50, 200 + i * 80);
            [self addSubview:field];
            [field release];
            [_fields addObject:field];
        }
        
        UIButton *submit = [UIButton buttonWithType:UIButtonTypeCustom];
        submit.bounds = CGRectMake(0, 0, 159, 40);
        submit.center = CGPointMake(CGRectGetMidX(self.bounds), 487);
        [submit addTarget:self
                   action:@selector(submit:)
         forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:submit];
        
        UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
        close.bounds = CGRectMake(0, 0, 40, 40);
        close.center = CGPointMake(910, 90);
        [close addTarget:self
                   action:@selector(popSelf)
         forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:close];

    }
    return self;
}

- (void)popSelf
{
    [UIView animateWithDuration:kAnimateDuration
                     animations:^{
                         self.center = CGPointMake(CGRectGetMidX(self.bounds), 3 * CGRectGetMidY(self.bounds));
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

- (void)submit:(UIButton *)sender
{
    
    NSLog(@"%@", _fields);
    for (UITextField *field in _fields) {
        NSLog(@"%@", field.text);
        
        if (!field.text) {
            return;
        }
        if (field.text.length == 0) {
            return;
        }
    }
    
    // 记录信息
    NSLog(@"给我的数据是什么？%@", _data);
    
    NSString *name = ((UITextField *)_fields[0]).text ? ((UITextField *)_fields[0]).text : @"无力吐槽";
    NSString *ID = ((UITextField *)_fields[1]).text ? ((UITextField *)_fields[1]).text : @"再次无力吐槽";
    NSString *tel = ((UITextField *)_fields[2]).text ? ((UITextField *)_fields[2]).text: @"真心无力吐槽";
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoId];
    
    
    NSArray *dicts = [_data valueForKey:@"buyProductInfo"];
    NSLog(@"buyProductInfos = %@", dicts);
    NSMutableArray *productInfos = [NSMutableArray array];

    for (int i = 0; i < dicts.count; i++) {
        id obj = dicts[i];
        if ([obj isKindOfClass:[NSArray class]]) {
            [productInfos insertObject:obj[0] ? obj[0]: @{} atIndex:0];
        }
        if ([obj isKindOfClass:[NSDictionary class]]) {
            [productInfos insertObject:obj ? obj : @{} atIndex:0];
        }
    }
    NSArray *shoppingList = [productInfos valueForKey:@"productId"] ? [productInfos valueForKey:@"productId"] : @[];
    NSArray *amount = [_data valueForKey:@"buynumber"] ? [_data valueForKey:@"buynumber"] : @[];

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:name forKey:@"name"];
    [dict setObject:ID forKey:@"ID"];
    [dict setObject:tel forKey:@"tel"];
    [dict setObject:userId forKey:@"userId"];
    [dict setObject:shoppingList forKey:@"shoppingList"];
    [dict setObject:amount forKey:@"amount"];
    
    // 干掉自己
    [self popSelf];
    
    // 出现动画
    UIImage *doneImage = kImageWithName(@"保存订单成功");
    UIImageView *doneView = [[UIImageView alloc] initWithImage:doneImage];
    doneView.bounds = CGRectMake(0, 0, 747, 457);
    doneView.center = CGPointMake(CGRectGetMidX(self.bounds), 3 * CGRectGetMidY(self.bounds));
    [kRootView addSubview:doneView];
    [doneView release];
    
    [UIView animateWithDuration:kAnimateDuration
                          delay:0.5f
         usingSpringWithDamping:1.0f
          initialSpringVelocity:1.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         doneView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:kAnimateDuration
                                               delay:2
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                               doneView.center = CGPointMake(CGRectGetMidX(self.bounds), 3 * CGRectGetMidY(self.bounds));
                                          }
                                          completion:^(BOOL finished) {
                                              [doneView removeFromSuperview];
                                              if (_doSomeThing) {
                                                  NSLog(@"传给选购清单的信息：%@", dict);
                                                  _doSomeThing(dict);
                                              }
                                          }];
                     }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

@end
