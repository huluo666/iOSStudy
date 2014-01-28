//
//  t1.c
//  exercise_140104
//
//  Created by Rimi07 on 14-1-4.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
//1、	定义一个结构体，描述日期的年月日，然后写一个函数求今年任意2天的天数差

typedef struct
{
    int year;
    int month;
    int day;
} Date;

int getDaysByMonth(int month, int day)
{
    int sum = 0;
    switch (month)
    {
        case 12:
            sum += 30;
        case 11:
            sum += 31;
        case 10:
            sum += 30;
        case 9:
            sum += 31;
        case 8:
            sum += 31;
        case 7:
            sum += 30;
        case 6:
            sum += 31;
        case 5:
            sum += 30;
        case 4:
            sum += 31;
        case 3:
            sum += 28;
        case 2:
            sum += 31;
        case 1:
            sum += day;
        default:
            break;
    }
    return sum;
}

int getDaysInterval(Date d1, Date d2)
{
    int days1 = getDaysByMonth(d1.month, d1.day);
    int days2 = getDaysByMonth(d2.month, d2.day);
    return abs(days1-days2);
}

int exer1()
{
    printf("第1题:\n");
    Date d1 = {14, 3, 15};
    Date d2 = {14, 1, 5};
    
    int days = getDaysInterval(d1, d2);
    
    printf("相差%d天",days);
    
    printf("\n\n");
    
    return 0;
    
}