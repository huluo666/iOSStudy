//
//  Student.m
//  OCExercise140115
//
//  Created by cuan on 14-1-15.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Student.h"
#import "Utils.h"

@implementation Student

- (id)initWithName:(NSString *)name
               age:(NSInteger)age
          IDNumber:(NSString *)IDNumber
           pointer:(NSPoint)pointer
{
    if (self = [super init])
    {
        _name      = [name copy];
        _age       = age;
        _IDNumber  = [IDNumber copy];
        _birthday  = [Utils getBirthDateWithIDString:_IDNumber];
        _type      = @"student";
        _pointer.x = pointer.x;
        _pointer.y = pointer.y;
    }
    
    return self;
}

- (void)dealloc
{
    [_name release];
    [_IDNumber release];
    [_birthday release];
    [_type release];
    [super dealloc];
}

- (NSString *)description
{
    return [NSString stringWithFormat:
            @"name = %@, age = %ld, IDNumber = %@, birthday = %@, type = %@ row = %f,  col= %f",
            _name, _age, _IDNumber, _birthday, _type, _pointer.x, _pointer.y];
}

- (CGFloat) distanceWithStudent:(Student *)student
{
    return sqrt(pow(_pointer.x - student.pointer.x, 2) + pow(_pointer.y - student.pointer.y, 2));
}

@end
