//
//  t6.c
//  1226_homework
//
//  Created by Rimi07 on 13-12-26.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
/*
 6、	实现将一个unsigned char类型左移N位，但是其后不补0，而是补上从左侧移除的0或1（先计算N<8）。
*/

int shift(unsigned char num, int n)
{
    int digit = 8*sizeof(unsigned char);
    n %= digit;
    unsigned char result = (num << n) | (num >> (digit-n)); // (num << n) + (num >> (digit-n))
    return result;
}

int test6()
{
    printf("\n\n第六题:\n");
    int n = 1;
    unsigned char num = 211; // 1101 0011
    unsigned char result  = shift(num, n); // 1101 0011 左移一位 101 0011 1 (167)
    printf("%d按要求左移%d位后结果为:%d\n", num, n, result);
    
    n=2;
    result = shift(num, n); // 1101 0011 左移二位 01 0011 11 (79)
    printf("%d按要求左移%d位后结果为:%d\n", num, n, result);
        
    n=3;
    result = shift(num, n); // 1101 0011 左移三位 1 0011 110 (158)
    printf("%d按要求左移%d位后结果为:%d\n", num, n, result);

    n=8;
    result = shift(num, n);
    printf("%d按要求左移%d位后结果为:%d\n", num, n, result);
    
    n=9; // 相当于左移1位
    result = shift(num, n);
    printf("%d按要求左移%d位后结果为:%d\n", num, n, result);
    return 0;
}