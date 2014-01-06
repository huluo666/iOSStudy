//
//  main.m
//  exercise_140106
//
//  Created by Rimi07 on 14-1-6.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 
 1、	任意的整型数组，如果小于均值的数比大于均值的多，成为“偏小数组”，反之称作“偏大数组”，如果相等，称作“均衡数组”，写一个函数，判定并输出任意数组的类型。
 2、	有5名学生，3门课，求出有2门以上排名在前3的同学，并输出其所有资料。
 3、	一人岁数的3次方是四位数，四次方是六位数，并知道此人岁数的3次方和4次方用遍了0～9十个数字。编写一程序求此人的岁数。
 4、	假定一个操作系统有1000个单位的使用空间，每次启动随机占用500-600的空间，如果启动后空间剩余不足10%则系统崩溃。系统运行结束后将产生总空间占用（系统和上次残留）5%的残留，随后用户可以进行清理，每次清理可释放160个单位残留，问一般使用多少次后清理一次，即可保证系统正常使用。
 
*/

int exer1();
int exer2();
int exer3();
int exer4();
int main(int argc, const char * argv[])
{
//    char age[10000] = {0};
//    for (int i=11; i<22; i++) {
//        sprintf(age,"%d%d",i*i*i,i*i*i*i);
//        printf("%s\n",age);
//    }

    exer1();
    exer2();
    exer3();
    exer4();
    return 0;
}

