//
//  Observer.h
//  七、引用与传值、类与类的关联
//
//  Created by 张鹏 on 13-11-4.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import "Teacher.h"

@interface Observer : NSObject {
    
    Student *_student;
    Teacher *_teacher;
}

@property (retain, nonatomic) Student *student;
@property (retain, nonatomic) Teacher *teacher;

- (id)initWithStudent:(Student *)student teacher:(Teacher *)teacher;

- (NSInteger)daysBetweenBirthdays;
- (void)changeAges;
+ (NSArray *)agesList;

@end












