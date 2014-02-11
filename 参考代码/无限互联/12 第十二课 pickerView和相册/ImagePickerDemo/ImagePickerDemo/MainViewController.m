//
//  MainViewController.m
//  ImagePickerDemo
//
//  Created by wei.chen on 13-1-4.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 300)];
    imageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:imageView];
    
    //--------------------网络加载图像------------------------------
    /*
    NSString *urlstring = @"http://image.baidu.com/static/widget/common/listTop/img/logo_8816bd4a.gif";
    NSURL *url = [NSURL URLWithString:urlstring];
    NSData *data = [NSData dataWithContentsOfURL:url];
    //data转UIImage
    UIImage *image = [UIImage imageWithData:data];
    imageView.image = image;
    
    //将UIImage转成NSData
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    NSLog(@"%d",imageData.length);
    
    //将图片保存到相册
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
    */
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.tag = 100;
    button.frame = CGRectMake(80, 50, 100, 20);
    [button setTitle:@"访问相册" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button2.tag = 200;
    button2.frame = CGRectMake(180, 50, 100, 20);
    [button2 setTitle:@"摄像头" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

//将图片保存至相册后调用
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"%@",error);
}

- (void)clickAction:(UIButton *)button {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    //调用摄像头
    if (button.tag == 200) {
        //UIImagePickerControllerCameraDeviceRear 后置摄像头
        //UIImagePickerControllerCameraDeviceFront 前置摄像头
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            NSLog(@"没有摄像头");
            return;
        }
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = YES;
    }
    
    
    [self presentViewController:imagePicker animated:YES completion:NULL];
    [imagePicker release];    
}

#pragma mark - UIImagePickerController delegate
//相册图片选中之后调用
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //key:UIImagePickerControllerOriginalImage 取原始图片
    //key:UIImagePickerControllerEditedImage 取编辑后的图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    imageView.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

//取消按钮的点击事件
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


@end
