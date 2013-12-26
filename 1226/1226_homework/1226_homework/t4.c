//
//  t4.c
//  1226_homework
//
//  Created by Rimi07 on 13-12-26.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
//
//  t4.c
//  1226_homework
//
//  Created by Rimi07 on 13-12-26.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
#define PI 3.14

/*
 4、	计算长方形，圆的周长和面积
 */

int test4()
{
    int a = 3, b =4, r = 6;
    printf("第四题:\n");
    printf("已知长方形的长为%d,宽为%d,圆形的半径为%d,则\n", a, b, r);
    printf("长方形的周长为%d\n", 2*(a+b));
    printf("长方形的面积为%d\n", a*b);
    printf("圆形的周长为%f\n", 2*PI*r);
    printf("圆形的面积为%f\n", PI*r*r);
    return 0;

}
