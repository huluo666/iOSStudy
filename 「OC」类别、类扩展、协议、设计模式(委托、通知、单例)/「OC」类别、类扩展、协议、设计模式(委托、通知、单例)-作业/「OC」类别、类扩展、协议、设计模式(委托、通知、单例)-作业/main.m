//
//  main.m
//  「OC」类别、类扩展、协议、设计模式(委托、通知、单例)-作业
//
//  Created by cuan on 14-1-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "NSDate+DateCate.h"
#import "GoodStudent.h"
/*
 1.	在Student类中使用延展增加一个比较2个Student的retainCount值的方法，返回他们的差值。
 2.	使用类目给NSDate类增加2个方法，分别返回当前时间是几点和几分（NSString类型），如3点58分，分别返回@“3”和@“58”。
 3.	定义一个协议，实现一个必须的属性name和可选属性code，增加一个必须的方法compare，使用name属性比较2个对象，返回NSComparisonResult，然后让Student和Teacher类分别支持这个协议。
 4.	给Student设置默认的name和code属性，分别为@“默认”和@“0”，继承它写一个类GoodStudent，同样实现这2个默认属性，并增加一个默认属性type，其值默认为@“good”。
 5.	将Student中name为@“张三”，code为@“0001”的同学作为单例；
 6.	为Student添加一个集合属性score成绩，Teacher持有5个Student，让Student计算自身成绩的平均分并告知Teacher，最后Teacher使用集合统计所有学生的平均分并打印。（使用委托和通知的思想）
 
*/
int main(int argc, const char * argv[])
{
    
#pragma mark  初始化
    Student *student = [[Student alloc] init];
    Student *otherStudent = [[Student alloc] init];
    
    
#pragma mark 比返回2个学生的retainCount的差值
    [student retain];
    NSLog(@"%ld", (long)[student comareRetainCount:otherStudent]);
    
#pragma mark 返回当前时间是几点和几分（NSString类型），如3点58分，分别返回@“3”和@“58”。
    NSDate *date = [[NSDate alloc] init];
    NSLog(@"%@", [date hours]);
    NSLog(@"%@", [date minutes]);
   
#pragma mark 定义一个协议，实现一个必须的属性name和可选属性code...
    GoodStudent *goodStudent = [[GoodStudent alloc] init];
    NSLog(@"%@", goodStudent);
  
#pragma mark 学生单例
    Student *singletonStudent = [Student sharedStudent];
    NSLog(@"%@", singletonStudent);
    
    
#pragma mark 平均分
    Student *Student1 = [[Student alloc] initWithName:@"stu1" code:@"1" scores:[NSMutableArray arrayWithObjects:@92, @78, nil]];
    Student *Student2 = [[Student alloc] initWithName:@"stu2" code:@"2" scores:[NSMutableArray arrayWithObjects:@83, @87, nil]];
    Student *Student3 = [[Student alloc] initWithName:@"stu3" code:@"3" scores:[NSMutableArray arrayWithObjects:@72, @80, nil]];
    Student *Student4 = [[Student alloc] initWithName:@"stu4" code:@"4" scores:[NSMutableArray arrayWithObjects:@91, @88, nil]];
    Student *Student5 = [[Student alloc] initWithName:@"stu5" code:@"5" scores:[NSMutableArray arrayWithObjects:@(88), @(91), nil]];
    
#pragma mark  释放空间
    [student release];
    [student release];
    [otherStudent release];
    [date release];
    return 0;
}

