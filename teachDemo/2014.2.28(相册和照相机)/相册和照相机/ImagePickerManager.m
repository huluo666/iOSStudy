//
//  ImagePickerManager.m
//  相册和照相机
//
//  Created by 张鹏 on 13-12-6.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import "ImagePickerManager.h"
#import "AppDelegate.h"

static ImagePickerManager * sharedImagePickerManager = nil;

@interface ImagePickerManager () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (copy, nonatomic) ImagePickerManagerCompletionBlock completionHandler;

// 拍照
- (void)takePicture;
// 选取照片
- (void)pickPicture;
// 拍摄视屏
- (void)takeMovie;

@end

@implementation ImagePickerManager

// synthesize singleton

+ (id)shareImagePickerManager {
    
    @synchronized(self) {
        if (!sharedImagePickerManager) {
            sharedImagePickerManager = [[self alloc] init];
        }
    }
    return sharedImagePickerManager;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    
    @synchronized(self) {
        if (!sharedImagePickerManager) {
            sharedImagePickerManager = [super allocWithZone:zone];
            return sharedImagePickerManager;
        }
    }
    return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    
    return self;
}

- (id)retain {
    
    return self;
}

- (NSUInteger)retainCount {
    
    return NSUIntegerMax;
}

- (id)autorelease {
    
    return self;
}

- (oneway void)release {
    
    // do nothing...
}

#pragma mark - Taking pictures

- (void)takePictureWithType:(ImagePickerManagerType)type completion:(void (^)(BOOL, id))completion {
    
    _type = type;
    self.completionHandler = completion;
    
    // 判断设备是否支持指定资源类型
    switch (_type) {
            
            // 拍照
        case ImagePickerManagerTypeCamera: [self takePicture]; break;
            
            // 摄像
        case ImagePickerManagerTypeMovie: [self takeMovie]; break;
            
            // 相册
        case ImagePickerManagerTypePhotoLibrary: [self pickPicture]; break;
            
        default: break;
    }
}

- (void)takePicture {
    
    // 判断设备是否支持拍照
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        // 委托
        [picker setDelegate:self];
        // 设置picker资源类型
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        // 设置是否可编辑照片
        [picker setAllowsEditing:YES];
        // 设置可用媒体类型
        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        [picker setMediaTypes:@[mediaTypes[0]]];
        // 自定义照相机拍照界面
//        [picker setShowsCameraControls:NO];
//        [picker setCameraOverlayView:view];
        // 设置主摄像头
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            [picker setCameraDevice:UIImagePickerControllerCameraDeviceRear];
        }
        
        // 显示pikcer
        [Root_View_Controller presentViewController:picker animated:YES completion:^{
            NSLog(@"begin take pictures!");
        }];
        [picker release];
    }
    // 若设备不支持指定类型资源
    else {
        if (_completionHandler) {
            _completionHandler(NO, @"该设备不支持拍照");
        }
    }
}

- (void)pickPicture {
    
    // 判断设备是否支持相册
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        // 委托
        [picker setDelegate:self];
        // 设置picker资源类型
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        // 设置是否可编辑照片
        [picker setAllowsEditing:YES];
        // 设置可用媒体类型
        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [picker setMediaTypes:@[mediaTypes[0]]];
        // 自定义照相机拍照界面
//        [picker setShowsCameraControls:NO];
//        [picker setCameraOverlayView:view];
        
        // 显示pikcer
        [Root_View_Controller presentViewController:picker animated:YES completion:^{
            NSLog(@"begin take pictures!");
        }];
        [picker release];
    }
    // 若设备不支持指定类型资源
    else {
        if (_completionHandler) {
            _completionHandler(NO, @"该设备不支持相册");
        }
    }
}

- (void)takeMovie {
    
    // 判断设备是否支持拍摄视频
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        // 委托
        [picker setDelegate:self];
        // 设置picker资源类型
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        // 设置可用媒体类型
        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        [picker setMediaTypes:@[mediaTypes[1]]];
        // 自定义照相机拍照界面
//        [picker setShowsCameraControls:NO];
//        [picker setCameraOverlayView:view];
        // 设置主摄像头
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            [picker setCameraDevice:UIImagePickerControllerCameraDeviceRear];
        }
        
        // 显示pikcer
        [Root_View_Controller presentViewController:picker animated:YES completion:^{
            NSLog(@"begin take pictures!");
        }];
        [picker release];
    }
    // 若设备不支持指定类型资源
    else {
        if (_completionHandler) {
            _completionHandler(NO, @"该设备不支持摄像");
        }
    }
}

#pragma mark - <UIImagePickerControllerDelegate>

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    id content = nil;
    // 摄像
    if (_type == ImagePickerManagerTypeMovie) {
        content = info[UIImagePickerControllerMediaURL];
    }
    // 拍照/相册
    else {
        content = info[UIImagePickerControllerEditedImage];
    }
    [Root_View_Controller dismissViewControllerAnimated:YES completion:^{
        NSLog(@"pciker complete take pictures!");
        if (_completionHandler) {
            _completionHandler(YES, content);
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [Root_View_Controller dismissViewControllerAnimated:YES completion:^{
        NSLog(@"picker canceled!");
        if (_completionHandler) {
            _completionHandler(NO, @"取消");
        }
    }];
}

#pragma mark - <UINavigationController>

//- (void)navigationController:(UINavigationController *)navigationController
//      willShowViewController:(UIViewController *)viewController
//                    animated:(BOOL)animated {
//    
//    // 隐藏状态栏
//    if ([viewController isKindOfClass:[UIImagePickerController class]]) {
//        [[UIApplication sharedApplication] setStatusBarHidden:YES];
//    }
//}

@end
