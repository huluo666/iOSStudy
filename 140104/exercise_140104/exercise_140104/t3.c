//
//  t3.c
//  exercise_140104
//
//  Created by Rimi07 on 14-1-4.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#include <stdio.h>
// 3、使用结构体描述电话簿中的联系人信息，并将其按名称首字母排序。假定联系人均为英文开头。

typedef struct
{
    char *name;
    char *number;
} Person;

void printName(Person p[], int n)
{
    for (int i=0; i<n; i++)
    {
        printf("%s ", p[i].name);
    }
    printf("\n");
}

int compareName(char *n1, char *n2)
{
    
    return 0;
}

void sortPersonByName(Person p[], int n)
{
    for (int i=0; i<n-1; i++)
    {
        for (int j=0; j<n-i-1; j++)
        {
//            if (<#condition#>)
//            {
//                <#statements#>
//            }
        }
    }
    printf("\n");
}


int exer3()
{
    printf("第3题:\n");
    Person p1 = {"Mike", "15809781231"};
    Person p2 = {"Lucy", "15809781223"};
    Person p3 = {"Lili", "15809781253"};
    
    Person p[] = {p1, p2, p3};
    
    // 排序前打印
    printName(p, 3);
    
    // 排序
    sortPersonByName(p, 3);
    
    // 排序后打印
    printName(p, 3);
    
    printf("\n");
    return 0;
}