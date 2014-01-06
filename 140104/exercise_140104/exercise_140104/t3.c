//
//  t3.c
//  exercise_140104
//
//  Created by Rimi07 on 14-1-4.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#include <stdio.h>
#include <string.h>
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

void sortPersonByName(Person p[], int n)
{
    for (int i=0; i<n-1; i++)
    {
        for (int j=0; j<n-i-1; j++)
        {
            int comp = strcmp(p[j].name, p[j+1].name);
            if (comp >= 1)
            {
                Person temp = p[j];
                p[j] = p[j+1];
                p[j+1] = temp;
            }
        }
    }
    printf("\n");
}


int exer3()
{
    printf("第3题:\n");
    Person p1 = {"Lucy", "15809781231"};
    Person p2 = {"Mike", "15809781223"};
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

/*
PersonInfo per1 = {"wa1","130898687668"};
PersonInfo per2 = {"za2","130876677667"};
PersonInfo per3 = {"xa3","139766755678"};

PersonInfo pers[3] = {per1,per2,per3};
for (int i = 0; i<2; i++) {
    for (int j = 0; j<2-i; j++) {
        if (strcmp(pers[j].name, pers[j+1].name)>0) {
            PersonInfo temp = pers[j];
            pers[j] = pers[j+1];
            pers[j+1] = temp;
        }
    }
}
 */


