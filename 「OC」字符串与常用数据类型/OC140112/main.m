//
//  main.m
//  OC140112
//
//  Created by cuan on 14-1-11.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    // 常用数据类型
//    NSInteger // int/long
//    CGFloat // float/double
//    NSTimeInterval // double
//    复杂数据类型：结构体、枚举、共用体
//    NSNumber:简单数据类型、复杂数据类型无法放入OC数组中，最大优势，保留有效位数56
    
    
//    NSNumber *number = [NSNumber numberWithBool:YES];
//    NSLog(@"%@", number);
//    
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
////    [formatter setNumberStyle:numberFormattingBadFormatErr];
//    [formatter setNumberStyle:numberFormattingLiteralMissingErr];

//    NSString *string = [formatter stringFromNumber:[NSNumber numberWithFloat:12.32]];
//    NSLog(@"%@",string);
//    
    
//    NSString *theString = @"    Hello      this  is a   long       string!   ";
    NSString *string = @"abcde";
    NSString *resultString = [string stringByReplacingOccurrencesOfString:@"bcd" withString:@""];
    NSLog(@"%@", resultString);
//    yyyy-MM-dd EEEE HH:mm:ss
    
    

    return 0;
}

