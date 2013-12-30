//
//  t8.c
//  exercise_1230
//
//  Created by Rimi07 on 13-12-30.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
//8、	有一行英文语句，统计其中的单词个数（单词之间以空格分隔），并将每一个单词的第一个字母改为大写。
int exer8()
{
    printf("第8题:\n");
    char  str[81] = "this is a test";
    int word = 1;
    for (int i=0; i<81 ; i++)
    {
        if (str[i] == ' ')
        {
            word++;
        }
//        printf("%c", str[i]);
        
    }
    printf("word=%d", word);
    
    printf("\n\n");
    return 0;
}