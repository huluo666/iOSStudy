//
//  t2.c
//  exercise_1228
//
//  Created by Rimi07 on 13-12-30.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
// 2、	求1000以内并且每一位数均不为3的素数
int exer2()
{
    printf("第2题:\n");
    for (int i=2; i<=1000; i++)
    {
        int flag = 1;
        for (int j=2; j<=i-1; j++)
        {
            if (i%j == 0)
            {
                flag = 0;
            }
        }
        if (flag && i/100!=3 && i/10%10!=3 &&i %10!=3)
        {
            printf("%d ", i);
        }
    }
    printf("\n\n");
    return 0;
}


// teacher's solution
/*
if (i/100==3 && i/10%10==3 &&i %10==3)
    continue;
*/

/*
 for (int i = 2; i<=1000; i++) {//1.
 //i.
 //2.
 if (i%10 == 3 || i/10%10==3 || i/100 == 3) {
 continue;
 }
 //i  3.
 BOOL is = YES;
 for (int j = 2; j<=i-1; j++) {
 if (i%j == 0 ) {
 is = NO;
 }
 }
 if (is) {
 printf("%d ",i);
 }
 }
 printf("\n");
 
 
*/




