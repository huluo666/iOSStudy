//
//  t9.c
//  exercise_1230
//
//  Created by Rimi07 on 13-12-30.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
//9、	计算以下字符串数值的和{“123”，“003”，“1a23”，“456abc”}。字母前的数字为有效数值，如1a23的值为1，12a3的值为12。

int strToDigit(char * str)
{
    int tmp;
    sscanf(str, "%d", &tmp);
    return tmp;
}

int exer9()
{
    printf("第9题:\n");
    char *a = "123";
    char *b = "003";
    char *c = "1a23";
    char *d = "456abc";
    
    int sum = (int)(atol(a)+ atol(b)+ atol(c)+ atol(d));
    printf("%d\n", sum);

    sum = strToDigit(a)+strToDigit(b)+strToDigit(c)+strToDigit(d);
    
    printf("sum=%d\n", sum);
    printf("\n\n");
    return 0;
}