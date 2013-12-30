//
//  t3.c
//  exercise_1228
//
//  Created by Rimi07 on 13-12-30.
//  Copyright (c) 2013年 cuan. All rights reserved.
//
/*
3、打印出以下图形，并且每次最多打印一个字符
 
  *
 ***
*****
 ***
  *
 
 */
#include <stdio.h>
int exer3()
{
    printf("第3题:\n");
    int n=5;
    int i,j;
    for(i=1;i<=n/2+1;i++) //先打印上半部分，如果奇数输入的是5，那么上面就会显示3行，以此类推
    {
        for(j=1;j<=n-i;j++) //打印空格
        {
            printf(" ");
        }

        for(j=1;j<=2*i-1;j++)//打印星星
        {
            printf("*");
        }
        printf("\n");
    }
    
    for(i=n/2;i>=1;i--) //n已经明确了，打印下半部分，如果n为5，那么下半部分显示两行，以此类推
    {
        for(j=1;j<=n-i;j++) //打印空格
        {
            printf(" ");
            
        }
  
        for(j=1;j<=2*i-1;j++)//打印星星
        {
            printf("*");
        }
        
        printf("\n");
    }
    printf("\n\n");
    return 0;
}