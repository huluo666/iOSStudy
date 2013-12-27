//
//  t5.c
//  exercise_1227
//
//  Created by Rimi07 on 13-12-27.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
/*
 
 5、打印出以下图形
 
 *
 **
 ***
 **
 *
 
 */

int print_triangle(int n)
{
    for (int i=1; i <= n/2+1; i++)
    {
        
        for (int j=1; j <= i; j++)
            printf("*");
        printf("\n");
        
    }
    
    for (int i=1; i <= n/2; i++)
    {
        for (int j=1; j <= n/2-i+1; j++)
            printf("*");
        printf("\n");
    }
    printf("\n");
    return 0;
}

int print_triangle2(int n)
{
    for (int i=1; i <= n/2+1; i++)
    {
        
        for (int j=1; j <= i; j++)
            printf("*");
        printf("\n");
        
    }
    
    for (int i=n/2; i >= 1; i--)
    {
        for (int j=1; j <= i; j++)
            printf("*");
        printf("\n");
    }
    printf("\n");
    return 0;
}

int exer5()
{
    printf("第5题:\n");
    print_triangle(5);
    print_triangle(8);
    print_triangle2(10);
    
    // Mr.wang's solution
    for (int i=0; i<5; i++)
    {
        if (i==0 || i== 4)
        {
            printf("*");
        }
        if (i==1 || i==3)
        {
            printf("**");
        }
        if (i==2)
        {
            printf("***");
        }
        printf("\n");
    }
    
    printf("-----------\n");
    // Mr.wang's solution 2
    for (int i=0; i<5; i++)
    {
        printf("*");
        if (i>=1 && i<=3)
        {
            printf("*");
        }
        if (i==2)
        {
            printf("*");
        }
         printf("\n");
    }
    return 0;
}

