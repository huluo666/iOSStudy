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
    printf("第4题:\n");
    char s[] = "ab8xyz";
    printf("before=%s\n", s);
    
    for (int i=0; i<6; i++)
    {
        if ((s[i] >= 'a' &&s[i]<='z') ||
            (s[i]>='A'&&s[i] <= 'Z'))
        {
            if ((s[i] >= 'x'&&s[i]<='z') ||
                (s[i] >= 'X'&&s[i]<='Z'))
            {
                s[i] = s[i] - 26 + 3;
            }
            else
            {
                s[i] += 3;
            }
        }
    }
    
    printf("after=%s\n", s);
    
    printf("\n\n");
    return 0;
}