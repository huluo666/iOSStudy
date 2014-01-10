//
//  Teacher.h
//  OCExercise140111
//
//  Created by cuan on 14-1-10.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Person.h"
#import "Student.h"
//#define COUNT 10

@interface Teacher : Person
{
    Student *_student;
}

- (id) init;
- (id) initWithName:(NSString *)name age:(NSInteger)age height:(NSInteger)height student:(Student *)student;
- (NSInteger) ageDifferenceWith:(Student *)student;
@end
