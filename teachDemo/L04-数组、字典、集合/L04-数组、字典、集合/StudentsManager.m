//
//  StudentsManager.m
//  L04-数组、字典、集合
//
//  Created by 张鹏 on 14-1-12.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "StudentsManager.h"

@implementation StudentsManager

- (id)initWithStudents:(NSMutableArray *)students {
    
    self = [super init];
    if (self) {
        
        _students = students;
        
    }
    return self;
}

- (void)setStudents:(NSMutableArray *)students {
    
    _students = students;
}

- (NSMutableArray *)students {
    
    return _students;
}

#pragma mark - Function methods

- (Student *)searchStudentWithIdentity:(NSString *)identity {
    
    if (!identity || identity.length == 0) {
        return nil;
    }
    if (_students && [_students count] > 0) {
        Student *resultStudent = nil;
        for (Student *student in _students) {
            NSDictionary *infoDictionary = [student infoDictionary];
            if ([[infoDictionary objectForKey:@"identity"] isEqualToString:identity]) {
                resultStudent = student;
            }
        }
        return resultStudent;
    }
    else {
        return nil;
    }
}

- (void)printStudentInformationWithIdentity:(NSString *)identity {
    
    Student *resultStudent = [self searchStudentWithIdentity:identity];
    NSLog(@"%@", resultStudent);
}

- (NSInteger)agesBetweenStudentWithIdentity:(NSString *)identity
                            anotherIdentity:(NSString *)anotherIdentity {
    
    Student *student = [self searchStudentWithIdentity:identity];
    Student *anotherStudent = [self searchStudentWithIdentity:anotherIdentity];
    if (!student || !anotherStudent) {
        NSLog(@"calculate error!");
        return 0;
    }
    NSDictionary *dictionary = [student infoDictionary];
    NSString *name = [dictionary objectForKey:@"name"];
    NSString *age  = [dictionary objectForKey:@"age"];
    
    NSDictionary *anotherDictionary = [anotherStudent infoDictionary];
    NSString *anotherName = [anotherDictionary objectForKey:@"name"];
    NSString *anotherAge  = [anotherDictionary objectForKey:@"age"];
    
    NSLog(@"student name:%@", name);
    NSLog(@"another student name:%@",anotherName);
    
    return [age integerValue] - [anotherAge integerValue];
}

- (void)makeExcellentStudentWithIdentity:(NSString *)identity {
    
    Student *student = [self searchStudentWithIdentity:identity];
    if (!student) {
        NSLog(@"there's no student with identity '%@'.", identity);
        return;
    }
    [[student infoDictionary] setObject:@"Excellent" forKey:@"title"];
}

- (Student *)youngestExcellentStudent {
    
    if (!_students || [_students count] == 0) {
        NSLog(@"can not find the target student with error message 'empty students list'.");
        return nil;
    }
    
    Student *resultStudent = nil;
    NSInteger minimumAge = 100;
    for (Student *student in _students) {
        NSDictionary *infoDictionary = [student infoDictionary];
        if ([[infoDictionary objectForKey:@"title"] isEqualToString:@"Excellent"]) {
            NSInteger age = [[infoDictionary objectForKey:@"age"] integerValue];
            if (minimumAge > age) {
                minimumAge = age;
                resultStudent = student;
            }
        }
    }
    return resultStudent;
}

@end






