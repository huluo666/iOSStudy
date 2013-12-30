//
//  t2.c
//  exercise_1230
//
//  Created by Rimi07 on 13-12-30.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>

#include <time.h>
// 2、	将任意2个int类型数组按从小到大排序，然后合并成一个新的从小到大的数组。

void bub_sort(int *arr, int n)
{
    int i, j;
    int flag = 0;        /*定义一个标志位*/
    
    for (i = 0; i < n-1; i++)        /*n-1趟排序*/
    {
        for (j = 0; j < n-i-1; j++)
        {
            if (arr[j] > arr[j+1]) /*若后面元素有比前面小的就交换*/
            {
                arr[j] = arr[j] + arr[j+1];
                arr[j+1] = arr[j] - arr[j+1];
                arr[j] = arr[j] - arr[j+1];
                flag = 1;        /*将标志位设置为1，表示交换过*/
            }
        }
        
        if (flag == 0) /*若没有发生过交换就结束算法*/
        {
            break;
        }
    }
    
    return ;
}

void print_arr(int *arr, int len)
{
    int i;
    for (i = 0; i < len; i++)
    {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

int exer2()
{
    int arr1[10] = {0}, arr2[10] = {0};
    // 产生数组
    for (int i=0; i<10; i++)
    {
        srand((unsigned)time(NULL));//初始化随机数
        arr1[i] = random()%30;
        arr2[i] = random()%30;
    }
    
    // 打印产生的数组
    printf("排序前:\n");
    print_arr(arr1, 10);
    print_arr(arr2, 10);
    
    // 排序
    bub_sort(arr1, 10);
    bub_sort(arr2, 10);
    
    printf("排序后:\n");
    print_arr(arr1, 10);
    print_arr(arr2, 10);
    
    //合并数组(先合并,再排序)
    int arr3[20] = {0};
    for (int i=0; i<20; i++)
    {
        if (i<10)
        {
             arr3[i] = arr1[i];
        }
        else
        {
            arr3[i]  = arr2[i];
        }
    }
    bub_sort(arr3, 20);
    printf("合并后:\n");
    print_arr(arr3, 20);
    printf("\n\n");
    return 0;
}