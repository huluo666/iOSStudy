//
//  t6.c
//  exercise_1230
//
//  Created by Rimi07 on 13-12-30.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
//6、	找出一个二维数组中的“鞍点”，即该位置上的元素在该行中最大，在该列中最小（也可能没有“鞍点”）



int exer6()
{
    printf("第6题:\n");
    
    const int n=4,m=5;   // 假设数组为4行5列
    int a[n][m] = { 6, 9, 9, 2, 7,
                    4, 9, 5, 4, 2,
                    9, 9, 8, 7, 9,
                    7, 8, 4, 5, 6};
    
    int i, j, max, maxj;
    int flag = 0; // 标记是否有鞍点存在
    
    /*
    // 输入数组元素
    for(i=0;i<n;i++)
    {
        for(j=0;j<m;j++)
        {
           scanf("%d", &a[i][j]);
        }
    }
    */
    
    // 输出矩阵
    for(i=0;i<n;i++)
    {
        for(j=0;j<m;j++)
        {
            printf("%d ", a[i][j]);
        }
        printf("\n");
    }

    for(i=0;i<n;i++)   // 开始时，假设a[i][0]最大，将列号（0）赋给maxj保存
    {
        max  = a[i][0];
        maxj = 0;
        
        for(j=0; j<m; j++)    // 找出第i行中的最大数
        {
            if(max < a[i][j])
            {
                max=a[i][j];  // 将本行的最大数存放在max中
                maxj=j;       // 将最大数所在的列号存放在maxj中
            }
        }
        
        flag = 1;    // 先假设是鞍点，用1为真来代表
        for(int k=0; k<n; k++)
        {
            if(max > a[k][maxj])  // 将最大数和其同分裂元素相比
            {
                flag = 0;         // 如果max不是同列最小，表示不是鞍点，令flag为假
                continue;
            }
        }
        
        if(flag) // 如果flag为真（1）表示是鞍点
        {
            printf("鞍点：a[%d，%d] 值为：%d", i, maxj, max);    // 输出鞍点的所在的行号和列号以及其值
            break;
        }
    }
    
    if(!flag)  //如果flag为假，表示鞍点不存在
    {  
        printf("鞍点不存在\n");
    }
    
    printf("\n\n");
    return 0;
}