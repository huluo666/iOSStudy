//
//  main.m
//  OC140111
//
//  Created by cuan on 14-1-10.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"
#import "Tools.h"
#define min(a, b) a>b ? a:b //error

int main(int argc, const char * argv[])
{

    int a = 3, b = 5;
    printf("%d\n", min(a, b)*2);
    
    @autoreleasepool{
        
        // insert code here...
        NSLog(@"Hello, World!");
        
        Person *per = [[Person alloc] init];
        NSLog(@"%@", per);
        
        Person *per2 = [[Person alloc] initWithName:@"Mike" age:23];
        NSLog(@"%@", per2);
        
        Student *stu = [[Student alloc] initWithName:@"Matt" age:23 telephone:@"12376568765" code:@"1243"];
        NSLog(@"%@", stu);    
        [stu print];
        
        NSString *string =  [Tools NSInteger2NSString:2222];
        NSLog(@"%@", string);
        
        NSInteger integer = [Tools NSString2NSInteger:@"11111"];
        NSLog(@"%ld", integer);
        
        Student *student = [[Student alloc] initWithName:@"Peny" age:23 telephone:@"12312348867" code:@"124124412431"];
        NSLog(@"tel:%@", [student telephone]);
        [student Settelephone:@"122222222"];
        NSLog(@"tel:%@", [student telephone]);
        
    }
    return 0;
}


