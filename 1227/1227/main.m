//
//  main.m
//  1227
//
//  Created by Rimi07 on 13-12-27.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

// 求个数的最大数
int test1()
{
    int a1=1, a2=2, a3=3, a4=4, a5=5;
    int max = a1;
    if (max < a2){
        max = a2;
    }
    if (max <a3){
        max = a3;
    }
    if (max < a4){
        max = a4;
    }
    if (max <a5){
        max = a5;
    }
    return max;
}

// 1-100所有奇数的和
int test2()
{
    int sum = 0;
    for (int i=1; i<100; i=i+2)
    {
        sum += i;
    }
    return sum;
}

int test21()
{
    int sum = 0;
    for (int i=0; i<100; i++)
    {
        if (i%2)
            sum += i;
    }
    printf("%d\n", sum);
    return sum;
}

// 求出所有100以内包含3的数
int test3()
{
    printf("100以内包含3的数为:");
    for (int i=3; i<100; i++)
    {
        if (i%10 == 3 || i/10 == 3)
            printf("%d ", i);
    }
    return 0;
}

int test31()
{
    for (int i=0; i<10; i++)
    {
        if (i != 3)
            printf("%d ", 30+i);
        printf("%d ", i*10+3);
    }
    printf("\n");
    return 0;
}

// 1/2 + 1/4 + 1/8 + ... + 1/128
int test4()
{
    float sum = 0;
    for (int i=2; i<=128; i*=2)
    {
        sum += 1.0f/i;
    }
    printf("sum=%f\n", sum);
    return 0;
}


// 求任意正整数的二进制(注意,倒过来看)
int test5()
{
    int number = 10001;
    for (int i=0; i<32;i++)
    {
        printf("%d", (number >> i)&1);
    }
    printf("\n");
    return 0;
}

int test51()
{
    int number = 10001;
    for (; number>0; number = number >> 1)
    {
        printf("%d", number&1);
    }
    printf("\n");
    return 0;
}

// break continue 区别

int main(int argc, const char * argv[])
{
    int max = test1();
    printf("the max number is:%d\n", max);

    int sum = test2();
    printf("1到100所有奇数和为:%d\n", sum);
    test21();
    test3();
    test31();
    test4();
    test5();
    test51();
    return 0;
}

