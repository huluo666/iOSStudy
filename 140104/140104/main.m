//
//  main.m
//  140104
//
//  Created by Rimi07 on 14-1-4.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
// 结构体

struct _Student
{
    char *name;
    int age;
};

struct
{
    char *name;
    int age;
} stu1, stu2;

/*
//OC使用下面这种方法声明结构体
struct _Student
{
    char *name;
    int age;
};
typedef _Student Student;
*/

// 我喜欢这种方法
typedef struct
{
    char *name;
    int age;
    char name1[30];
} Student;

// 结构体占用内存空间大于等于其所有成员变量占用字节数之和


// 类型

typedef  struct
{
    int attact;
    int life;
} Game;



void hit(Game *g1, Game *g2)
{
    g2->life -= g1->attact;
}


void exchangeName(Student *s1, Student  *s2)
{
    char *temp = s1->name;
    s1->name = s2->name;
    s2->name = temp;
}


int main(int argc, const char * argv[])
{
    printf("%lu", sizeof(int ));
    
    Student stu = {"lucy", 22};
    
     // 结构体的运算, 结构体变量不参与任何运算(除了.)
    
    Game g1 = {0, 2};
    Game g2 = {0, 2};
    
    g2.life -= g1.attact;
    
    // 成员变量是字符串
    // 字符数组
    strcpy(stu.name1, "124");
    
    // 字符串
    stu.name = malloc(4);
    strcpy(stu.name, "123");
    
    
    // 函数中
    
    
    //. 练习
    // 使用结构体指针建立2个结构体，使用函数将其name互换
    printf("-------\n");
    Student *s1 = malloc(sizeof(Student));
    Student *s2 = malloc(sizeof(Student));
    s1->name = "Mike";
    s2->name = "Lucy";
    exchangeName(s1, s2);
    printf("%s, %s\n", s1->name, s2->name);
    
    Student stu2, stu3;
    // 结构体数组
    Student stus[3] = {stu, stu2, stu3};
    int sum = 0;
    for (int i=0; i<3; i++)
    {
        sum += stus[i].age;
    }
    
    // 结构体数组的排序，自己看
    
    // 结构体包含结构体
    printf("\n\n\n\n\n\n\n\n\n\n\n\n");
    return 0;
}
















