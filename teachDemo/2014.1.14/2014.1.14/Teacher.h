//
//  Teacher.h
//  2014.1.14
//
//  Created by 张鹏 on 14-1-14.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

@interface Teacher : NSObject {
    
    // 简单数据类型（复杂数据类型）无需内存管理
    NSInteger _age;
    Student *_student;
}

- (id)initWithStudent:(Student *)student;
+ (Teacher *)teacher;
+ (Teacher *)teacherWithStudent:(Student *)student;

- (void)setStudent:(Student *)student;
- (Student *)student;

@end














