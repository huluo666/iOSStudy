//
//  t5.c
//  exercise_1228
//
//  Created by Rimi07 on 13-12-30.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
// 5、	有三中颜色的球，分别为红色3个，白色3个，蓝色6个，请问随机取出8个球共有多少种不同的组合。
int exer5()
{
    printf("第5题:\n");
    int count=0;
    for (int red=0; red<=3; red++)
    {
        for (int black=0; black<=3; black++)
        {
            for (int blue=0; blue<=6; blue++)
            {
                if (red+blue+black == 8)
                {
                    count++;
                }
//                printf("\n\n");
            }
        }
//        printf("\n");
    }
    printf("共%d方法", count);
    printf("\n\n");
    return 0;
}