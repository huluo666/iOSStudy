//
//  t2.c
//  exercise_140106
//
//  Created by Rimi07 on 14-1-6.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
//2、	有5名学生，3门课，求出有2门以上排名在前3的同学，并输出其所有资料。

typedef struct
{
    char *name;
    int math;
    int en;
    int com;
} Student;

void bub_sort(int *arr, int n)
{
    int i, j;
    int flag = 0;        /*定义一个标志位*/
    
    for (i = 0; i<n-1; i++)        /*n-1趟排序*/
    {
        for (j = 0; j<n-i-1; j++)
        {
            if (*(arr+j) < *(arr+j+1)) /*若后面元素有比前面小的就交换*/
            {
                *(arr+j) = *(arr+j) + *(arr+j+1);
                *(arr+j+1) = *(arr+j) - *(arr+j+1);
                *(arr+j) = *(arr+j) - *(arr+j+1);
                flag = 1;        /*将标志位设置为1，表示交换过*/
            }
        }
        
        if (flag == 0) /*若没有发生过交换就结束算法*/
        {
            break;
        }
    }
    
    return ;
}

// 打印一维数组
void print_arr(int *arr, int len)
{
    for (int i = 0; i < len; i++)
    {
        printf("%d ", arr[i]);
    }
    printf("\n");
}


void findStudent(Student stu[], int n);
void printStudent(Student stu[], int n);
int exer2()
{
    
    printf("第2题:\n");
    Student s1 = {"Lucy", 22, 57, 79};
    Student s2 = {"Mike", 32, 36, 29};
    Student s3 = {"Matt", 25, 56, 89};
    Student s4 = {"Lily", 12, 86, 99};
    Student s5 = {"Eric", 72, 58, 77};
    Student stu[] = {s1, s2, s3, s4, s5};
    
    findStudent(stu, 5);
    printf("------\n");
    printStudent(stu, 5);
    printf("\n\n");
    
    return 0;
    
}

void printStudent(Student stu[], int n)
{
    for (int i=0; i<n; i++)
    {
        int mathCount = 0, enCount = 0, comCount = 0;
        for (int j=0; j<n; j++) // 找到每个同学每科比其他同学高的次数
        {
            if (stu[i].math > stu[j].math)
            {
                mathCount++;
            }
            
            if (stu[i].en > stu[j].en)
            {
                enCount++;
            }
            
            if (stu[i].com > stu[j].com)
            {
                comCount++;
            }
        }
        
        // 只要有两科及以上比其他同学高的次数大于等于2即符合要求(前三)
        if ((mathCount>=2) + (enCount>=2) + (enCount>=2) >=2) // 找到符合要求的
        {
            printf("name=%s, math=%d, en=%d, com=%d\n", stu[i].name, stu[i].math, stu[i].en, stu[i].com);
        }
    }
}


// 找出符合要求的学生
void findStudent(Student stu[], int n)
{
    // 思路，先找到毎一门课前三的同学，存入数组。然后比较。
    int mathArray[5] = {0};
    int enArray[5] = {0};
    int comArray[5] = {0};
    
    // 各科成绩存入数组
    for (int i=0; i<n; i++)
    {
        mathArray[i] = stu[i].math;
        enArray[i] = stu[i].en;
        comArray[i] = stu[i].com;
    }
    
    //    print_arr(mathArray, 5);
    //    print_arr(enArray, 5);
    //    print_arr(comArray, 5);
    
    // 对成绩排序
    bub_sort(mathArray, 5);
    bub_sort(enArray, 5);
    bub_sort(comArray, 5);
    
    
    // 存姓名
    char *nameMath[3] = {0};
    char *nameEn[3] = {0};
    char *nameCom[3] = {0};
    
    for (int i=0; i<5; i++)
    {
        for (int j=0; j<3; j++)
        {
            if (mathArray[j] == stu[i].math) // 找到数学前三的同学
            {
                nameMath[j] = stu[i].name;
            }
            if (enArray[j] == stu[i].en) // 找到英语前三的同学
            {
                nameEn[j] = stu[i].name;
            }
            if (comArray[j] == stu[i].com) // 找到数学前三的同学
            {
                nameCom[j] = stu[i].name;
            }
        }
    }
    
    print_arr(mathArray, 5);
    print_arr(enArray, 5);
    print_arr(comArray, 5);
    
    // 将所有前三的姓名存入数组
    char *all[9] = {0};
    int k = 0;
    for (int i=0; i<3; i++, k++)
    {
        all[k] = nameMath[i];
    }
    for (int i=0; i<3; i++, k++)
    {
        all[k] = nameEn[i];
    }
    for (int i=0; i<3; i++, k++)
    {
        all[k] = nameCom[i];
    }
    
    printf("\n");
    for (int i=0; i<9; i++)
    {
        //        printf("%s ", all[i]);
    }
    printf("\n");
    
    
    // 找出>=2科前三的人并存入姓名
    int count = 0;
    
    char *kk[9] = {0};
    int p = 0;
    for (int i=0; i<9; i++)
    {
        for (int j=0; j<9; j++)
        {
            if (strcmp(all[i], all[j]) == 0)
            {
                count++;
            }
        }
        
        if (count >= 2)
        {
            //            printf("%s ", all[i]);
            // 保存姓名(去除重复)？？？？？？？
            // ....
            kk[p++] = all[i];
        }
        count = 0;
    }
    
    kk[p] = '\0';
    
    
    // 对数组去重
    // ..
    
    
    
    // 根据姓名打印学生信息
    printf("p=%d", p);
    printf("\n");
    for (int i=0; i<p; i++)
    {
        for (int j=0; j<5; j++)
        {
            if (strcmp(kk[i], stu[j].name) == 0)
            {
                printf("name=%s, math=%d, en=%d, com=%d\n", stu[j].name, stu[j].math, stu[j].en, stu[j].com);
            }
        }
        
    }
    
}


//teacher's solution
/*
void print(Student stu[5])
{
    for (int i = 0; i<5; i++) {
        //stu[i]
        int count1 = 0;
        int count2 = 0;
        int count3 = 0;
        for (int j = 0; j<5; j++) {
            if (stu[i].class[0] > stu[j].class[0]) {
                count1++;
            }
            if (stu[i].class[1] > stu[j].class[1]) {
                count2++;
            }
            if (stu[i].class[2] > stu[j].class[2]) {
                count3++;
            }
        }
        if ((count1>=2) + (count2>=2) + (count3>=2) >= 2) {
            printf("name = %s,class1:%d,class2:%d,class3:%d\n",stu[i].name,stu[i].class[0],stu[i].class[1],stu[i].class[2]);
        }
    }
}
*/