//
//  t1.c
//  exercise_140103
//
//  Created by Rimi07 on 14-1-3.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#include <stdio.h>
// 1、	实现使用指针将一个int数组冒泡法排序
void bub_sort(int *arr, int n)
{
    int i, j;
    int flag = 0;        /*定义一个标志位*/
    
    for (i = 0; i<n-1; i++)        /*n-1趟排序*/
    {
        for (j = 0; j<n-i-1; j++)
        {
            if (*(arr+j) > *(arr+j+1)) /*若后面元素有比前面小的就交换*/
            {
                *(arr+j) = *(arr+j) + *(arr+j+1);
                *(arr+j+1) = *(arr+j) - *(arr+j+1);
                *(arr+j) = *(arr+j) - *(arr+j+1);
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
    for (int i = 0; i < len; i++)
    {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

void exer1()
{
    printf("第1题:\n");
    int a[5] = {1, 5, 2, 9, 11};
    printf("排序前：\n");
    print_arr(a, 5);
    bub_sort(a, 5);
    printf("排序后：\n");
    print_arr(a, 5);
    printf("\n");
}