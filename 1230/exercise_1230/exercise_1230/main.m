//
//  main.m
//  exercise_1230
//
//  Created by Rimi07 on 13-12-30.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 
 1、	随机产生20个100-200之间的正整数存放到数组中，并求数组中的所有元素最大值、最小值、平均值，然后将各元素的与平均值的差组成一个新数组。
 2、	将任意2个int类型数组按从小到大排序，然后合并成一个新的从小到大的数组。
 3、	使用数组描述正整数的二进制表示，如5，则数组为{1，0，1}
 4、	实现将字符串加密的方法，即将原有字符串中所有字母的ascII值加3， x，y，z加密后分别为a，b，c，数字与符号不变，然后输出得到的新字符串。
 5、	实现将任意数字字符串转换成int、float类型，“345”转成int类型345，“35.8”转换成float类型35.8。
 6、	找出一个二维数组中的“鞍点”，即该位置上的元素在该行中最大，在该列中最小（也可能没有“鞍点”）
 
 7、	有100000个qq号，从000000到999999不等，在只读取1遍的前提下将其中重复的qq号挑出。（使用随机数模拟，数组长度不限）
 
 8、	有一行英文语句，统计其中的单词个数（单词之间以空格分隔），并将每一个单词的第一个字母改为大写。
 
 9、	计算以下字符串数值的和{“123”，“003”，“1a23”，“456abc”}。字母前的数字为有效数值，如1a23的值为1，12a3的值为12。
 
 10、	模拟电影票选座系统，将100个座位号当做10*10二维数组，然后用0表示该座位未售出，1表示已售出，任意顾客来买票时，若为1张，则随即抽取一个编号，若为2张，优先选择并排连续的座位，若无连座，则随即选取2个座位号。（使用随机数模拟）
 
*/

int exer1();
int exer2();
int exer3();
int exer4();
int exer5();
int exer6();
int exer7();
int exer8();
int exer9();
int exer10();

int array[10][10] = {0};
int findForOne();


// not finished: t7, t10
int main(int argc, const char * argv[])
{
    exer1();
    exer2();
    exer3();
    exer4();
    exer5();
    exer6();

    printf("第7题:\n");
    const int COUNT = 1000;
    int qq[COUNT] = {0};
    //模拟qq号
    for (int i=0; i<COUNT; i++)
    {
        qq[i] = arc4random()%COUNT;
    }
    
    // 记录重复qq号
    int record[COUNT] = {0};
    for (int i=0; i<COUNT; i++)
    {
        record[qq[i]] += 1; // record 数组下标为qq号码，值为重复的次数
    }
    
    // 找出重复的qq号
    printf("重复的qq号为：\n");
    for (int i=0; i<COUNT; i++)
    {
        if (record[i]>=2)
        {
            printf("qq号%-3d 重复%d次\n", i, record[i]);
        }
    }
    
    
    printf("\n\n");
    
    
    exer8();
    exer9();
    
    // 第10题
    
    for (int i = 0; i<10; i++) {
        for (int j = 0; j<10; j++) {
            array[i][j] = arc4random()%2;
        }
    }
    
    int n = 2;
    if (n == 1) {
        //随即一张票
        int ticket = findForOne();
        printf("卖出去的票是%d\n",ticket);
    }
    if (n == 2) {
        //并排连座
        BOOL find = NO;
        for (int i = 0; i<10; i++) {
            for (int j = 0; j<9; j++) {
                if (array[i][j] == 0&&array[i][j+1] == 0) {
                    printf("卖出去的票是：%d %d\n",10*i+j+1,10*i+j+2);
                    array[i][j] = 1;
                    array[i][j+1] = 1;
                    find = YES;
                    goto PPT;
                }
            }
        }
    PPT:
        if (!find) {
            //....
            //随即2张票
            int ticket1 = findForOne();
            int ticket2 = findForOne();
            printf("卖出去的票是：%d和%d\n",ticket1,ticket2);
        }
    }

    
    return 0;
}


int findForOne()
{
    int s[100] = {0};
    int k = 0;
    for (int i = 0; i<10; i++) {
        for (int j = 0; j<10; j++) {
            if (array[i][j] == 0) {
                s[k] = i*10 + j+1;
                k++;
            }
        }
    }
    int index = arc4random()%k;
    int x = s[k]/10;
    int y = s[k]%10-1;
    if (s[k]%10 == 0) {
        y = 9;
    }
    array[x][y] = 1;
    return s[index];
}

