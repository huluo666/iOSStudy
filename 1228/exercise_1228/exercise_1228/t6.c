//
//  t6.c
//  exercise_1228
//
//  Created by Rimi07 on 13-12-30.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
// 6、	使用0 1 2 3 4这5个数字，共能组成多少个不含重复数字的3位数、4位数。
int exer6()
{
    printf("第6题:\n");
    int count = 0;
    // 三位数
    for (int i=1; i<=4; i++)
    {
        for (int j=0; j<=4; j++)
        {
            for (int k=0; k<=4; k++)
            {
                if (i!=j && j!= k && k!=i)
                {
                    count++;
                    printf("%d%d%d ", i, j, k);
                }
            }
        }
    }
    printf("三位数共有:%d个\n\n", count);
    
    // 四位数
    count = 0;
    for (int i=1; i<=4; i++)
    {
        for (int j=0; j<=4; j++)
        {
            for (int k=0; k<=4; k++)
            {
                for (int m=0; m<=4; m++)
                {
                    if (i!=j && j!= k && k!=m && m!=i)
                    {
                        count++;
                        printf("%d%d%d%d ", i, j, k, m);
                    }
                }
            }
        }
    }
    printf("四位数共有:%d个\n\n", count);
    
    // 三位数,优化算法
    count = 0;
    for (int i=1; i<=4; i++)
    {
        for (int j=0; j<=4; j++)
        {
            if (i==j)
            {
                continue;
            }
            for (int k=0; k<=4; k++)
            {
                if (j==k || i==k)
                {
                    continue;
                }
//                if (i!=j && j!= k && k!=i)
//                {
                    count++;
                    printf("%d%d%d ", i, j, k);
//                }
            }
        }
    }
    printf("三位数共有:%d个\n\n", count);
    printf("\n\n");
    return 0;
}

// teacher's soulution
void t6t()
{
    for (int i = 1; i<5; i++) {
        for (int j = 0; j<5; j++) {
            if (i == j) {
                continue;
            }
            for (int k = 0; k<5; k++) {
                if (i == k || j == k) {
                    continue;
                }
                for (int l = 0; l<5; l++) {
                    if (i != l && j != l && k != l) {
                        printf("%d%d%d%d\n",i,j,k,l);
                    }
                }
            }
        }
    }
}