//
//  t1.c
//  exercise_140106
//
//  Created by Rimi07 on 14-1-6.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#include <stdio.h>
//1、	任意的整型数组，如果小于均值的数比大于均值的多，成为“偏小数组”，反之称作“偏大数组”，如果相等，称作“均衡数组”，写一个函数，判定并输出任意数组的类型。

void determineType(int array[], int n)
{
    int avg = 0, less = 0, great = 0;
    for (int i=0; i<n; i++)
    {
        avg += array[i];
    }
    avg /= n;
    
    for (int i=0; i<n; i++)
    {
        if (array[i] > avg)
        {
            great++;
        }
        else
        {
            less++;
        }
    }
    
    if (less > great)
    {
        printf("该数组是偏小数组\n");
    }
    else if (less < great)
    {
         printf("该数组是偏大数组\n");
    }
    else
    {
         printf("该数组是均衡数组\n");
    }
}

int exer1()
{
    printf("第1题:\n");
    int array[] = {1, 3, 4, 8, 23, 89};
    determineType(array, 6);
    
    int array1[] = {4, 4, 4, 1, 2, 1};
    determineType(array1, 6);
    
    int array2[] = {4, 4, 4, 4, 2, 1};
    determineType(array2, 6);
    
    printf("\n\n");
    return 0;
    
}