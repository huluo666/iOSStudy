//
//  main.m
//  exercise_1231
//
//  Created by Rimi07 on 13-12-31.
//  Copyright (c) 2013年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdlib.h>

/*
 1、写一个函数，返回输入整数（大于999小于10000）的每位数的数字之和。
 
 2、写一个函数，将传入的字符串转为全大写，数字和符号不变。
 
 3、写一个函数，参数为1个数组和一个字符串数组，要求实现输出这2个数组合并由小到大排序后的整形数组。如{1，45}加{“23”，“111”，“122“}等于{1，23，45，111，122}。
 
 4、写一个函数返回一个int数组中的最大重复数（数组元素的重复次数为该元素在数组中出现的次数），如{1，1，3，2，1，2，3}最大重复数为3
 
 5、写一个函数，将传入的字符串每个单词的首字母转为大写，并输出
 
 
 
*/

// 第1题
int retCount(int num)
{
    int     myriad = num % 10000 / 1000;
    int  thousands = num % 1000 / 100;
    int   hundreds = num % 100 / 10;
    int      units = num % 10;
    return myriad+thousands+hundreds+units;
}


// 第2题
char *convert(char *str, char *dest)
{
    for (int i=0; *(str+i); i++)
    {
        if (*(str+i)>='a' && *(str+i) <='z')
        {
            *(dest+i) = *(str+i)+'A'-'a';
        }
        else
        {
            *(dest+i) = *(str+i);
        }
    }
    return dest;
}


/*
// 动态分配内存方法
char *convert2(const char *str)
{
    char *p = malloc(strlen(str)/sizeof(char)+1);
    
    for (int i=0; *(str+i); i++)
    {
        if (*(str+i)>='a' && *(str+i) <='z')
        {
            *(p+i) = *(str+i)+'A'-'a';
        }
        else
        {
            *(p+i) = *(str+i);
        }
    }
    return p;
}*/


// 第3题
void sort(int *arr, int n)
{
    int flag = 0;
    
    for (int i=0; i<n-1; i++)
    {
        for (int j=0; j<n-1-i; j++)
        {
            if (arr[j] > arr[j+1])
            {
                arr[j] = arr[j] + arr[j+1];
                arr[j+1] = arr[j] - arr[j+1];
                arr[j] = arr[j] - arr[j+1];
                flag = 1;
            }
        }
        if (flag == 0)
        {
            break;
        }
    }
}

// 将数字字符串转整型数据
int strToDigit(char * str)
{
    int tmp;
    sscanf(str, "%d", &tmp);
    return tmp;
}

int strToDigit2(char *str)
{
    int tmp = 0;
    while (*str)
    {
        tmp *= 10;
        tmp += *str - '0';
        ++str;
    }
    return tmp;
}

// 函数中如何获取到数组的长度?
void mergeArrandSort(int *intArr, int end, char *chArr[])
{
    int arr[100] = {0};
    int len = (int)strlen(*chArr);
    
    int n=0; /* 记录新数组长度 */
    for (; n<len; n++) /* 转换字符数组为整型数组 */
    {
//        arr[n] = (int)atol(chArr[n]);
        arr[n] = (int)strToDigit2(chArr[n]);
    }
    
    for (int j=0; j<end; j++, n++) // length=5
    {
        arr[n] = intArr[j];
    }
    
    sort(arr, n); /* 排序 */
    
    for (int i=0; i<n; i++) /* 打印 */
    {
        printf("%d ", arr[i]);
    }

    printf("\n\n");
}

// teracher's solution
int intValue(char *s)
{
    //"1234"
    int bit = 1;
    int value = 0;
    for (int i= 0; i<strlen(s); i++) {
        value += bit * (s[strlen(s)-i-1] - '0');
        bit *= 10;
    }
    return value;
}

void combain(int a[],int n,char *b[],int m,int c[])
{
    for (int i = 0; i<m+n; i++) {
        if (i<n) {
            c[i] = a[i];
        } else {
            c[i] = intValue(b[i-n]);
        }
    }
    //排序并输出
}

////////////

// 第4题
int getMaxRepeatCount(int arr[], int len)
{
    int max = 0, count = 0;
    for (int i=0; i<len; i++)
    {
        for (int j=0; j<len; j++)
        {
            if (arr[i] == arr[j])
            {
                count++;
            }
        }
        
        if (max < count)
        {
            max = count;
        }
        
        count = 0;
    }
    
    return max;
}

// 第5题
void converString(char *str) // 接受字符串
{
    // 先将字符串拷贝一份到字符串数组
    char record[100] = {0};
    int len=0;
    for (; *(str+len); len++)
    {
        record[len] = *(str+len);
    }
    record[len] = '\0';
    
    if (record[0]>='a' && record[0]<='z')
    {
        record[0] += 'A'-'a';
    }
    
    for (int i=1; *(record+i); i++) // i<len
    {
        if ((record[i-1] == ' ' || record[i-1] == ','
             || record[i-1] == '.' || record[i-1] == '\n')
            && record[i]>='a' && record[i]<='z')
        {
            record[i] += 'A'-'a';
        }
    }
    printf("%s", record);
    
    /*
    // 注意:字符串不能修改值,需要改的话,拷贝到数组
    if (str[0]>='a' && str[0]<='z')
    {
        str[0] = str[0]+'A'-'a';
    }
    printf("%s", str);
    */
 
}

void converString2(char str[]) // 接受数组
{
    if (str[0]>='a' && str[0]<='z')
    {
        str[0] += 'A'-'a';
    }
    
    for (int i=1; i<strlen(str); i++)
    {
        if ((str[i-1] == ' ' || str[i-1] == ','
             || str[i-1] == '.' || str[i-1] == '\n')
            && str[i]>='a' && str[i]<='z')
        {
            str[i] += 'A'-'a';
        }
    }
}

// teacher'l solution
void translate(char s[])
{
    //s = "avc dfa yutre 123 dfadfa.fsad fd\ndf."
    if (s[0] >= 'a'&&s[0]<='z') {
        s[0] += 'A'-'a';
    }
    for (int i = 1; i<strlen(s)-1; i++) {
        if (s[i] == ' '||s[i]=='\n'||s[i]=='.'||s[i] == ',') {
            if (s[i+1]>='a'&&s[i+1]<='z') {
                s[i+1] += 'A'-'a';
            }
        }
    }
}


int main(int argc, const char * argv[])
{

    
    // 第1题
    printf("第1题:\n");
    printf("num=%d\n", 2361);
    int count = retCount(2361);
    printf("sum=%d\n\n", count);
    
    // 第2题
    printf("第2题:\n");
    char *str = "ajld!j8&78dal*dads";
    printf("before convert:\n%s\n", str);
    char dest[100] = {0};
    str = convert(str, dest);
    printf("after convert:\n%s\n\n", str);
    
    
    // 第3题
    printf("第3题:\n");
    int intArr[] = {1, 23, 45, 111,122};
    char *chArr[] = {"111", "222", "33"};
    mergeArrandSort(intArr, 5, chArr);
    printf("\n\n");
    
    
    // 第4题
    printf("第4题:\n");
    int arr[] = {1, 1, 3, 2, 1, 2, 3};
    int countTimes = getMaxRepeatCount(arr, sizeof(arr)/sizeof(arr[0]));
    printf("maxRepeatCount=%d\n\n", countTimes);
    
    // 第5题
    printf("第5题:\n");
    char *line = "this is a test!, anf.algaaogd\nhhh";
    converString(line);
    printf("\n");
    char string[] = "this is a test!, anf.algaaogd\nhhh";
    converString(string);
    printf("\n\n");

    return 0;
}

/*
// 遍历字符串
 char *s = "abadd";
 int i=0;
 while (*(s+i))
 {
 printf("%c", *(s+i));
 i++;
 }
 
 for (int i=0; *(s+i); i++)
 {
 printf("%c", *(s+i));
 }
 
 
*/
