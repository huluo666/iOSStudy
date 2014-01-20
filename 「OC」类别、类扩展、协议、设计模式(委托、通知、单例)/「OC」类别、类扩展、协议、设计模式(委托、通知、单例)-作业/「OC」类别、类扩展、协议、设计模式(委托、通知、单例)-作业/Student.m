//
//  Student.m
//  「OC」类别、类扩展、协议、设计模式(委托、通知、单例)-作业
//
//  Created by cuan on 14-1-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Student.h"

static Student *studentSingleton = nil;

@implementation Student

- (id)init
{
    if (self = [super init])
    {
        _name = @"默认";
        _code = @"0";
    }
    
    return self;
}

- (id)initWithName:(NSString *)name code:(NSString *)code scores:(NSMutableArray *)scores
{
    if (self = [super init])
    {
        _name = [name copy];
        _code = [code copy];
        _scores = [scores retain];
        
        [self registerNotification];
    }
    return self;
}

- (void)dealloc
{
    [_name release];
    [_code release];
    [_scores release];
    _delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

- (NSInteger)comareRetainCount:(Student *)student
{
    if (!student)
    {
        return [self retainCount];
    }
    return [self retainCount] - [student retainCount];
}

- (NSComparisonResult)compare:(id)object
{
    return [[self name] compare:[object name]];
}

- (double)calculateAvg
{
    int avg = 0;
    
    for (NSNumber *score in _scores)
    {
        avg += [score integerValue];
    }
    
    return avg;
}

+ (instancetype)sharedStudent
{
    if (!studentSingleton)
    {
        studentSingleton = [[self alloc] initWithName:@"张三" code:@"0001" scores:[NSMutableArray arrayWithObjects:@91, @83, nil] ];
    }
    
    return studentSingleton;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@, code = %@", _name, _code];
}

extern NSString * const TeacherNotificationName;
- (void) registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(calculateAverageScore)
                                                 name:TeacherNotificationName
                                               object:nil];
}



- (void)calculateAverageScore
{
    double averageScore = 0 ;
    if (_scores && [_scores count] > 0)
    {
        for (NSNumber *score in _scores)
        {
            averageScore += [score integerValue];
        }
        averageScore /= [_scores count];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(printStudent:averageScore:)])
    {
        [_delegate printStudent:self averageScore:averageScore];
    }
}



@end
