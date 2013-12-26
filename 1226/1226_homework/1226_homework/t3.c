//
//  t3.c
//  1226_homework
//
//  Created by Rimi07 on 13-12-26.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>

/*
  3、	打印各种数据类型所占内存字节
*/
int test3()
{
    printf("第三题:\n");
    printf("char=%ld\n", sizeof(char));
    printf("short=%ld\n", sizeof(short));
    printf("int=%ld\n", sizeof(int));
    printf("long=%ld\n", sizeof(long));
    printf("float=%ld\n", sizeof(float));
    printf("double=%ld\n", sizeof(double));
    printf("void=%ld\n", sizeof(void));
    printf("pointer=%ld\n\n", sizeof(char *));
    return 0;
}

