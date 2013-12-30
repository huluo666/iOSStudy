//
//  t4.c
//  exercise_1230
//
//  Created by Rimi07 on 13-12-30.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
// 4、	实现将字符串加密的方法，即将原有字符串中所有字母的ascII值加3， x，y，z加密后分别为a，b，c，数字与符号不变，然后输出得到的新字符串。
int exer4()
{
    /*
     char s[30] = "ab $dx ;ijd1kfalk llohh";
     for (int i = 0; i<30; i++) {
     if ((s[i] >= 'a' &&s[i]<='z') ||
     (s[i]>='A'&&s[i] <= 'Z')) {
     if ((s[i] >= 'x'&&s[i]<='z') ||
     (s[i] >= 'X'&&s[i]<='Z')) {
     s[i] = s[i] - 26 + 3;
     } else {
     s[i] += 3;
     }
     }
     }
     
     */
    printf("第4题:\n");
    char str[23] = "ab $dx ;ijd1kfalk llohh";
    for (int i=0; i<23; i++)
    {
        if ((str[i]>='a' && str[i]<'x') || (str[i]>='A' && str[i]<'Z'))
        {
            str[i] = str[i]+3;
        }
        else if ((str[i]>='x' || str[i]<='z') || (str[i]>='X' || str[i]<='Z'))
        {
            str[i] = str[i]-26+3;
        }
        else
        {
            str[i] = str[i]+3;
        }
        printf("%c",str[i]+3);
    }
    printf("\n");
    printf("\n\n");
    return 0;
}