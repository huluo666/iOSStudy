//
//  t4.c
//  exercise_1227
//
//  Created by Rimi07 on 13-12-27.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
//4、已知abc+cba=1333，其中a,b,c均为一位数，编程求出满足条件的a,b,c所有组合

/*
 abc+cba = 1333;
 int a,b,c;
 100a + 10b + c + 100c + 10b + a = 1333;
 101(a+c) + 20b = 1333;
 
 1333 % 20 = 101(a+c)
 1333 % 20 >= 101, b=1333/20
 (1333-20b)%101 == 0
 
 */

int exer4()
{
    printf("第4题:\n");
    for (int b=0; (1333-20*b) >= 101; b++)
    {
        if ((1333-20*b) % 101 == 0)
        {
            int a, c;
            for (a=0; a<10; a++)
            {
                c = (1333-20*b) / 101 -a;
                if (c >=0 && c<10)
                {
                    printf("a=%d ",a);
                    printf("b=%d ",b);
                    printf("c=%d\n",c);
                }
            }
        }
    }
    return 0;
}