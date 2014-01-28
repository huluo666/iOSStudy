//
//  Person.h
//  OCExercise140113
//
//  Created by cuan on 14-1-13.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (copy)   NSString            *name;
@property (copy)   NSString            *sex;
@property (copy)   NSString            *IDNumber;
@property (assign,readwrite) NSInteger            age;
@property (retain) NSMutableDictionary *mDic;

- (void)dealloc;
- (id) initWithName:(NSString *)name sex:(NSString *)sex IDNumber:(NSString *)IDNumber age:(NSInteger)age;
- (NSInteger) countAgeDiffToStudent:(Student *)student;
- (void) addTitle;

+ (void) findStudentByIDNumber:(NSString *)IDNumber fromStudentArray:(NSArray *)studentArray;
+ (Student *) findTheYoungestExcellentStudent:(NSArray *)studentArray;

@end
