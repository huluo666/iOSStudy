//
//  t3.c
//  exercise_140106
//
//  Created by Rimi07 on 14-1-6.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//3、	一人岁数的3次方是四位数，四次方是六位数，并知道此人岁数的3次方和4次方用遍了0～9十个数字。编写一程序求此人的岁数。
int exer3()
{
    // 用遍了0～9十个数字 说明 4位数和6位数合在一起不会重复
    printf("第3题:\n");
    
    int a[10] = {0}, s[10] = {0};

    for (int n=18; n<22; n++) // n^3是四位数，所以18<=n<=21
    {
        int n3 = n*n*n;
        int n4 = n*n*n*n;
  
        // 取出三位数个位数字
        for (int i=3; i>=0; i--)
        {
            a[i] = n3%10;
            n3 /= 10;
        }
        
        // 取出四位数个位数字
        for (int i=9; i>=4; i--)
        {
            a[i] = n4%10;
            n4 /= 10;
        }
        
        // 统计重复次数
        for (int i=0; i<10; i++)
        {
            s[a[i]]++;
        }
       
        // 判断有无重复
        for (int i=0; i<10; i++)
        {
            if (s[a[i]] == 1)
            {
                if (i == 9)
                {
                    printf("number=%d\n", n);
                }
            }
            else
            {
                break;
            }
        }
        
    }
   
 
    
    for (int i=0; i<100; i++)
    {
        if (i*i*i<1000 || i*i*i>9999)
        {
            continue;
        }
        
        if (i*i*i*i<100000 || i*i*i*i>999999)
        {
            continue;
        }
        
        char *s = malloc(11);
        sprintf(s, "%d%d", i*i*i, i*i*i*i);
        
        // 找重复
        int flag = 1;
        for (int k='0'; k<'9'; k++)
        {
            int count = 0;
            for (int j=0; j<10; j++)
            {
                if (k == *(s+j))
                {
                    count++;
                }
            }

            if (count >= 2)
            {
                flag = 0;
            }

        }
        
        if (flag == 1)
        {
            printf("%d ", i);
        }
    }


    
    printf("\n\n");
    
    return 0;
    
}





/*

char age[11]={0};
for (int i=11; i<22; i++) {
    BOOL t=false;
    sprintf(age,"%d%d",i*i*i,i*i*i*i);
    for (int j=0; j<10; j++) {
        for (int k=j+1; k<10; k++) {
            if (age[j]==age[k]) {
                t=true;
                break;
            }
            if(j==8)
                printf("这个人的岁数为%d\n",i);
        }
        if (t) {
            break;
        }
    }
    
}
 
*/

/*
 // 方法来源于网络
 
#include <stdio.h>
#include <math.h>
#ifndef MIN
#define MIN(a, b) ((a) < (b) ? (a) : (b))
#endif

#ifndef MAX
#define MAX(a, b) ((a) > (b) ? (a) : (b))
#endif

int
cal_ones(int a, int b)
{
    int ret = 0;
    
    while (a) {
        ret |= 1 << (a % 10);
        a /= 10;
    }
    
    while (b) {
        ret |= 1 << (b % 10);
        b /= 10;
    }
    
    return ret;
}

int
main(int argc, char *argv[])
{
    int r3_min, r3_max;
    int r4_min, r4_max;
    int r_min, r_max;
    
    r3_min = (int)cbrt(1023 - 1) + 1;
    r3_max = (int)cbrt(9876 + 1);
    r4_min = (int)pow(102345 - 1, 0.25) + 1;
    r4_max = (int)pow(987654 + 1, 0.25);
    
    // 限定范围
    r_min = MAX(r3_min, r4_min);
    r_max = MIN(r4_max, r4_max);
    
    int found = 0;
    int age;
    for (age = r_min; age <= r_max; age++) {
        if (cal_ones(age * age * age, age * age * age * age) == 0x3ff) {
            found = 1;
            printf("%d\n", age);
        }
    }
    
    if (!found)
        printf("Not found.\n");
    return 0;
}
 */

// teacher's solution
/*
for (int i=1; i<100; i++) {
    if (i*i*i<1000||i*i*i>9999) {
        continue;
    }
    if (i*i*i*i<100000||i*i*i*i>999999) {
        continue;
    }
    char *s = malloc(11);
    sprintf(s,"%d%d", i*i*i,i*i*i*i);
    //            printf("%s\n",s);
    
    BOOL is = YES;
    for (int k = '0'; k<='9'; k++) {
        int count = 0;
        for (int j = 0; j<10; j++) {
            if (k == s[j]) {
                count ++;
            }
        }
        if (count >= 2) {
            is = NO;
        }
    }
    if (is) {
        printf("%d\n",i);
    }
}
 */
