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
    int arr[3][4] = {0};
    
    // 初始化数组
    for (int i=0; i<3; i++)
    {
        printf("\n");
        for (int j=0; j<4; j++)
        {
            arr[i][j] = rand()%50;
            printf("%d ", arr[i][j]);
        }
    }

    // 找鞍点

    
    
    printf("\n\n");
    return 0;
}