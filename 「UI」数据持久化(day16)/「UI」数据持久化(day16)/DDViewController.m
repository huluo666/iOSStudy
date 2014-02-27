//
//  DDViewController.m
//  「UI」数据持久化(day16)
//
//  Created by 萧川 on 14-2-27.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDViewController.h"
#import "DDAppDelegate.h"
#import "ContactInformation.h"
#import "ContactDetailInformation.h"

#define kTextFieldTag 100
#define kButtonTag 200

@interface DDViewController () <UITextFieldDelegate>

- (void)initUserInterface;
- (void)saveImage;
- (NSString *)applicationDocument;

- (void)save;
- (void)read;
- (void)clear;
@end

@implementation DDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUserInterface];
//    [self saveImage];
}

- (void)initUserInterface
{
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *labels = @[@"Name", @"Age", @"Sex", @"Birthday", @"Telephone", @"Address"];
    // 创建输入列表
    CGFloat labelCenterX = 40;
    CGFloat labelCenterY = 100;
    for (int i = 0; i < 6; i++) {
        // label
        UILabel *label = [[UILabel alloc] init];
        label.bounds = CGRectMake(0, 0, 100, 30);
        label.center = CGPointMake(labelCenterX, labelCenterY);
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor grayColor];
        label.text = [NSString stringWithFormat:@"%@:", labels[i]];
        label.backgroundColor = [UIColor clearColor];
        [self.view addSubview:label];
        labelCenterY = CGRectGetMaxY(label.frame) + CGRectGetHeight(label.frame);
        [label release];
        
        // TextField
        UITextField *textField = [[UITextField alloc] init];
        textField.bounds = CGRectMake(0, 0, 180, 30);
        textField.center = CGPointMake(CGRectGetMaxX(label.frame) + CGRectGetWidth(textField.bounds) / 2 + 5, CGRectGetMidY(label.frame));
        textField.delegate = self;
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textField.layer.borderWidth = 1.0f;
        textField.tag = kTextFieldTag + i;
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.returnKeyType = UIReturnKeyDone;
        textField.clearsOnBeginEditing = YES;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        [self.view addSubview:textField];
        [textField release];
    }
    
    // button
    NSArray *buttonTitles = @[@"保存", @"读取", @"清空"];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.bounds = CGRectMake(0, 0, 80, 30);
        button.center = CGPointMake(CGRectGetMidX(self.view.frame), labelCenterY);
        button.tag = kButtonTag + i;
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        labelCenterY = CGRectGetMaxY(button.frame) + CGRectGetMidY(button.bounds);
    }
}

- (void)buttonPressed:(UIButton *)sender
{
    NSInteger index = sender.tag - kButtonTag;
    switch (index) {
        case 0:
//            [self save];
            [self save2];
            break;
        case 1:
//            [self read];
            [self read2];
            break;
        case 2:
            [self clear];
            break;
        default:
            break;
    }
}

- (void)save
{
    // 获取数据打包
    NSArray *items = @[@"name", @"age", @"sex", @"birthday", @"telephone", @"address"];
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    for (int i = 0; i < items.count; i++) {
        UITextField *textField = (UITextField *)[self.view viewWithTag:kTextFieldTag + i];
        // 判断有效输入
        if (textField.text.length > 0) {
            [infoDict setObject:textField.text forKey:items[i]];
        }
    }
    
    if ([infoDict count] == 0) {
        return;
    }
    
    // Core Data save
    // 获取托管对象上下文，所有数据处理都是基于NSManagedObjectContext
    NSManagedObjectContext *context = [(DDAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    // 创建数据
    ContactInformation *info = [NSEntityDescription insertNewObjectForEntityForName:[ContactInformation entityName] inManagedObjectContext:context];
    // 创建详细数据
    ContactDetailInformation *detailInfo = [NSEntityDescription insertNewObjectForEntityForName:[ContactDetailInformation entityName] inManagedObjectContext:context];
    info.name            = infoDict[@"name"];
    info.age             = infoDict[@"age"];
    info.sex             = infoDict[@"sex"];
    info.detailInfo      = detailInfo;
    
    detailInfo.birthday  = infoDict[@"birthday"];
    detailInfo.telephone = infoDict[@"telephone"];
    detailInfo.address   = infoDict[@"address"];
    detailInfo.info      = info;
    
    // 保存数据
    NSError *error = nil;
    BOOL success = [context save:&error];
    NSAssert(success, @"NSManagedObjectContext save operation did faild with error message %@ ", [error localizedDescription]);
}

- (void)save2
{
    // 获取数据打包
    NSArray *items = @[@"name", @"age", @"sex", @"birthday", @"telephone", @"address"];
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    for (int i = 0; i < items.count; i++) {
        UITextField *textField = (UITextField *)[self.view viewWithTag:kTextFieldTag + i];
        // 判断有效输入
        if (textField.text.length > 0) {
            [infoDict setObject:textField.text forKey:items[i]];
        }
    }
    
    if ([infoDict count] == 0) {
        return;
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    // 获取用户列表，从NSUserDefaults取出的对象均是不可变的
    NSMutableArray *infoList = [NSMutableArray arrayWithArray:[userDefaults objectForKey:@"NSUSERDEFAULTS_KEY"]];
    [infoList addObject:infoDict];
    [userDefaults setObject:infoList forKey:@"NSUSERDEFAULTS_KEY"];
    // 同步数据
    [userDefaults synchronize];
}

- (void)read
{
    // 获取托管对象上下文，所有数据处理都是基于NSManagedObjectContext
    NSManagedObjectContext *context = [(DDAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    // 初始化检索请求
    NSFetchRequest *fetchRequset = [NSFetchRequest fetchRequestWithEntityName:[ContactInformation entityName]];
    // 配置检索条件
    fetchRequset.predicate = [NSPredicate predicateWithFormat:@"age > 20"];
    // 执行检索请求
    NSError *error = nil;
    NSArray *objects =[context executeFetchRequest:fetchRequset error:&error];
    NSAssert(!error, @"NSManagedObjectContext fetch operation did faild with error message %@", [error localizedDescription]);
    if (objects.count > 0) {
        for (id obj in objects) {
            NSLog(@"%@", obj);
        }
    }
    
}

- (void)read2
{
    NSArray *infoList = [[NSUserDefaults standardUserDefaults] objectForKey:@"NSUSERDEFAULTS_KEY"];
    if ([infoList count] > 0) {
        NSLog(@"%@", infoList);
    }
}

- (void)clear
{
    // 获取托管对象上下文，所有数据处理都是基于NSManagedObjectContext
    NSManagedObjectContext *context = [(DDAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    // 初始化检索请求
    NSFetchRequest *fetchRequset = [NSFetchRequest fetchRequestWithEntityName:[ContactInformation entityName]];
    // 执行检索请求
    NSError *error = nil;
    NSArray *objects =[context executeFetchRequest:fetchRequset error:&error];
    NSAssert(!error, @"NSManagedObjectContext fetch operation did faild with error message %@", [error localizedDescription]);
    if (objects.count > 0) {
        for (id obj in objects) {
            // 从上下文中删除数据
            [context deleteObject:obj];
        }
        BOOL success = [context save:&error];
        NSAssert(success, @"NSManagedObjectContext delete operation faild with error message %@", [error localizedDescription]);
    }

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    return YES;
}

- (void)saveImage
{
//    NSString *mainDir = NSHomeDirectory();
//    NSLog(@"mainDir = %@", mainDir);
//    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
//    NSLog(@"documentDir = %@", documentDir);
//    NSString *libraryDir = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
//    NSLog(@"libraryDir = %@", libraryDir);
//    NSString *tempDir = NSTemporaryDirectory();
//    NSLog(@"tempDir = %@", tempDir);
    
    // 储存图片到Document目录下
//    UIImagePNGRepresentation(<#UIImage *image#>);
//    UIImageJPEGRepresentation(<#UIImage *image#>, <#CGFloat compressionQuality#>);
    // 获取图片数据
    UIImage *image = [UIImage imageNamed:@"1"];
    NSData *imageData = UIImagePNGRepresentation(image);
    // 获取沙盒路径
    NSString *imageDirectory = [[self applicationDocument] stringByAppendingPathComponent:@"images"];
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:imageDirectory]) {
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:imageDirectory
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:&error];
        
        NSAssert(success, @"create directory at path %@ failed with error message %@",
                 imageDirectory, [error localizedDescription]);
    }
    // 获取存储路径
    NSString *imagePath = [NSString stringWithFormat:@"%@/1.png", imageDirectory];
    // 写入图片
    if (![[NSFileManager defaultManager] isExecutableFileAtPath:imagePath]) {
        [[NSFileManager defaultManager] createFileAtPath:imagePath contents:imageData attributes:nil];
    }
}

- (NSString *)applicationDocument
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

@end
