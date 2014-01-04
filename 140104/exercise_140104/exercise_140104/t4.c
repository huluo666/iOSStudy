//
//  t4.c
//  exercise_140104
//
//  Created by Rimi07 on 14-1-4.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#include <stdio.h>
#include <string.h>
// 4、某班有5个学生，三门课。分别编写实现以下要求：
//（1） 写一个函数，输出一名学生的所有信息，包括姓名，学号，每门课的成绩
//（2） 求各门课的平均分；
//（3） 找出有两门以上不及格的学生，并输出其学号和不及格课程的成绩；
//（4） 找出三门课平均成绩在85-90分的学生，并输出其学号和姓名

typedef struct
{
    char *name;
    char *id;
    int math;
    int en;
    int com;
} Student;

// 1.
void printStudentInfo(Student s)
{
    printf("name=%s id=%s math=%d en=%d com=%d\n\n", s.name, s.id, s.math, s.en, s.com);
}

// 2.
int averageByCourse(Student s[], int n, char *type)
{
    if (strcmp(type, "math")==0)
    {
        int mathSum = 0;
        for (int i=0; i<n; i++)
        {
            mathSum += s[i].math;
        }
        return mathSum/n;
    }
    
    if (strcmp(type, "en")==0)
    {
        int enSum = 0;
        for (int i=0; i<n; i++)
        {
            enSum += s[i].en;
        }
        return enSum/n;
    }
    
    if (strcmp(type, "com")==0)
    {
        int comSum = 0;
        for (int i=0; i<n; i++)
        {
            comSum += s[i].com;
        }
        return comSum/n;
    }

    return 0;
}

// 3.
void findLoser(Student s[], int n)
{
    printf("Loser:\n");
    for (int i=0; i<n; i++)
    {
        int math = s[i].math;
        int   en = s[i].en;
        int  com = s[i].com;
        
        if ((math<60&&en<60) || (math<60&&com<60) || (en<60&&com<60))
        {
            printf("%s ", s[i].name);
            if (math < 60)
            {
                printf("math=%d ", s[i].math);
            }
            
            if (en < 60)
            {
                printf("en=%d ", s[i].en);
            }
            
            if (com < 60)
            {
                printf("com=%d ", s[i].com);
            }
            printf("\n");
        }
    }
}

// 4.
int averageByStudent(Student s)
{
    return (s.com+s.en+s.math)/3;
}

void fingStudentByAvgScore(Student s[], int n)
{
     printf("平均分>=85,<=90的有：\n");
    for (int i=0; i<n; i++)
    {
        int avg = averageByStudent(s[i]);
        if (avg>=85 && avg<=90)
        {
            printf("name=%s id=%s\n", s[i].name, s[i].id);
        }
    }
}

int exer4()
{

    printf("第4题:\n");
    
    Student s1 = {"Lucy", "111", 67, 98, 97};
    Student s2 = {"Mike", "222", 67, 98, 97};
    Student s3 = {"Matt", "333", 85, 86, 87};
    Student s4 = {"Eric", "444", 57, 34, 92};
    Student s5 = {"Peny", "555", 57, 34, 12};
    
    // 1.
    printStudentInfo(s1);
    
    // 2.
    Student s[] = {s1, s2, s3, s4, s5};
    int math_avg = averageByCourse(s, 5 , "math");
    int en_avg = averageByCourse(s, 5 , "en");
    int com_avg = averageByCourse(s, 5 , "com");
    printf("math average=%d\nen average=%d\ncom average=%d\n\n", math_avg, en_avg, com_avg);

    // 3.
    findLoser(s, 5);
    printf("\n");
    
    // 4.
    fingStudentByAvgScore(s, 5);
    
    printf("\n");
    return 0;
    
}