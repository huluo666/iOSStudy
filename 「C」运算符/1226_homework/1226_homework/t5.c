//
//  t5.c
//  1226_homework
//
//  Created by Rimi07 on 13-12-26.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
#define LEN 5
/*
 5、	找出任意5个数中最大的数与最小的数的差值，并计算比差值大的数有几个。
*/

// 为了简单,我们假设这5个数都为整数
int getMax(int *arr, int len)
{
    int i;
    int max = *(arr+0);
    for (i=1; i<len; i++)
    {
        if (*(arr+i) > max)
        {
            int temp = *(arr+i);
            *(arr+i) = max;
            max = temp;
        }
    }
    return max;
}

int getMin(int *arr, int len)
{
    int i;
    int min = *(arr+0);
    for (i=1; i<len; i++)
    {
        if (*(arr+i) < min)
        {
            int temp = *(arr+i);
            *(arr+i) = min;
            min = temp;
        }
    }
    return min;
}

int getCount(int *arr, int len, int value)
{
    int count = 0, i;
//    for (i=0; i<len; i++)
//    {
//        printf("arr[%d]=%d ", i, arr[i]);
//    }
    
    for (i=0; i<len; i++)
    {
        if (*(arr+i) > value)
            count++;
    }

    return count;
}

int test5()
{
    printf("\n第五题:\n请输入%d个整数:", LEN);
    int arr[LEN], arr_2[LEN];
    int i, max, min, count;
    
    for (i=0; i<LEN; i++)
    {
        scanf("%d", &arr[i]);
        arr_2[i] = arr[i]; // 由于获取最大值和最小值的时候会改变数组中的值,故先copy一份.
    }
    
    max = getMax(arr, LEN);
    min = getMin(arr, LEN);
    printf("最大数与最小数的差值为:%d\n", max-min);
    
    count = getCount(arr_2, LEN, max-min);
    printf("比差值大的数有%d个\n\n", count);
    return 0;
}