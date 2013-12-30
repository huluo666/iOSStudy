//
//  t3.c
//  exercise_1230
//
//  Created by Rimi07 on 13-12-30.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>

// 3、	使用数组描述正整数的二进制表示，如5，则数组为{1，0，1}
void print_arr(int *arr, int len);
void bub_sort(int *arr, int n);
int exer3()
{
    printf("第3题:\n");
    
    int number = 12;
    int arr[32] = {0};
    
    //提取每一位(注意顺序是倒的)
    for (int i=0; number>0; number = number >> 1, i++)
    {
        arr[i] = number&1;
        printf("%d", number&1);
    }
    printf("\n");
    print_arr(arr, 32);
    
    // 反转数组
    for (int i=0; i<32/2; i++)
    {
        int temp = arr[i];
        arr[i] = arr[31-i];
        arr[31-i] = temp;
    }
    print_arr(arr, 32);
    
    // 找到前面无效零的个数
    int p=0; // p记录无效零的个数
    while (p<32)
    {
        if (arr[p] != 0)
        {
            break;
        }
        p++;
    }
    
    // 将去除零后的数组copy出来
    int arr_2[32-p];
    int q=0;
    for (; p<32; q++)
    {
        arr_2[q] = arr[p];
        p++;
    }
    arr_2[q] = '\0';
//    printf("p=%d ", p);
//    printf("q=%d\n", q);
    
    // 打印结果
    print_arr(arr_2, q);

    printf("\n\n");
    return 0;
}