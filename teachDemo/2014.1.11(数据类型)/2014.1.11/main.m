//
//  main.m
//  2014.1.11
//
//  Created by 张鹏 on 14-1-11.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    // 简单数据类型：
    // C语言类型:int, float, double, long, short, unsigned, char, boolean
    // OC类型:NSInteger, NSUInteger, CGFloat, NSTimeInterval
    
    // 复杂数据类型：结构体、枚举、共用体
    
    // 数值类型（对象）
    // NSNumber:简单数据类型、复杂数据类型无法放入OC数组内，最大的优势
    //          保留有效位数
    
//    double doubleNumber = 100.005000;
//    NSLog(@"%lf", doubleNumber);
//    NSNumber *number = [NSNumber numberWithDouble:doubleNumber];
//    NSLog(@"%@", number);
//    NSLog(@"%lf", [number doubleValue]);
    
//    NSPoint point = NSMakePoint(20, 20);
//    // 指向运算符 ->
//    NSLog(@"x = %f y = %f", point.x, point.y);
    
//    NSValue *value = [NSValue valueWithRect:NSMakeRect(0, 0, 100, 200)];
//    NSLog(@"%@", value);
//    NSRect rect = [value rectValue];
    
    // 格式化转换NSNumber及NSString
//    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//    [formatter setNumberStyle:NSNumberFormatterSpellOutStyle];
//    NSNumber *doubleNumber = [NSNumber numberWithDouble:100.00511100];
//    NSString *numberString = [formatter stringFromNumber:doubleNumber];
//    NSLog(@"%@", numberString);
    
    
    //  NSString
    // @"123" : 字符串常量
//    NSString *string = [[NSString alloc] initWithFormat:@"%d", 11111];
//    NSString *string = [NSString stringWithFormat:@"%d", 11111];
    
    // 初始化、 拼接 、 删除、 替换、 比较、 截取、 查询
    // 拼接
//    NSString *string1 = @"123";
//    NSString *string2 = @"456";
//    NSString *resultString = [string1 stringByAppendingFormat:@"----%c%c%c", '4', '5', '6'];
//    NSLog(@"%@", resultString);
//    NSLog(@"%@", string1);
//    NSLog(@"%@", string2);
    
    // 查询
//    NSString *fileName = @"abcd.mov";
//    BOOL success = [fileName hasSuffix:@"omv"];
//    if (success) {
//        NSLog(@"find file success!");
//    }
//    else {
//        NSLog(@"find file failed!");
//    }
    
    // 字符串查询
//    NSString *string = @"abcdefg";
//    NSRange range = [string rangeOfString:@"BC"
//                                  options:NSCaseInsensitiveSearch];
//    // length == 0：表示找不到字符串
//    // location == NSNotFound：表示找不到字符串
//    if (range.location == NSNotFound) {
//        NSLog(@"not found!");
//    }
//    else {
//        NSLog(@"has the string");
//    }
//    
//    NSLog(@"%ld", NSNotFound);
    
    // 替换
//    NSString *string = @"abcde"; // cd -> CD
//    NSString *resultString = [string stringByReplacingCharactersInRange:NSMakeRange(10, 10)
//                                                             withString:@"CD"];
//    NSString *resultString = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
//    NSLog(@"%@", resultString);
    
    // 截取
//    NSString *string = @"abcde";
    // @"de";
    // substringFromIndex:按照截取索引
//    NSString *resultString = [string substringFromIndex:3];
    
    // @"abc"
    // substringToIndex:按照截取长度
//    NSString *resultString = [string substringToIndex:3];
//    NSLog(@"%@", resultString);
    
    // @"bcd"
//    NSString *resultString = [string substringWithRange:[string rangeOfString:@"bcd"]];
//    NSLog(@"%@", resultString);
    
    // @"abcde"  ->  @"ae"
    // 1:拼接
//    NSString *string = @"abcde";
//    NSString *prefixString = [string substringToIndex:1];
//    NSString *suffixString = [string substringFromIndex:[string rangeOfString:@"e"].location];
//    NSString *resultString = [prefixString stringByAppendingString:suffixString];
//    NSLog(@"%@", resultString);
    
    // 2:替换
//    NSString *string = @"abcde";
//    NSString *resultString = [string stringByReplacingOccurrencesOfString:@"bcd" withString:@""];
//    NSLog(@"%@", resultString);
    
    
    
    // 比较
//    NSString *string1 = @"099";
//    NSString *string2 = @"100";
//    if ([string1 isEqualToString:string2]) {
//        NSLog(@"they are the same!");
//    }
//    else {
//        NSLog(@"they are different!");
//    }
//    NSComparisonResult result = [string1 compare:string2 options:NSNumericSearch];
//    if (result == NSOrderedSame) {
//        NSLog(@"they are the same!");
//    }
//    else if (result == NSOrderedAscending) {
//        NSLog(@"string2 is bigger!");
//    }
//    else {
//        NSLog(@"string1 is bigger!");
//    }
    
    // NSString：不可变字符串对象
//    NSString *string = @"123456";
//    NSString *resultString = [string substringFromIndex:3];
//    NSLog(@"\nstring = %@\nresultString = %@", string, resultString);

    // NSMUtableString:可变字符串
    
    
    // NSDate:时间日期类
//    NSDate *date = [NSDate date];
//    NSLog(@"%@", date);

//    NSString *dateString = [NSDateFormatter localizedStringFromDate:[NSDate date]
//                                                          dateStyle:NSDateFormatterShortStyle
//                                                          timeStyle:NSDateFormatterShortStyle];
//    NSLog(@"%@", [NSDate date]);
//    NSLog(@"%@", dateString);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日 星期：EEEE HH时mm分ss秒"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSLog(@"%@", dateString);
    
    NSDate *date1 = [NSDate date];
    NSDate *date2 = [NSDate dateWithTimeIntervalSinceNow:-3600 * 5];
    if ([date1 compare:date2] == NSOrderedDescending) {
        // .....
        NSLog(@"date1 is later!");
    }
    
    
    return 0;
}






















