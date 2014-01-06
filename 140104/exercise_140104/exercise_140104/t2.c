//
//  t2.c
//  exercise_140104
//
//  Created by Rimi07 on 14-1-4.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

//2、分别使用2种结构体描述矩形，写一个函数计算任意2个矩形的面积差。然后思考如下问题：如何描述视图上的三维的三角形、立方体。
typedef struct
{
    int width;
    int heigth;
} Rect;

typedef struct
{
    int x;
    int y;
} Pointer;

typedef struct
{
    Pointer p1;
    Pointer p2;
} Rectangle;


double areaDivide(Rect r1, Rect r2)
{
    return abs(r1.heigth*r1.width - r2.heigth*r2.width);
}

double areaDivide2(Rectangle r1, Rectangle r2)
{
    
    return abs((r1.p1.x - r2.p1.y)*(r1.p2.x-r2.p2.y) - (r2.p1.x - r2.p1.x)*(r2.p2.x-r2.p2.y));
}

int exer2()
{
    printf("第2题:\n");
    
    // 1.
    Rect r1 = {12, 23};
    Rect r2 = {8, 43};
    double div = areaDivide(r1, r2);
    printf("面积差是：%f\n", div);
    
    // 2.
    Rectangle r3 = {1, 3, 2, 7};
    Rectangle r4 = {5, 2, 4, 9};
    div = areaDivide2(r3, r4);
    printf("面积差是：%f\n", div);
    printf("\n");
    
    return 0;
    
}