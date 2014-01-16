//
//  Manager.h
//  2014.1.16
//
//  Created by 张鹏 on 14-1-16.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Teacher.h"
#import "Student.h"

@interface Manager : NSObject {
    
    Student *_student;
    Teacher *_teacher;
}

@property (retain, nonatomic) Student *student;
@property (retain, nonatomic) Teacher *teacher;

- (NSInteger)agesDifference;
- (void)exchangeName;
- (void)exchangeAge;

- (void)changeAgeTeacher:(Teacher *)teacher student:(Student *)student;

@end













