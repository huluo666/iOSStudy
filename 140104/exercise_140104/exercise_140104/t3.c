//
//  t3.c
//  exercise_140104
//
//  Created by Rimi07 on 14-1-4.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#include <stdio.h>
// 3、使用结构体描述电话簿中的联系人信息，并将其按名称首字母排序。假定联系人均为英文开头。

typedef struct
{
    char *name;
    char *number;
} Person;


int compareByASCII(const char *str1, const char *str2)
{
    int sum1 = 0;
    int sum2 = 0;
    while (*str1++)
    {
        sum1 += *str1;
    }
    while (*str2++)
    {
        sum2 += *str2;
    }
    
    int ret = 0;
    if (sum1 != sum2)
    {
        ret = sum1>sum2 ? 1:-1;
    }
    
    return ret;
}

int exer3()
{
    printf("第3题:\n");
    
    
    
    printf("\n");
    
    return 0;
    
}