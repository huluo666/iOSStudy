//
//  main.m
//  1230
//
//  Created by Rimi07 on 13-12-30.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
void bub_sort(int *arr, int n)
{
    int i, j;
    int flag = 0;        /*定义一个标志位*/
    
    for (i = 0; i < n-1; i++)        /*n-1趟排序*/
    {
        for (j = 0; j < n-i-1; j++)
        {
            if (arr[j] > arr[j+1]) /*若后面元素有比前面小的就交换*/
            {
                arr[j] = arr[j] + arr[j+1];
                arr[j+1] = arr[j] - arr[j+1];
                arr[j] = arr[j] - arr[j+1];
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


void print_arr(int *arr, int len)
{
    int i;
    for (i = 0; i < len; i++)
    {
        printf("%d ", arr[i]);
    }
    printf("\n");
    return;
}

int main(int argc, const char * argv[])
{

    // 数组
    // 集合:同类,多个
    // c数组:1,相同类型 2,指定长度
    
    int arr[100] = {0};
    for (int i=1; i<101; i++)
    {
        int temp = arc4random()%100;
        if (temp%2 != 0 && temp!=0)
        {
            arr[i] = temp;
        }
        
    }
    
    for (int i=0; i<101; i++)
    {
//        printf("%d ", arr[i]);
    }
    
    // 倒序算法不考虑奇偶
    /*
    int tmp = p[i];
    p[i] = p[31-1-i];
    p[32-1-i] = tmp;
     */
    
    // 1-10
    int n[10] = {0};
    for (int i=0; i<10; i++)
    {
        n[i] = arc4random()%10+1;
    }
    
    bub_sort(n, 10);
    print_arr(n, 10);
    
    // 字符数组
    char v[5] = {'a', 'b', 'c', 'd', 'e'};
    v[2] = 'f';
    // 字符串:特殊的字符数组
    char s[6] = {'a', 'b', 'c', 'd', 'e', '\0'};
    /*
        '\0' == 0;
        '0' == 48;
    */
    
//    printf("%c", s);
    s[3] = '\0';
    printf("%d\n", (int)strlen(s));
    
    char de[4] = {0};
    strcpy(de, s);
    printf("de=%s\n", de);
    // 用法    参数       返回值
    // strcat sprintf strcmp
    
    char g[4] = {0};
    char *n1[3] = {"131", "333", "lad"};
//    strcpy(g, n1);
    
    // 10以内的随机数填满u,将每一行的和放入u1
    int u[4][3] = {0};
    int u1[3] = {0};
    for (int i=0; i<4; i++)
    {
        printf("\n");
        for (int j=0; j<3; j++)
        {
            u[i][j] = arc4random()%10;
            printf("%d ", u[i][j]);
        }
        
    }
    printf("\n");
    for (int i=0; i<4; i++)
    {
        int sum = 0;
        for (int j=0; j<3; j++)
        {
            sum += u[i][j];
        }
        u1[i] = sum;
    }
    
    for (int i=0; i<4; i++)
    {
        printf("%d ", u1[i]);
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    return 0;
}

