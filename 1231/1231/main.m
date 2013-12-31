//
//  main.m
//  1231
//
//  Created by Rimi07 on 13-12-31.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
// argc 程序启动时命令个数 argv,所有字符串

int getMax(int a, int b)
{
    return a>b ? a:b;
}

int getMax3(int a, int b, int c)
{
    return a>b ? (a>c ? a:c):(b>c ? b:c);
}

int maxa2f(int a, int b, int c, int d, int e, int f)
{
    return getMax3(getMax(a, b), getMax(c, d), getMax(e, f));
}

// 求空间中任意两点间的距离
float distance(int x1, int y1, int z1, int x2, int y2, int z2)
{

    return sqrtf(powf(x1-x2, 2) + powf(y1-y2, 2) + powf(z1-z2, 2));
}

// 合并数组
int mergeArray(int arr1[], int n, int arr2[], int m, int destArr[]); /*a[m]+b[n]=c[m+n]*/

// 整型数组的元素的平方和
int powSum(int *arr, int n)
{
    int sum = 0;
    for (int i=0; i<n; i++)
    {
        sum += pow(*(arr+i), 2);
    }
    return sum;
}

// 字符串返回值
char *append(char s1[], char s2[], char s3[])
{
    return strcat(strcat(s1, s2), s3);
}

int main(int argc, const char * argv[])
{
    
    // 函数
    // 重用 调用 模块化
    
    printf(""); // 库函数(蓝色)
    strcpy(""  , ""); // 宏定义
    
    // 第三方函数
    
    // 自定义函数
    
    // 函数要点:返回值, 函数名, 形参, 实现
    //    int max(int a, int b);
    
    
    int a = 2, b=1, c=7;
    int max = getMax3(a, b, c);
    printf("max=%d\n", max);
    
    
//    fabsf(<#float#>); //开方
//    powf(<#float#>, <#float#>) // 次方
//    sqrtf(<#double#>); // 绝对值
    
    // 求空间中任意两点间的距离
    
    int d=4, e=6, f=9;
    printf("dist=%f \n", distance(a, b, c, d, e, f));
    
    
    return 0;
}

