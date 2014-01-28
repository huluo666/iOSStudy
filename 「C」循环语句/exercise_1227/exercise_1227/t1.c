//
//  t1.c
//  exercise_1227
//
//  Created by Rimi07 on 13-12-27.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
//1、	使用switch语句计算今年的某一天是今年的第几天
/*
 2013:
 1:31
 2:28
 3:31
 4:30
 5:31
 6:30
 7:31
 8:31
 9:30
 10:31
 11:30
 12:31
 */
int exer1()
{
    printf("第1题:\n");
    printf("请输入2013年某天日期(例如1227):");
    int date;
    scanf("%d", &date);
    int mon = date / 100;
    int day = date % 100;
    int num = 0;
    /*
    switch (mon)
    {
        case 1:
            num = day;
            break;
        case 2:
            num = 31+day;
            break;
        case 3:
            num = 31+28+day;
            break;
        case 4:
            num = 31+28+31+day;
            break;
        case 5:
            num = 31+28+31+30+day;
            break;
        case 6:
            num = 31+28+31+30+31+day;
            break;
        case 7:
            num = 31+28+31+30+31+30+day;
            break;
        case 8:
            num = 31+28+31+30+31+30+31+day;
            break;
        case 9:
            num = 31+28+31+30+31+30+31+31+day;
            break;
        case 10:
            num = 31+28+31+30+31+30+31+31+30+day;
            break;
        case 11:
            num = 31+28+31+30+31+30+31+31+30+31+day;
            break;
        case 12:
            num = 31+28+31+30+31+30+31+31+30+31+30+day;
            break;
    }
    */
    switch (mon)
    {
        case 12:
            num += 31;
        case 11:
            num += 30;
        case 10:
            num += 31;
        case 9:
            num += 30;
        case 8:
            num += 31;
        case 7:
            num += 31;
        case 6:
            num += 30;
        case 5:
            num += 31;
        case 4:
            num += 30;
        case 3:
            num += 31;
        case 2:
            num += 28;
        case 1:
            num += day;
        default:
            break;
    }
    
    printf("今天是2013年的第%d天\n", num);
    
    return 0;
}