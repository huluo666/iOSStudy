//
//  t2.c
//  exercise_1227
//
//  Created by Rimi07 on 13-12-27.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
/*
 2、输入一个字符，判断它如果是小写字母输出其对应大写字母，如果是大写字母输出其对应小写字母，如果是数字输出数字本身，如果是空格，输出“space”，如果不是上述情况，输出“other”。
 */
int exer2()
{
    printf("第2题:\n");
    char ch;
    printf("请输入一个字符:");
    //    scanf("%c", &ch);
    ch = getchar();
    if (ch>=97 && ch <=122) // 小写字母
    {
        printf("%c\n", ch-32);
    }
    else if (ch>=65 && ch<=90) // 大写字母
    {
        printf("%c\n", ch+32);
    }
    else if (ch>=48 && ch<=57) // 数字
    {
        printf("%c\n",ch);
    }
    else if (ch == 32) // 空格
    {
        printf("space\n");
    }
    else
    {
        printf("other\n"); // 其他
    }
    
    return 0;
}

/*
 printf("请输入字符：\n");
 char ch;
 scanf("%c",&ch);
 if (ch >='a'&&ch<='z') {
 printf("%c\n",ch += 'A'-'a');
 } else if (ch>='0'&&ch<='9') {
 printf("%c\n",ch);
 } else if (ch == ' ') {
 printf("space\n");
 } else {
 printf("other\n");
 }
*/