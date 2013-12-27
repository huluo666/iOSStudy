//
//  t3.c
//  exercise_1227
//
//  Created by Rimi07 on 13-12-27.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
#include <math.h>

/*
 3、打印出所有的“水仙花数”，所谓“水仙花数”是指一个三位数，其各位数字立方和等于该数本身。例如 153是一个水仙花数，因为153=13 +53 +33，要求用一重循环 1 + 125 + 27
 */

int exer3()
{
    printf("第3题:\n");
    int hundreds, decade, unit;
    for (int i=100; i< 1000; i++)
    {
        hundreds = i / 100;
        decade   = i % 100 / 10;
        unit     = i % 100 % 10;
        
        if ((pow(hundreds, 3)+pow(decade, 3)+pow(unit, 3)) == i)
        {
            printf("%d ", i);
        }
    }
    printf("\n");
    return 0;
}