//
//  t1.c
//  exercise_1230
//
//  Created by Rimi07 on 13-12-30.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
// 1、	随机产生20个100-200之间的正整数存放到数组中，并求数组中的所有元素最大值、最小值、平均值，然后将各元素的与平均值的差组成一个新数组。
int exer1()
{
    
    printf("第1题:\n");

    // 产生数组
    int arr[20] = {0}, arr_new[20] = {0};
    for (int i=0; i<20; i++)
    {
        arr[i] = rand()%101+1;
    }
    
    int sum = 0;
    // 打印产生的数组
    printf("产生的数组为:\n");
    for (int i=0; i<20; i++)
    {
        printf("%d ", arr[i]);
        sum += arr[i];
    }
    int mid = sum/20;
    
    int max = arr[0];
    int min = arr[0];
    for (int i=0; i<20; i++)
    {
        if (max < arr[i])
            max = arr[i];
        if (min > arr[i])
            min = arr[i];
    }
    
    // 打印最值和平均值
    printf("\nmax=%d, min=%d, mid=%d\n", max, min, mid);
    
    // arr_new
    for (int i=0; i<20; i++)
    {
        arr_new[i] = arr[i] - mid;
    }
    
    // 打印新数组
    printf("新数组:\n");
    for (int i=0; i<20; i++)
    {
        printf("%d ", arr_new[i]);
    }
    printf("\n\n");
    
    return 0;
}
