//
//  t6.c
//  exercise_140103
//
//  Created by Rimi07 on 14-1-3.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
// 6、实现字符串的加法，规则如下，字符串按照每个字符逐个相加，数字相加为对应的2个数相加后取其个位，其他的相加取ASCII大的字符，若一个字符串长度不够，其后需补上长度较长的字符串剩下的部分。

char *stringPlus(char *s1,char *s2)
{
    long length1 = strlen(s1);
    long length2 = strlen(s2);
    long maxlength = length1>length2?length1:length2;
    char *s3 = malloc(maxlength+1);
    
    long minLength = length1<length2?length1:length2;
    
    for (int i = 0; i<minLength; i++) {
        if (*(s1 + i) >='0' && *(s1+i) <='9'&&
            *(s2 + i) >='0' && *(s2+i) <='9') {
            int sum = *(s1 + i) - '0' + *(s2 + i) - '0';//2个字符对应数值的和
            *(s3 + i) = sum%10 + '0';//取余后赋值给新字符串
        } else {
            *(s3+i) = *(s1+i) > *(s2+i)?*(s1+i):*(s2+i);
        }
    }
    
    if (length1 > length2) {
        strcat(s3, s1 + minLength);
    } else {
        strcat(s3, s2 + minLength);
    }
    
    return s3;
}

void exer6()
{
    printf("第6题:\n");
    
    char *s1 = "123kdjoa00d";
    char *s2 = "123kdoeis";
    char *s3 = stringPlus(s1, s2);
    printf("%s", s3);
    printf("\n");
}