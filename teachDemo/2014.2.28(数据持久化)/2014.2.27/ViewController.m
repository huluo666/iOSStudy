//
//  ViewController.m
//  2014.2.27
//
//  Created by 张鹏 on 14-2-27.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ContactInformation.h"
#import "ContactDetailInformation.h"
#import "Person.h"
#import "CoreDataManager.h"

#define TEXTFIELD_TAG 10
#define BUTTON_TAG 20

#define NSUSERDEFAULTS_KEY @"NSUserDefaultsKey"

@interface ViewController () <UITextFieldDelegate>

- (void)initializeUserInterface;
- (void)buttonPressed:(UIButton *)sender;
- (void)save;
- (void)read;
- (void)clear;
- (void)saveImage;
- (NSString *)applicationDocumentDirectory;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initializeUserInterface];
    [self saveImage];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect bounds = self.view.bounds;
    
    NSArray *itemList = @[@"Name", @"Age", @"Sex", @"Birthday", @"Telephone", @"Address"];
    for (int i = 0; i < [itemList count]; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.bounds = CGRectMake(0, 0, 100, 25);
        label.center = CGPointMake(CGRectGetMinX(bounds) + CGRectGetMidX(label.bounds),
                                   CGRectGetMinY(bounds) + 100 + CGRectGetMidY(label.bounds) + (10 + CGRectGetHeight(label.bounds)) * i);
        label.text = [itemList[i] stringByAppendingString:@"："];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentRight;
        label.backgroundColor = [UIColor clearColor];
        [self.view addSubview:label];
        
        UITextField *textField = [[UITextField alloc] init];
        textField.bounds = CGRectMake(0, 0, 200, 25);
        textField.center = CGPointMake(CGRectGetMaxX(label.frame) + CGRectGetMidX(textField.bounds),
                                       CGRectGetMidY(label.frame));
        textField.delegate = self;
        textField.font = [UIFont systemFontOfSize:15];
        textField.borderStyle = UITextBorderStyleLine;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.tag = TEXTFIELD_TAG + i;
        [self.view addSubview:textField];
        if (i == 1 || i == 3 || i == 4) {
            textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }
    }
    
    itemList = @[@"保存", @"读取", @"清空"];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.bounds = CGRectMake(0, 0, 100, 30);
        button.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds) + 50 + (10 + CGRectGetHeight(button.bounds)) * i);
        [button setTitle:itemList[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = BUTTON_TAG + i;
        [self.view addSubview:button];
    }
}

#pragma mark - Button function methods

- (void)buttonPressed:(UIButton *)sender {
    
    NSInteger index = sender.tag - BUTTON_TAG;
    switch (index) {
        case 0: [self save]; break;
        case 1: [self read]; break;
        case 2: [self clear]; break;
        default: break;
    }
}

- (void)save {
    
    // 获取用户输入数据，打包字典
    NSArray *itemList = @[@"name", @"age", @"sex", @"birthday", @"telephone", @"address"];
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    for (int i = 0; i < [itemList count]; i++) {
        UITextField *textFiled = (UITextField *)[self.view viewWithTag:TEXTFIELD_TAG + i];
        // 判断有效输入
        if (textFiled.text.length > 0) {
            [infoDict setObject:textFiled.text forKey:itemList[i]];
        }
    }
    // 为空判断
    if ([infoDict count] == 0) {
        return;
    }
    
    // 基础属性字典
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    [info setObject:infoDict[@"name"] ? infoDict[@"name"] : @"" forKey:@"name"];
    [info setObject:infoDict[@"age"] ? infoDict[@"age"] : @"" forKey:@"age"];
    [info setObject:infoDict[@"sex"] ? infoDict[@"sex"] : @"" forKey:@"sex"];
    [info setObject:@"relation" forKey:@"detailInfo"];
    // 关系属性字典
    NSMutableDictionary *detailInfo = [NSMutableDictionary dictionary];
    [detailInfo setObject:infoDict[@"birthday"] ? infoDict[@"birthday"] : @"" forKey:@"birthday"];
    [detailInfo setObject:infoDict[@"telephone"] ? infoDict[@"telephone"] : @"" forKey:@"telephone"];
    [detailInfo setObject:infoDict[@"address"] ? infoDict[@"address"] : @"" forKey:@"address"];
    [detailInfo setObject:@"relation" forKey:@"info"];
    
    /*Core Data*/
    // 获取托管对象上下文，所有数据处理都是基于NSManagedObjectContext
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    [CoreDataManager insertObjectInManagedObjectContext:context
                                             entityName:[ContactInformation entityName]
                                     relationEntityName:[ContactDetailInformation entityName]
                                                 params:info
                                         relationParams:detailInfo];
    
    
    
    // 创建新数据
    // 创建基本信息对象
//    ContactInformation *info = [NSEntityDescription
//                                insertNewObjectForEntityForName:[ContactInformation entityName]
//                                inManagedObjectContext:context];
//    // 创建详细信息对象
//    ContactDetailInformation *detailInfo = [NSEntityDescription
//                                            insertNewObjectForEntityForName:[ContactDetailInformation entityName]
//                                            inManagedObjectContext:context];
//    // 配置数据
//    info.name = infoDict[@"name"];
//    info.age = infoDict[@"age"];
//    info.sex = infoDict[@"sex"];
//    info.detailInfo = detailInfo;
//    detailInfo.birthday = infoDict[@"birthday"];
//    detailInfo.telephone = infoDict[@"telephone"];
//    detailInfo.address = infoDict[@"address"];
//    detailInfo.info = info;
//    
//    // 保存数据
//    NSError *error = nil;
//    BOOL success = [context save:&error];
//    NSAssert(success, @"NSManagedObjectContext save operation did failed with error message '%@'.", [error localizedDescription]);
    
    
    /*NSUserDefaults*/
//    // 数据格式：NSMutableArray存储用户信息列表，单个数据是NSDictionary类型
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    // 获取用户信息列表，从NSUserDefaults取出的对象均是不可变的
//    NSMutableArray *infoList = [NSMutableArray arrayWithArray:[userDefaults objectForKey:NSUSERDEFAULTS_KEY]];
//    [infoList addObject:infoDict];
//    [userDefaults setObject:infoList forKey:NSUSERDEFAULTS_KEY];
//    // 同步数据到文件系统
//    [userDefaults synchronize];
    
    
    /*plist属性列表序列化*/
    // plist主要用于存储静态数据
    // 获取用户信息集合
//    NSString *filePath =[[self applicationDocumentDirectory]
//                         stringByAppendingPathComponent:@"info.plist"];
//    NSMutableArray *infoList = [NSMutableArray arrayWithContentsOfFile:filePath];
//    // 首次保存为空判断
//    if (!infoList) {
//        infoList = [NSMutableArray array];
//    }
//    // 更新数据
//    [infoList addObject:infoDict];
//    // 写入文件
//    BOOL success = [infoList writeToFile:filePath atomically:YES];
//    NSAssert(success, @"Save operation failed.");
    
    
    /*对象归档*/
//    Person *person = [[Person alloc] initWithDictionary:infoDict];
//    // 对象归档
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:person];
//    // 获取用户信息集合，并添加数据
//    NSString *filePath = [[self applicationDocumentDirectory]
//                          stringByAppendingPathComponent:@"info.plist"];
//    NSMutableArray *infoList = [NSMutableArray arrayWithContentsOfFile:filePath];
//    if (!infoList) {
//        infoList = [NSMutableArray array];
//    }
//    [infoList addObject:data];
//    BOOL success = [infoList writeToFile:filePath atomically:YES];
//    NSAssert(success, @"Save operation failed.");
//    [person release];
}

- (void)read {
    
    /*Core Data*/
    // 获取托管对象上下文，所有数据处理都是基于NSManagedObjectContext
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    NSArray *objects = [CoreDataManager fetchObjectsInManagedObjectContext:context entityName:[ContactInformation entityName] predicateFormat:nil];
    for (id objc in objects) {
        NSLog(@"%@", objc);
    }
    
    
    
    
    // 初始化检索请求
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[ContactInformation entityName]];
//    // 配置检索条件，NSPredicate谓词
////    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"name = 'student qiu'"];
//    // 执行检索请求
//    NSError *error = nil;
//    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
//    NSAssert(!error, @"NSManagedObjectContext fetch operation did failed with error message '%@'.", [error localizedDescription]);
//    // 为空判断
//    if ([objects count] > 0) {
//        for (id object in objects) {
//            NSLog(@"%@", object);
//        }
//    }
    
    /*NSUserDefaults*/
//    NSArray *infoList = [[NSUserDefaults standardUserDefaults] objectForKey:NSUSERDEFAULTS_KEY];
//    if ([infoList count] > 0) {
//        NSLog(@"%@", infoList);
//    }
    
    
    /*plist*/
//    NSString *filePath = [[self applicationDocumentDirectory]
//                          stringByAppendingPathComponent:@"info.plist"];
//    NSArray *infoList = [NSArray arrayWithContentsOfFile:filePath];
//    if ([infoList count] > 0) {
//        NSLog(@"%@", infoList);
//    }
    
    
    /*对象归档*/
//    NSString *filePath = [[self applicationDocumentDirectory]
//                          stringByAppendingPathComponent:@"info.plist"];
//    NSMutableArray *infoList = [NSMutableArray arrayWithContentsOfFile:filePath];
//    if ([infoList count] > 0) {
//        for (NSData *data in infoList) {
//            // NSData反编码为对象
//            Person *person = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//            NSLog(@"%@", person);
//        }
//    }
}

- (void)clear {
    
    /*Core Data*/
    // 获取托管对象上下文，所有数据处理都是基于NSManagedObjectContext
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    [CoreDataManager deleteObjectsInManagedObjectContext:context
                                              entityName:[ContactInformation entityName]
                                         predicateFormat:nil];
    
    
    
    
//    // 检索数据
//    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[ContactInformation entityName]];
//    // 执行检索请求
//    NSError *error = nil;
//    NSArray *objects = [context executeFetchRequest:fetchRequest error:&error];
//    NSAssert(!error, @"NSManagedObjectContext fetch operation did failed with error message '%@'.", [error localizedDescription]);
//    // 为空判断
//    if ([objects count] > 0) {
//        for (id object in objects) {
//            // 从上下文中删除数据
//            [context deleteObject:object];
//        }
//        BOOL success = [context save:&error];
//        NSAssert(success, @"NSManagedObjectContext delete operation failed with error message '%@'.", [error localizedDescription]);
//    }
    
    
    /*NSUserDefaults*/
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults removeObjectForKey:NSUSERDEFAULTS_KEY];
//    [userDefaults synchronize];
    
    
    /*plist*/
//    NSString *filePath = [[self applicationDocumentDirectory]
//                          stringByAppendingPathComponent:@"info.plist"];
    // 1.清空集合
//    NSMutableArray *infoList = [NSMutableArray arrayWithContentsOfFile:filePath];
//    // 清除所有条目
//    if ([infoList count] > 0) {
//        [infoList removeAllObjects];
//    }
//    BOOL success = [infoList writeToFile:filePath atomically:YES];
//    NSAssert(success, @"Delete operation failed.");
    
    // 2.移除文件
//    NSFileManager *manager = [NSFileManager defaultManager];
//    // 如果存在文件，再删除
//    if ([manager fileExistsAtPath:filePath]) {
//        NSError *error = nil;
//        BOOL success = [manager removeItemAtPath:filePath error:&error];
//        NSAssert(success, @"Delete operation did failed with error message '%@'.", [error localizedDescription]);
//    }
}

- (void)saveImage {
    
    // 沙盒主目录
//    NSString *mainDirectory = NSHomeDirectory();
//    NSLog(@"main directory:%@", mainDirectory);
//    // Document目录
//    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSLog(@"document directory:%@", documentDirectory);
//    // Library目录
//    NSString *libraryDirectory = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
//    NSLog(@"library directory:%@", libraryDirectory);
//    // tmp临时文件目录
//    NSString *tmpDirectory = NSTemporaryDirectory();
//    NSLog(@"temporary directory:%@", tmpDirectory);
    
    // 存储图片到Document/images目录下
    // 获取工程文件束中的资源
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:@"1.png"]];
    NSData *data = UIImagePNGRepresentation(image);
    // 获取filemanager单例
    NSFileManager *manager = [NSFileManager defaultManager];
    // 获取Document目录
    NSString *documentDirectory = [self applicationDocumentDirectory];
    // 获取images目录
    NSString *imagesDirectory = [documentDirectory stringByAppendingPathComponent:@"images"];
    // 判断目录是否存在
    if (![manager fileExistsAtPath:imagesDirectory]) {
        // 不存在目录的情况，创建一个目录
        NSError *error = nil;
        BOOL success = [manager createDirectoryAtPath:imagesDirectory
                          withIntermediateDirectories:YES
                                           attributes:nil
                                                error:&error];
        NSAssert(success, @"Creat directory at path '%@' failed with error message '%@'.", imagesDirectory, [error localizedDescription]);
    }
    // 写入图片，文件路径末尾是文件名称，带扩展名
    NSString *imagePath = [imagesDirectory stringByAppendingPathComponent:@"image.png"];
    if (![manager fileExistsAtPath:imagePath]) {
        BOOL success = [manager createFileAtPath:imagePath contents:data attributes:nil];
        NSAssert(success, @"Save image at path '%@' failed.", imagePath);
    }
    
}

- (NSString *)applicationDocumentDirectory {
    
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

@end






















