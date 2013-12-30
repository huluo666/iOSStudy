//
//  t1.c
//  exercise_1228
//
//  Created by Rimi07 on 13-12-30.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
//  1、	打印9 9乘法表
int exer1()
{
    printf("第1题:\n");
    for (int i=1; i<=9; i++)
    {
        for (int j=1; j<=i; j++)
        {
            printf("%d*%d=%d ", i, j, i*j);
        }
        printf("\n");
    }
    printf("\n\n");
    return 0;
}