//
//  main.m
//  exam
//
//  Created by Rimi07 on 14-1-8.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#define LIMIT 20
/*
 假定你现在是苹果公司的二级代理商，现在需要管理苹果公司硬件产品销售、售后、客户管理等服务。
 1.你的商品列表包括iphone5s、ipadAir、ipadmini，每个产品有名称、价格、UDID（产品唯一识别码）、颜色。你的客户列表包括名称、电话、购买列表。
 2.通过指定折扣率可以对某个类型产品进行打折处理（不影响其他产品）。
 3.用户可指定产品购买，通过名称、颜色指定产品，然后系统随机选取一台出售给客户，客户的购买列表中添加产品的UDID。
 4.如果某个产品由于质量问题需追回，则需使用一个新的同类产品找到指定客户替换，同时给予产品当前价格5%的补偿。
 5.累计收入为产品销售总额扣除支出总额。
 
 输出要求：
 1.输出一个产品和客户的信息
 2.按UDID顺序输出ipadmini打8.9折后所有ipadmini的信息
 3.一名客户购买一台iphone5s后，输出其相关资料
 4.追回一名客户的ipadair后，输出客户信息。
 5.输出代理商的累计收入
 （所有数据可自行选择数据类型，也可自定义相关数据的值）
 
*/
typedef enum _Type
{
    iphone5s, ipadAir, ipadmini
} Type;

typedef enum _Color
{
    white, black, gold
} Color;

typedef struct _Product
{
    Type   type;
    Color color;
    int    UDID;
    float  price;
    BOOL  isSold; // 是否已经售出
} Product;

typedef struct _Consumer
{
    char      *name;
    char     *phone;
    int    list[LIMIT]; // 每人最多购买20件Apple产品
} Consumer;


void printProductInfo(Product pro);
void printConsumerInfo(Consumer cons);
void discount(Product pro[], int n, float d) ;
void sortByUDID(Product pro[], int n);
Product *buy(Consumer *cons, Type type, Color color, Product ip[], int n, Product pa[], int p, Product pm[], int q);
void replace(Consumer *cons, Product *pro, Product ip[], int n, Product pa[], int p, Product pm[], int q);
void soldAll(Product ip[], int n, Product pa[], int p, Product pm[], int q);
float income(Product ip[], int n, Product pa[], int p, Product pm[], int q);

int main(int argc, const char * argv[])
{
  
    // 1. 创建一个产品
    printf("1.\n");
    Product ip0 = {iphone5s, gold, 1, 500, NO};
    printf("打印一个产品和客户信息：\n");
    printProductInfo(ip0);
    
    // 1.创建并打印顾客信息
    Consumer cons1 = {"M1", "13567845612", {001}};
    printConsumerInfo(cons1);
    
   
    // 2.
    printf("\n2.\n");
    Product pm1 = {ipadmini, black, 209, 220, NO};
    Product pm2 = {ipadmini, white, 202, 250, NO};
    Product pm3 = {ipadmini, gold, 207, 300, NO};
    Product pm4 = {ipadmini, gold, 204, 300, NO};
    Product pm[4] = {pm1, pm2, pm3, pm4};
    
    sortByUDID(pm, 4); // 根据UDID排序
    
    discount(pm, 4, 0.89); // 折扣
    printf("ipadmini打8.9折后信息如下：\n");
    for (int i=0; i<4; i++)
    {
        printProductInfo(pm[i]);
    }
    
    
    // 3.
    printf("\n3.\n");
    // 构建产品库
    Product ip1 = {iphone5s, black, 130, 400, NO};
    Product ip2 = {iphone5s, white, 171, 450, NO};
    Product ip3 = {iphone5s, black, 123, 400, NO};
    Product ip4 = {iphone5s, white, 163, 450, NO};
    Product ip5 = {iphone5s, gold, 124, 500, NO};
    Product ip6 = {iphone5s, white, 188, 450, NO};
    Product ip[6] = {ip1, ip2, ip3, ip4, ip5, ip6};
    
    Product pa1 = {ipadAir, white, 311, 450, NO};
    Product pa2 = {ipadAir, gold, 312, 470, NO};
    Product pa3 = {ipadAir, black, 321, 420, NO};
    Product pa4 = {ipadAir, white, 319, 450, NO};
    Product pa5 = {ipadAir, gold, 322, 470, NO};
    Product pa6 = {ipadAir, black, 357, 420, NO};
    Product pa7 = {ipadAir, white, 310, 450, NO};
    Product pa[7] = {pa1, pa2, pa3, pa4, pa5, pa6, pa7};
    
    // 购买iphone5s
    buy(&cons1, iphone5s, gold, ip, 6, pa, 7, pm, 4);
    printf("M1购买iphones后客户信息：\n");
    printConsumerInfo(cons1);
    
    
    // 4.
    // 先买一个ipadair
    printf("\n4.\n");
    Product *p = buy(&cons1, ipadAir, gold, ip, 6, pa, 7, pm, 4);
    printf("换货前：\n");
    printConsumerInfo(cons1);
    printf("换货后：\n");
    replace(&cons1, p, ip, 6, pa, 7, pm, 4);
    printConsumerInfo(cons1);
    
    
    // 5.
    printf("\n5.\n");
    soldAll(ip, 6, pa, 7, pm, 4); // 卖出所有产品
    p->isSold = NO; // 排除问题产品
    float get = income(ip, 6, pa, 6, pm, 4);
    printf("代理商的累计收入为：$%f", get);
    printf("\n");
    return 0;
}

// 获取产品类型
char *getType(Product pro)
{
    char *s = (char *) malloc(9);
    Type type = pro.type;
    switch (type)
    {
        case iphone5s:
            strcat(s, "iphone5s");
            break;
        case ipadAir:
            strcat(s, "ipadAir");
            break;
        case ipadmini:
            strcat(s, "ipadmini");
        default:
            break;
    }
    return s;
}

// 获取产品颜色
char *getColor(Product pro)
{
    char *s = (char *) malloc(6);
    Color color = pro.color;
    switch (color)
    {
        case white:
            strcat(s, "white");
            break;
        case black:
            strcat(s, "black");
            break;
        case gold:
            strcat(s, "gold");
        default:
            break;
    }
    return s;
}

// 打印产品信息
void printProductInfo(Product pro)
{
    char *type  = getType(pro);
    char *color = getColor(pro);
    printf("type:%10s, price:$%f, UDID:%d, color:%s\n", type, pro.price, pro.UDID, color);
//    free(type); // 为什么不能加这两句？
//    free(color);
}

// 打印客户信息
void printConsumerInfo(Consumer cons)
{
    printf("name:%s, phone:%s 产品列表(UDID):", cons.name, cons.phone);

    for (int i=0; i<LIMIT; i++)
    {
        if (cons.list[i])
        {
            printf(" %d", cons.list[i]);
        }
    }
    printf("\n");
}

// 指定折扣
void discount(Product pro[], int n, float d) // 0<n<1
{
    for (int i=0; i<n; i++)
    {
        pro[i].price *= d;
    }
}

// 按照UDID排序
void sortByUDID(Product pro[], int n)
{
    for (int i=0; i<n-1; i++)
    {
        for (int j=0; j<n-1-i; j++)
        {
            if (pro[j].UDID > pro[j+1].UDID)
            {
                Product temp = pro[j];
                pro[j]       = pro[j+1];
                pro[j+1]     = temp;
            }
        }
    }
}

Product *buy(Consumer *cons, Type type, Color color, Product ip[], int n, Product pa[], int p, Product pm[], int q) // 未完待续
{
    // 获取顾客购买列表长度
    int count = 0;
    for (int i=0; i<LIMIT; i++)
    {
        if (cons->list[i])
        {
            count++;
        }
    }
    
    BOOL isGet = YES; // 是否得到所需产品
    // 购买iphone5s
    if (type == iphone5s)
    {
        for (int i=0; i<n; i++)
        {
            if (ip[i].isSold)
                continue;
            
            if (color == ip[i].color)
            {
                cons->list[count] = ip[i].UDID;
                ip[i].isSold = YES;
                return &ip[i];
            }
            else
            {
                isGet = NO;
            }
        }
    }
    else if (type == ipadAir) // 购买ipadAir
    {
        for (int i=0; i<p; i++)
        {
            if (pa[i].isSold)
                continue;
            
            if (color == pa[i].color)
            {
                cons->list[count] = pa[i].UDID;
                pa[i].isSold = YES;
                return &pa[i];
            }
            else
            {
                isGet = NO;
            }

        }
    }
    else if (type == ipadmini) // 购买ipadmini
    {
        for (int i=0; i<q; i++)
        {
            if (pm[i].isSold)
                continue;
            
            if (color == pm[i].color)
            {
                cons->list[count] = pm[i].UDID;
                pm[i].isSold = YES;
                return &pm[i];
            }
            else
            {
                isGet = NO;
            }
        }
    }
    else
    {
        printf("Are you kidding me ?\n");
    }
    
    if (isGet == NO)
    {
        printf("当前产品库没有需要的产品！\n");
    }
    
    return NULL;
}

// 换货
void replace(Consumer *cons, Product *pro, Product ip[], int n, Product pa[], int p, Product pm[], int q)
{
    // 获取顾客购买列表长度
    int count = 0;
    for (int i=0; i<LIMIT; i++)
    {
        if (cons->list[i])
        {
            count++;
        }
    }
    cons->list[count-1] = 0;

    Type type   = pro->type;
    Color color = pro->color;
    
    Product *re = buy(cons, type, color, ip, n, pa, p, pm, q);
    re->price *= 0.95;
    re->isSold = YES;
    pro->isSold = NO;
}

// 卖光
void soldAll(Product ip[], int n, Product pa[], int p, Product pm[], int q)
{
    for (int i=0; i<n; i++)
    {
        ip[i].isSold = YES;
    }
    
    for (int i=0; i<p; i++)
    {
        pa[i].isSold = YES;
    }
    
    for (int i=0; i<q; i++)
    {
        pm[i].isSold = YES;
    }
}

// 获取的收入（售出产品的总销售额，换货支出已经在换货阶段处理了）
float income(Product ip[], int n, Product pa[], int p, Product pm[], int q) // 参数为所有产品库的信息
{
    float sum = 0.0f;
    for (int i=0; i<n; i++)
    {
        if (!ip[i].isSold)
        {
            continue;
        }
        
        sum += ip[i].price;
    }
    
    for (int i=0; i<p; i++)
    {
        if (!pa[i].isSold)
        {
            continue;
        }
        
        sum += pa[i].price;
    }
    
    for (int i=0; i<q; i++)
    {
        if (!pm[i].isSold)
        {
            continue;
        }
        
        sum += pm[i].price;
    }
    
    return sum;
}
