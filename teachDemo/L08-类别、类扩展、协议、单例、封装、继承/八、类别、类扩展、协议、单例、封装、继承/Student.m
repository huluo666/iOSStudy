//
//  Student.m
//  八、类别、类扩展、协议、单例、封装、继承
//
//  Created by 张鹏 on 13-11-6.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import "Student.h"
#import "Teacher.h"

static Student * student = nil;

@implementation Student

+ (instancetype)sharedStudent {
    
    if (!student) {
        student = [[self alloc] init];
        student.name = @"张三";
        student.code = @"0001";
    }
    return student;
}

- (id)init {
    
    return [self initWithName:@"默认"
                         code:@"0"
                       scores:@[@0, @0, @0, @0]];
}

- (id)initWithName:(NSString *)name
              code:(NSString *)code
            scores:(NSArray *)scores {
    
    self = [super init];
    if (self) {
        
        _name   = [name copy];
        _code   = [code copy];
        _scores = [scores retain];
        
        [self registerNotification];
    }
    return self;
}

- (void)dealloc {
    
    [_name   release];
    [_code   release];
    [_scores release];
    
    // 清空委托对象指针
    _delegate = nil;
    
    // 从通知中心移除自身通知监听者的身份
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"\nstudent:\nname:%@\ncode:%@\nscores:%@",
            _name, _code, _scores];
}

- (NSUInteger)compareRetainCountWithStudent:(Student *)student {
    
    if (!student) {
        return [self retainCount];
    }
    return [self retainCount] - [student retainCount];
}

#pragma mark - <CustomProtocol>

- (NSComparisonResult)compare:(id <CustomProtocol>)object {
    
    return [_name compare:object.name];
}

#pragma mark - Notification methods

- (void)registerNotification {
    
    // 向通知中心注册自身为通知监听者，坚挺Teacher的通知并响应通知事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(processAverageScore)
                                                 name:TeacherNotificationName
                                               object:nil];
}

- (void)processAverageScore {
    
    // 计算所有课程平均分
    double averageScore = 0;
    if (_scores && [_scores count] > 0) {
        for (NSNumber *score in _scores) {
            averageScore += [score integerValue];
        }
        averageScore /= [_scores count];
    }
    // 平均分计算完成，将计算结果及自身对象传给委托对象，委托对象进行后续处理
    if (_delegate &&
        [_delegate respondsToSelector:@selector(student:completeProcessAverageScore:)]) {
        [_delegate student:self completeProcessAverageScore:averageScore];
    }
}

@end

















