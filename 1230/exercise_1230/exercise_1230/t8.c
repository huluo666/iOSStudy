//
//  t8.c
//  exercise_1230
//
//  Created by Rimi07 on 13-12-30.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
//8、有一行英文语句，统计其中的单词个数（单词之间以空格分隔），并将每一个单词的第一个字母改为大写。
int exer8()
{
    printf("第8题:\n");

    char sentence[100] = "this is a test sentence";
    int word = 1;
    // 将第一个字符装换为大写
    if (sentence[0]>='a' && sentence[0]<='z')
    {
        sentence[0] = sentence[0] + 'A'-'a';
    }
    
    for (int i=1; sentence[i]!='\0'; i++)
    {
        if (sentence[i-1]==' ' && sentence[i]>='a' && sentence[0]<='z')
        {
            word++;
            sentence[i] = sentence[i] + 'A'-'a';
        }
    }

    printf("转换后为:\n%s\n", sentence);
    printf("word=%d", word);
    
    printf("\n\n");
    return 0;
}