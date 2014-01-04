//
//  t4.c
//  exercise_140103
//
//  Created by Rimi07 on 14-1-3.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
// 4、在一个长度不大于255的字符串中查找最长单词，假定单词之间均以空格，逗号或回车分隔。
char *serarchMaxLengthWord(char *string)
{
    char *start = string; // index用于定位每个单词开头位置
    int max = 0, count = 0; // count记录每个单词长度，max记录最长单词的长度
    char *index; // 记录最长单词的开头位置
    
    while (*string++)
    {
        if (*string==' ' || *string==',' || *string=='\n' || *string=='\0')  // 遇到特定字符单词结束
        {
            if (max < count) // 记录最大长度
            {
                max = count;
                index = start;
            }
            else
            {
                start = string+1; // index指向下一个单词开头
            }
            count = 0;  // 单词结束，count清空，用于下一次计数
        }
        else // 单词没有结束
        {
            count++; // 单词长度+1
        }
    }
    
    char *result = malloc(max+1); // result用于接收最长单词
    int i=0;
    for ( ;i<max; i++)
    {
        *(result+i) = *(index+i);
    }
    *(result+i) = '\0';
    return result;
}

void exer4()
{
    printf("第4题:\n");
//    char *string = "1 22 333 4444 55555";
    char *string = "With The iiiiiPassing of James Avery, See Where The Rest of the Cast Is Now Good Morning AmericanAmerican";
    char *reslut = serarchMaxLengthWord(string);
    printf("最长单词为：%s", reslut);
    free(reslut);
    printf("\n");
}


// teacher's solution
/*
char *s = "12 abc eofjkoj  dfak kdddddddd";

char *s1 = malloc(strlen(s) + 1);
strcpy(s1, s);

char *p = s1;
while (*p) {
    if (*p == ','||*p == '\n'||*p == ' ') {
        *p = '\0';
    }
    p++;
}
//    printf("%s\n",s1);

long maxLength = strlen(s1);
char *q = s1;
for (int i = 0; i<strlen(s); i++) {
    if (s1[i] == '\0') {
        if (maxLength < strlen(s1+i+1)) {
            maxLength = strlen(s1+i+1);
            q = s1+i+1;
        }
    }
}
printf("%s\n",q);
*/
