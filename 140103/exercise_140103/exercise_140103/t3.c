//
//  t3.c
//  exercise_140103
//
//  Created by Rimi07 on 14-1-3.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

// 3、	一个班有15名同学编号0-14，成绩分别为50-90分不等，将这些同学的编号按照60分及格，80分优秀的标准分别分配到不及格、及格、优秀3个数组中。
void exer3()
{
    printf("第3题:\n");
    int grade[15] = {12, 96, 98, 56, 80, 67, 89, 23, 79, 88, 86, 67, 39, 99, 78};
    int failCount = 0;
    int passCount = 0;
    int greatCount = 0;
    
    for (int i=0; i<15; i++)
    {
        if (*(grade+i) < 60)
        {
            failCount++;
        }
        if (*(grade+i) > 80)
        {
            greatCount++;
        }
    }
    passCount = 15 - failCount - greatCount;
//    printf("count=%d\n", passCount);
//    printf("count=%d\n", failCount);
//    printf("count=%d\n", greatCount);
    
    int *pass = malloc(passCount*sizeof(int));
    int *fail =  malloc(failCount*sizeof(int));
    int *great = malloc(greatCount*sizeof(int));
    
    int *p = pass, *f = fail, *g = great;

    for (int i=0; i<15; i++)
    {
        if (*(grade+i) < 60)
        {
            *(f++) = *(grade+i);
        }
        else if (*(grade+i) > 80)
        {
            *(g++) = *(grade+i);
        }
        else
        {
            *(p++) = *(grade+i);
        }
    }
    
    printf("未及格：\n");
    for (int i=0; i<failCount; i++)
    {
        printf("%d ", *fail++);
    }
    
    printf("\n");
    printf("及格：\n");
    for (int i=0; i<passCount; i++)
    {
        printf("%d ", *pass++);
    }
    printf("\n");
    printf("优秀：\n");
    for (int i=0; i<passCount; i++)
    {
        printf("%d ", *great++);
    }
    
    
    printf("\n\n");
}