//
//  2.c
//  1226_homework
//
//  Created by Rimi07 on 13-12-26.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
/*
 第2题:计算下列语句执行后变量的值，思考它的执行并与打印结果比较：
 int a = 0；
 a = a+++--a；
 
 int a = 1, b = 3；
 a += b %= 2；
 
 int a = 1,b = 4;
 a = ++b/a++;
*/

int test21()
{
    int a = 0;
    a = a+++--a; // 等价于下面一行注释了的代码
    //a = (a++) + (--a);
    printf("%d\n", a);
    return 0;
}

int test22()
{
    int a = 1, b = 3;
    a += b %= 2;
    /*
     分析:
     1, 执行 b %= 2; 即 b = b%2; 执行完后a=1, b=1
     2, 执行 a += b; 即 a = a+b; 执行完后a=2, b=1
     */
    printf("a=%d, b=%d\n", a, b);
    return 0;
}

int test23()
{
    int a = 1,b = 4;
    a = ++b/a++;
    /*
     分析:
     1, ++, -- 优先级大于 /,先执行
     2, 先执行"="右边部分,即 5/1, 执行完后 a=2, b=5
     3, 执行a=5,执行完后,a=5, b=5
     */
    printf("a=%d, b=%d\n", a, b);
    return 0;
}
int test2()
{
    printf("第二题:\n");
    test21();
    printf("---------------------\n");
    test22();
    printf("---------------------\n");
    test23();
    printf("---------------------\n\n");
    return 0;
}