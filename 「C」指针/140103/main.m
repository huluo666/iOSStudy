//
//  main.m
//  140103
//
//  Created by Rimi07 on 14-1-3.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
char *append(const char *s1, const char *s2);
char *arrayToString(int arr[], int n);
int main(int argc, const char * argv[])
{

    // 指针
    
    int d[3] = {1, 2, 3};
    printf("%d\n", *d);
    printf("%d\n", *(d+1));
//    printf("%d\n", *(++d)); // false 数组名为指针常量
    
    
    char s1[5] = "abcd";
    char *p1 = s1;
    while (*p1)
    {
        *(p1++) += 'A'-'a';
    }
    
    printf("%s\n", s1);
    printf("%p\n", s1+4);
    printf("%p\n", p1);
    
    // 字符串指针
    char *s2 = "abcd";  // 常量，不能更改
    char *s3 = malloc(4); // 动态分配，字符串变量
    strcpy(s3, s2);
    *s3 = '\0';
    
    int a2[10] = {0};
//    a2 = &a2[0]; // false,指针值不可以更改(直接更改地址的值,kidding?)
    *a2 = 5;
    
    
    char s4[] = {'a', 'b', 'c', 'd'};
    *s4 = 'f';
    printf("%c\n", *s4);
    
    
    char *a7 = "abcd";
    char *a8 = "de";
    char *p2 = NULL;
    p2 = append(a7, a8);
    printf("%s\n", p2);
    free(p2);
    //
    int array[4] = {1,22,333,4444};
    char *string = arrayToString(array, 4);
    printf("%s\n", string);
    free(string);
    

    return 0;
}

char *append(const char *s1, const char *s2)
{
    char *result = malloc(strlen(s1)+strlen(s2)+1);
    sprintf(result, "%s%s", s1, s2);
    return result;
}

char *arrayToString(int arr[], int n)
{
    char *result = malloc(sizeof(int)*n+1);
    int i=0;
    for (; i<n; i++)
    {
        sprintf(result, "%s%d ", result, *(arr+i));
    }
    
    return result;
}