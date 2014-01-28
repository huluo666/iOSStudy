//
//  main.m
//  OCExercise140112
//
//  Created by cuan on 14-1-11.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"
/*
 
 1.	将字符串中的数字去掉，字母转为大写：@“0go08o32d”；
 2.	写一个方法，计算任意一个身份证号对应的出生年月；
 3.	写一个方法，将输入的NSString类型的字符串数值变为相反数字符串后返回，如传入@“1”，返回@“-1”；
 4.	写一个方法输入的字符是否包含数字0，不包含输出@“false”，包含输出其所在位置（多个输出第一个）；
 5.	使用NSDate计算，1970年以后的任意两天之间相隔多少天。
 
*/
int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        // 1
        NSString *string = [NSString stringWithFormat:@"0go08o32d"];
//        string = [[[[string stringByReplacingOccurrencesOfString:@"0" withString:@""] stringByReplacingOccurrencesOfString:@"8" withString:@""] stringByReplacingOccurrencesOfString:@"32" withString:@""] uppercaseString];
        for (int i=0; i<9; i++)
        {
            NSString *tempString = [NSString stringWithFormat:@"%d",i];
            string = [string stringByReplacingOccurrencesOfString:tempString withString:@""];
        }
        NSLog(@"%@",string);
        
        // 2
        NSString *IDString = [NSString stringWithFormat:@"513030199108231623"];
        NSLog(@"生日是：%@", [Utils getBirthByIDString:IDString]);
        
        //
        NSString *stringNumber = [NSString stringWithFormat:@"1"];
        NSLog(@"%@", [Utils getStringOppositeNumber:stringNumber]);
        
        // 4
        NSString *string2 = [NSString stringWithFormat:@"1adla0akfelew0ald200"];
        [Utils printStringIsContainsNumberZero:string2];
        
        // 5
        NSString *aDay      = @"19920810"; // 格式规定了只能写这种，不要乱写
        NSString *otherDay  = @"20130112";
        NSLog(@"%@与%@相差%ld天",aDay, otherDay, [Utils daysIntervalSinceDay:aDay fromDay:otherDay]);
    }
    return 0;
}


