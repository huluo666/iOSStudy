//
//  main.m
//  exercise_140107
//
//  Created by Rimi07 on 14-1-7.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 1、	写一个链表，存储编号为1、3、5、7、9的学生，然后写一个函数，将指定编号的学员去掉。
 2、	将上述链表的3号学生去掉，插入5号之后，然后将5号去掉，插入1号之后。（使用插入和删除函数实现）
 3、	结合上述例子，实现将编号为M和N的学生互换。
 4、	将上述链表逆序排列（使用编号）
*/

typedef struct _Student
{
    int number;
    char *name;
    struct _Student *next;
} Student;

void traverse(Student *root, Student *shift);
Student *delete(Student *root,int number);
void  insert(Student *root, Student *node, int number);
void exchange(Student *head, int m, int n);

int main(int argc, const char * argv[])
{
    // 1...
    // 创建链表
    Student *root = malloc(sizeof(Student));
    root->number = 0;
    root->name   = NULL;
    
    Student *node = NULL;
    Student *shift = root;
    
    for (int i=1; i<=9; i=i+2)
    {
        node = (Student *) malloc(sizeof(Student));
        node->name = malloc(5);
        sprintf(node->name, "w%d", i);
        node->number = i;
        
        shift->next = node;
        shift = node;
    }
    shift->next = NULL;
    
    traverse(root, shift);

    // 删除 number=3 的学生
    int del = 3;

    delete(root, del);

    traverse(root, shift);
 

    // 2...
    // 3 插入 5号后面
    Student *w3 = malloc(sizeof(Student));
    w3->name = "w3";
    w3->number = 3;
    insert(root, w3, 5);
    traverse(root, shift);
    // 将 5号去掉
    del = 5;
    delete(root, del);
    traverse(root, shift);
    // 5 插入 1号后面
    Student *w5 = malloc(sizeof(Student));
    w5->name = "w5";
    w5->number = 5;
    insert(root, w5, 1);
    traverse(root, shift);

    // 3...
//    exchange(root, 3, 5); // crash
    
    return 0;

}

// 遍历打印链表
void traverse(Student *root, Student *shift)
{
    shift = root;
    while (shift)
    {
        printf("number=%d, name=%s\n", shift->number, shift->name);
        shift = shift->next;
    }
}

Student *delete(Student *root,int number)
{
    Student *ret = NULL;
    
    while (root->next)
    {
        if (root->next->number == number)
        {
            if (root->next->next == NULL)
            {
                ret = root->next;
                free(root->next);
                root->next = NULL;
                break;
            }
            else
            {
                Student *str = root->next->next;
                ret = root->next;
                free(root->next);
                root->next = str;
            }
        }
        
        root = root ->next;
    }
    return ret;
}

void  insert(Student *root, Student *node, int number)
{
    while (root) {
        if (root->number == number) {
            if (root->next == NULL) {
                root->next = node;
                node->next = NULL;
                break;
            } else {
                node->next = root->next;
                root->next = node;
            }
        }
        
        root = root ->next;
    }
}


void exchange(Student *root, int m, int n)
{
    Student *stu_m = delete(root, m);
    insert(root, stu_m, n);
    Student *stu_n = delete(root, n);
    insert(root, stu_n, m-2);
}