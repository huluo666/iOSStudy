//
//  t5.c
//  exercise_1230
//
//  Created by Rimi07 on 13-12-30.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

// 5、	实现将任意数字字符串转换成int、float类型，“345”转成int类型345，“35.8”转换成float类型35.8。
int exer5()
{
    printf("第5题:\n");
    // 使用函数方法
    int t1 = atoi("345");
    printf("t1=%d\n", t1);
    
    float t2 = atof("35.8");
    printf("t2=%f", t2);
    
    
    printf("\n\n");
    return 0;
}
/*
 char s1[5] = "32.5";
 int m = 0;
 float m1 = 0;
 
 char s2[4] = {0};
 for (int i = 0; i<5; i++) {
 if (i<2) {
 s2[i] = s1[i];
 }
 if (i>2) {
 s2[i-1] = s1[i];
 }
 }
 
 int number = 0;
 int bit = 1;
 for (int i = 2; i>=0; i--) {
 number += (s2[i]-'0')*bit;
 bit *= 10;
 }
 m1 = number * 0.1;
 
 printf("%f  \n",m1);
 
 */