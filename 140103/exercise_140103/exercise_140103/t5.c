//
//  t5.c
//  exercise_140103
//
//  Created by Rimi07 on 14-1-3.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#include <stdio.h>
// 5、实现字符串比较函数，分别实现按ASCII比较和按数值比较，比如按ASCII比较，“123” < “123a”，按数值比较“123” = “123a”.

int strToDigit(const char * str) {
    int tmp;
    sscanf(str, "%d", &tmp);
    return tmp;
}

int strToDigit2(const char *str) //不会截掉非数字部分
{
    int tmp = 0;
    while (*str)
    {
        tmp *= 10;
        tmp += *str - '0';
        ++str;
    }
    return tmp;
}

int compareByASCII(const char *str1, const char *str2)  // > = < 分别对应 1,0,-1
{
    int val1 = strToDigit2(str1);
    int val2 = strToDigit2(str2);
    int ret  = 0;
    if (val1 != val2)
    {
       ret = val1>val2 ? 1:-1;
    }
    return ret;
}

int compareByValue(const char *str1, const char *str2) // > = < 分别对应 1,0,-1
{

    int val1 = strToDigit(str1);
    int val2 = strToDigit(str2);
    int ret  = 0;
    if (val1 != val2)
    {
        ret = val1>val2 ? 1:-1;
    }
    return ret;
}

void exer5()
{
    printf("第5题:\n");
    char *str1 = "123";
    char *str2 = "123a";
    
    printf("%d\n", compareByASCII(str1, str2));
    printf("%d\n", compareByValue(str1, str2));
    
    
    printf("\n");
}

// teacher's solution
/*
int strcmp_value(char *s1,char *s2)
{
    if (atoi(s1) < atoi(s2)) {
        return -1;
    } else if (atoi(s1) > atoi(s2)) {
        return 1;
    }
    return 0;
}
*/