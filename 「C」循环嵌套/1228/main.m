//
//  main.m
//  1228
//
//  Created by Rimi07 on 13-12-28.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{
    // 循环嵌套,条件不要多加.
    int score = 90;
    if (score <60)
    {
        printf("");
    }
    else if (score < 70)
    {
        
    }
    else if (score <80)
    {
        
    }
    else
    {
        
    }
    
    // 求最小公倍数(18 39 111 128)
    int i;
    for (i=1; i<18*39*111*128; i++)
    {
        if (i%128==0 &&
            i%111==0 &&
            i%39==0 &&
            i%18==0)
        {
            printf("%d\n", i);
            break;
        }
    }
    
    int a = 0;
    while (a<4)
    {
        int b = 0;
        while (b<4)
        {
            printf("i=%d,j=%d\n" ,a ,b);
            b++;
        }
        
        a++;
    }
    
    printf("\n\n\n" );
    a = 0;
    while (a<4)
    {
        for (int b=0; b<4; b++)
        {
            printf("i=%d,j=%d\n" ,a ,b);
        }
        a++;
    }
    
    // 1-100非素数的和
    int sum = 1;
    for (i=2; i<=100; i++)
    {
        BOOL is =  YES;
        for (int j=2; j<=i-1; j++)
        {
            if (i%j==0)
            {
                is = NO;
            }
        }
        if (!is)
        {
            sum += i;;
        }
    }
    printf("非素数的和为:%d\n", sum);
    
    
    // 多层循环 3层以上
    
    //1,2,3,4能组成多少个不含重复数字的3位数
    /*
    int p =0;
    for (i=1; i<=4; i++)
    {
        for (int j=1; j<=4; j++)
        {
            for (int k=1; k<=4; k++)
            {
                if (!(i==j || i==k || j==k))
                {
                    p++;
                    printf("%d%d%d\n", i, j, k);
                }
            
            }
        }
    }
    printf("共%d个\n",p);
     */
    int p =0;
    for (i=1; i<=4; i++)
    {
        for (int j=1; j<=4; j++)
        {
            if (i==j)
            {
                continue;
            }
            for (int k=1; k<=4; k++)
            {
                if (j==k)
                {
                    continue;
                }
                if (i!=k)
                {
                    p++;
                    printf("%d%d%d\n", i, j, k);
                }
                
            }
        }
    }
    printf("共%d个\n",p);
    
    // a,b 在1-100, a*b>2500, a+b为最小
    for (int i=1; i<=100; i++)
    {
        for (int j=1; j<=100; j++)
        {
            if (i*j>2500 && i+j>100)
            {
                ;
            }
        }
    }
    
    return 0;
    
}

