//
//  t4.c
//  exercise_1228
//
//  Created by Rimi07 on 13-12-30.
//  Copyright (c) 2013年 cuan. All rights reserved.
//


/*
 
 4、两位数13和62具有很有趣的性质把它们个位数字和十位数字对调，其乘积不变，即13*62 31*26。编程序求共有多少对这种性质的两位数个位与十位相同的不在此列，如11、22，重复出现的不在此列，如 13*62与62*13 
*/
#include <stdio.h>
int exer4()
{
    printf("第4题:\n");
    for (int i=10; i<100; i++)
    {
        for (int j=10; j<100; j++)
        {
            if ((i%10*10+i/10)*(j%10*10+j/10)==i*j &&
                i%10!=i/10 && j%10!=j/10)
            {
                printf("i=%d, j=%d\n", i, j);
            }
        }
    }
    printf("\n\n");
    return 0;
}