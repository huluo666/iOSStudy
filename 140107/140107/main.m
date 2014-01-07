//
//  main.m
//  140107
//
//  Created by Rimi07 on 14-1-7.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct _Student
{
    char *name;
    int age;
    int number;
    struct _Student *next;
} Student;

typedef struct _PhoneNumber
{
    int number;
    char *name;
    char *phone;
    struct _PhoneNumber *next;

} PhoneNumber;




int main(int argc, const char * argv[])
{
    

    /*
    // 链表
    
    // 构建head
    Student *head = malloc(sizeof(Student));
    head->name = "Lucy";
    head->age = 22;
    head->number = 0;
    
    // 构建双指针
    Student *node = NULL; // 节点指针
    Student *shift = head; // 移位指针
    
    // 建立节点， 100000个
    for (int i=0; i<9999; i++)
    {
        node = malloc(sizeof(Student));
        node->name = malloc(7);
        sprintf(node->name, "w%d", i+1);
        node->age = arc4random()%20;
        node->number = i+1;
        
        // 关联
        shift->next = node; // 将节点指针存放进前一个节点的next
        shift = node;  // 移位指针移动到下一个节点
    }
    shift->next = NULL;
    
    // 打印链表
    shift = head;
    while (shift)
    {
        printf("number:%d name=%s, age=%d\n", shift->number, shift->name, shift->age);
        shift = shift->next;
    }
    
    
    */
    // .
    PhoneNumber *root = malloc(sizeof(PhoneNumber));
    root->name = "ddd";
    root->number = 101;
    root->phone = "15687962351";
    
    
    PhoneNumber *link = NULL;
    PhoneNumber *move = root;
    
    for (int i=99; i>0; i--)
    {
        link = malloc(sizeof(PhoneNumber));
        link->name = malloc(5);
        sprintf(link->name, "w%d", i);
        link->number = i;
        link->phone = malloc(12);
        sprintf(link->phone, "%d%d%d", arc4random()%100, arc4random()%1000,arc4random()%1000);
        
        move->next = link;
        move = link;
    }
    
    move->next = NULL;
    
    move = root ;
    while (move)
    {
        printf("numer:%d, name=%s, phone=%s\n",move->number, move->name, move->phone);
        move = move->next;
    }
    
    return 0;
}
/*
PhoneNumber *head = malloc(sizeof(PhoneNumber));
head -> number = 101;
head -> name = "";
head -> phone = "";

PhoneNumber *p = NULL;
PhoneNumber *q = head;

for (int i = 99; i>0; i-=2) {
    p = malloc(sizeof(PhoneNumber));
    p -> number = i;
    p -> name = malloc(5);
    sprintf(p->name ,"w%d",i);
    p -> phone = malloc(12);
    sprintf(p->phone,"130%d",arc4random()%100000000);
    
    q->next = p;
    q = p;
}
q -> next = NULL;

q = head;
while (q) {
    printf("number:%d,name = %s,phone = %s\n",q->number,q->name,q->phone);
    q = q->next;
}
*/

/*
void delete(Student *head,int number)
{
    while (head->next) {
        if (head->next->number == number) {
            if (head->next->next == NULL) {
                free(head->next);
                head->next = NULL;
            } else {
                Student *str = head->next->next;
                free(head->next);
                head->next = str;
            }
        }
        head = head ->next;
    }
}

void  insert(Student *head,Student *node,int number)
{
    while (head) {
        if (head->number == number) {
            if (head->next == NULL) {
                head->next = node;
                node->next = NULL;
            } else {
                //node->next = head->next->next;
				node->next = head->next;
                head->next = node;
            }
        }
        head = head ->next;
    }
}
*/