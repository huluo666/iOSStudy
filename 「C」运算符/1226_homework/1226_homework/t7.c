//
//  t7.c
//  1226_homework
//
//  Created by Rimi07 on 13-12-26.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#include <stdio.h>
/*
 7、将2.88元的人民币换成硬币，请问需要每种硬币各几个（硬币有1元 ，5角 ，2角， 1角，5分，2分，1分几种）
*/
int test7()
{
    float money = 2.88f;
    int mon = money*100;
    int yuan = mon / 100;
    int x1 =  mon % 100;
    
    int wujiao = x1 / 50;
    int x2 = x1 % 50;
    
    int erjiao = x2 / 20;
    int x3 = x2 % 20;
    
    int yijiao = x3 / 10;
    int x4 = x3 % 10;
    
    int wufen = x4 / 5;
    int x5 = x4 % 5;
    
    int erfen = x5 / 2;
    int x6 = x5 % 2;
    
    int yifen = x6 / 1;
    
    printf("1元%d张，5角%d张，2角%d张，1角%d张，5分%d张，2分%d张,1分%d张", yuan, wujiao, erjiao, yijiao, wufen, erfen, yifen);
    return 0;
}