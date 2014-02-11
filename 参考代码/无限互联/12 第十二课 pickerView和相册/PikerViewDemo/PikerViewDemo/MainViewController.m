//
//  MainViewController.m
//  PikerViewDemo
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
    
    //宽和高是固定的，宽：320， 高：216
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 460-216, 0, 0)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:pickerView];
    [pickerView release];
    
    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *path = [[bundle resourcePath] stringByAppendingPathComponent:@"city.plist"];
    NSString *path = [bundle pathForResource:@"city" ofType:@"plist"];
    data = [[NSArray alloc] initWithContentsOfFile:path];
    
}


#pragma mark - UIPickerView delegate
//返回有列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

//返回每一列中的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return data.count;
    }
    
    //返回第一列选择的行的索引
    NSInteger selectedRow = [pickerView selectedRowInComponent:0];
    //取得省级字典
    NSDictionary *items = [data objectAtIndex:selectedRow];
    //取得该省下所有的市
    NSArray *cities = [items objectForKey:@"cities"];
    
    return cities.count;
}

//返回没个item中的title
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    if (component == 0) {
        NSDictionary *dic = [data objectAtIndex:row];
        NSString *state = [dic objectForKey:@"state"];
        return state;
    }
    
    //返回第一列选择的行的索引
    NSInteger selectedRow = [pickerView selectedRowInComponent:0];
    //取得省级字典
    NSDictionary *items = [data objectAtIndex:selectedRow];
    //取得该省下所有的市
    NSArray *cities = [items objectForKey:@"cities"];
    NSString *cityName = [cities objectAtIndex:row];
    return cityName;
}

//自定义行中显示的view
//- (UIView *)pickerView:(UIPickerView *)pickerView
//            viewForRow:(NSInteger)row
//          forComponent:(NSInteger)component
//           reusingView:(UIView *)view {
//    
//    if (component == 0) {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
//        view.backgroundColor = [UIColor grayColor];
//        return [view autorelease];
//    }
//    
//    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 220, 40)];
//    view2.backgroundColor = [UIColor redColor];
//    return [view2 autorelease];
//}

//设置列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 100;
    }
    return 220;
}


//选择行的事件
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    
    if (component == 0) {
        //刷新指定列中的行
        [pickerView reloadComponent:1];
        //选择指定的item
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
}


@end
