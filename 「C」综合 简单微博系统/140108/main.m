//
//  main.m
//  140108
//
//  Created by Rimi07 on 14-1-8.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#define TRUE 1
#define NOTRUE 0
/*
 C阶段综合题：
 有一个社交网络平台，实现其简单功能：
 1、	定义2种角色，分别为普通客户2名、vip客户2名struct _Customer，普通客户可以转变为vip
 2、	关注与粉丝：a用户可关注b用户（普通客户和vip均可），关注后b用户的粉丝数加1。
 3、	vip客户可以花钱购买粉丝，每次可花费3元购买1名粉丝
 4、	将所有普通客户按粉丝数排列。
 5、	所有用户的总粉丝数代表平台的活跃度，公司盈利主要由活跃度（粉丝数）和vip客户消费额决定，每点活跃度可制造18元的广告收入。
 
 输出要求，
 1、输出一名普通客户和它转变为vip后的所有资料
 2、输出该普通客户关注一名客户后的资料，和所关注客户的资料  // a follow b ,a的资料没有变化，输出何用？
 3、每当一名vip客户购买1个粉丝后，输出他的总消费额
 4、按顺序输出普通客户的所有资料
 5、输出公司的总盈利
 （所有数据可自行选择数据类型，也可自定义相关数据的值）。
*/

typedef enum _Type {Normal = -1, VIP} Type;

typedef struct _Customer
{
//    int       uid;
    char    *name;
    Type     type;
    int      fans; // record fans count
//    int    follow; // record follow count
    int      paid; // expense
//    struct _Customer *next; // 链表实现， 具体follow的有哪些人，fans有哪些人
} Customer;


void printOut(Customer cus);
void trans2VIP(Customer *cus);
void follow(Customer *form, Customer *to);
void buyFans(Customer *cus, int n);
void printPaid(Customer cus);
//void sortByFans(Customer cus[], int n);
void printNormalInfoAfterSort(Customer cus[], int n);
int profit(Customer cuss[], int n);

int main(int argc, const char * argv[])
{
    Customer cus1 = {"c1", Normal, 3, 0};
    Customer cus2 = {"c2", Normal, 3, 0};
    Customer cus3 = {"c3", VIP, 13, 3};
    Customer cus4 = {"c4", VIP, 24, 6};
    Customer cus5 = {"c5", Normal, 7, 0};

    // 1. 输出一名普通客户
    printOut(cus1);
    // 1. 转为VIP并输出
    trans2VIP(&cus1);
    printf("\n转为VIP后：\n");
    printOut(cus1);
    
    // 2. cus2 关注 cus3
    printf("\ncus1关注cus2：\n");
    follow(&cus2, &cus3);
    printOut(cus2);
    printOut(cus3);
    
    // 3. cus4买1个fans
    printf("\ncus4买一个fans：\n");
    buyFans(&cus4, 1);
    printPaid(cus4);
    
    // 4. 普通客户按fans排序
    printf("\n\n普通客户按fans排序输出：\n");
    Customer cuss[] = {cus1, cus2, cus3, cus4, cus5};
    printNormalInfoAfterSort(cuss, 5);
    
    // 5. 计算利润
    int gain = profit(cuss, 5);
    printf("\n公司总盈利为：￥%d", gain);
    printf("\n");
    return 0;
}

// 打印客户信息
void printOut(Customer cus)
{
    if (cus.type == VIP)
    {
        printf("name=%s, fans=%d, paid=%d, VIP客户\n", cus.name, cus.fans, cus.paid);
    }
    else
    {
        printf("name=%s, fans=%d, paid=%d, 普通客户\n", cus.name, cus.fans, cus.paid);
    }
}

// 普通客户类型转为VIP
void trans2VIP(Customer *cus)
{
    if (cus->type!=VIP)
    {
        cus->type = VIP;
    }
    else
    {
        printf("VIP用户不需要转换！\n");
    }
}

// 关注
void follow(Customer *form, Customer *to)
{
    to->fans += 1;
}

// 买粉丝
void buyFans(Customer *cus, int n)
{
    if (cus->type == VIP)
    {
        cus->fans += n;
        cus->paid += n*3;
    }
    else
    {
        printf("请先升级为VIP客户");
        exit(0);
    }
}

// 打印消费
void printPaid(Customer cus)
{
    printf("name=%s, paid=%d", cus.name, cus.paid);
}

// 根据粉丝数量排序
void sortByFans(Customer cuss[], int n)
{
    for (int i=0; i<n-1; i++)
    {
        for (int j=0; j<n-1-i; j++)
        {
            if (cuss[j].fans < cuss[j+1].fans)
            {
                Customer temp = cuss[j];
                cuss[j]        = cuss[j+1];
                cuss[j+1]      = temp;
            }
        }
    }
}

// 按粉丝数量排序打印普通客户
void printNormalInfoAfterSort(Customer cuss[], int n)
{
    sortByFans(cuss, n);
    for (int i=0; i<n; i++)
    {
        if (cuss[i].type == Normal)
        {
            printOut(cuss[i]);
        }
    }
}

// 利润
int profit(Customer cuss[], int n)
{
    int ret = 0;
    for (int i=0; i<n; i++)
    {
        ret += cuss[i].fans*18 + cuss[i].paid;
    }
    return ret;
}