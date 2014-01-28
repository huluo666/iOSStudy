//
//  main.m
//  140106
//
//  Created by Rimi07 on 14-1-6.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct _Student
{
    char *name;
    char *number;
} Student;

void findMaxLengthStirng(char *str[], int n)
{
    int count = 0, max = 0;
    char *temp = NULL;
    for (int i=0; i<n; i++)
    {
        
        for (int j=0; j<strlen(str[i]); j++)
        {
            count++;
        }
        if (count > max) {
            max = count;
            temp = str[i];
        }
         
    }
    printf("%s\n", temp);
}

// tercher's solution
char *maxString(char *str[], int n)
{
    char *maxString = str[0];
    for (int i=0; i<n; i++)
    {
        if (strlen(maxString) < strlen(str[i]))
        {
            maxString = str[i];
        }
    }
    return maxString;
}



int js(int n)
{
    if (n>1)
    {
        n = js(n-1)*n;
    }
    return n;
}

// 将8个字符串拼接成一个字符串
char *append(char *s1, char *s2)
{
    char *s = malloc(strlen(s1)+strlen(s2)+1);
    sprintf(s, "%s%s", s1, s2);
    return s;
}

char *append8(char *str[], int n)
{
    int count = 0;
    for (int i=0; i<8; i++)
    {
        count = (int) strlen(str[i]);
    }
    char *s = malloc(count+1);

    s = append(append(append(str[0], str[1]), append(str[2], str[3])), append(append(str[4], str[5]), append(str[6], str[7])));
    return s;
}

int main(int argc, const char * argv[])
{
    
    int sum = js(3);
    printf("%d\n", sum);
    
    /*
    Student *stu = malloc(sizeof(Student));
    stu->name = "Lucy";
    stu->number = "124";
    */
    
    // 算法
    
    // 数据
    // 逻辑
    // 权限
    
    // 原则：
    // 有穷 有效 可行 确定
    // 0个或者多个输入
    // 1个或者多个输出
    
    // 迭代
    // 批量中求最值
    // 求一个数的二进制
    /*
    int n = 10001;
    for (; n>0; n=n>>1) {
        printf("%d", n&1); // 倒序的
    }
    */
    
    // 求字符数组中最长的字符串
    char *b[] = {"12", "ab", "c", "1234"};
    findMaxLengthStirng(b, 4);
    
    printf("%s\n", maxString(b, 4));

    //
    /*
     
      *
     ***
    *****
     ***
      *
     行数： 0 1 2 3 4
     *个数：1 3 5 3 1
     关系式：j=2*i+1(i<3) j=9-2*i(i>=3)
     空格个数： 2 1 0 1 2
     关系式：j=2-i, j=i-2
     */
    
    //.
    for (int i=0; i<3; i++)
    {
        for (int j=0; j<2*i+1; j++)
        {
            printf("*");
        }
        printf("\n");
    }
    
    for (int i=3; i<5; i++)
    {
        for (int j=0; j<9-2*i; j++)
        {
            printf("*");
        }
        printf("\n");
    }
    
    //.
    printf("\n");
    for (int i=0; i<5; i++)
    {
        int num = i<3 ? 2*i+1:9-2*i;
        int num2 = fabs(2-i);
        
        for (int j = 0; j<num2; j++)
        {
            printf(" ");
        }
        
        for (int j=0; j<num; j++)
        {
            printf("*");
        }
        printf("\n");
    }
    
    //.
    printf("\n");
    int n=5;
    for (int i=0; i<n; i++)
    {
        int num = i<(n/2+1) ? 2*i+1:(2*n-1)-2*i;
        int num2 = fabs(n/2-i);
        
        for (int j=0; j<num2; j++)
        {
            printf(" ");
        }
        for (int j=0; j<num; j++)
        {
            printf("*");
        }
        printf("\n");
    }

    
    // 穷举
    // 逻辑性、可能性、是否
    // 求素数
    
    
    
    // 递归
//    js(5);
    
    
    
    // 分治
//    max(max(a, b) max(c, d));
    // 函数，将8个字符串拼接成一个字符串
    
    // 贪心
//    2.88元钱
    
    
    
    
    
    
    
    
    
    
    
    
    return 0;
}

