//
//  t2.c
//  exercise_140103
//
//  Created by Rimi07 on 14-1-3.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// 2、	使用指针判定一个int类型数组中一共有多少个数字3.比如{3，31，2，133}一共有4个3。

void exer2()
{
    printf("第2题:\n");
    
    int array[] = {3, 31, 2, 133};
    
    char *string = malloc(sizeof(int)*4+1);
    
    for (int i=0; i<4; i++)
    {
        sprintf(string, "%s%d", string, array[i]);
    }
    
    int count =0;
    for (int i=0; i<strlen(string); i++)
    {
        if (*(string+i) == '3')
        {
            count++;
        }
    }
    
    printf("3的个数为：%d",  count);
    free(string);
    
    printf("\n");
}