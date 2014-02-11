//
//  Student.m
//  2014.1.17plus
//
//  Created by 张鹏 on 14-1-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Student.h"

@implementation Student

- (id)initWithName:(NSString *)name {
    
    self = [super init];
    if (self) {
        
        _name = [name copy];
        
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(answerQuestion:)
         name:@"AskAQuestionNotificationName"
         object:nil];
        
    }
    return self;
}

- (void)dealloc {
    
    [_name release];
    
    [super dealloc];
}

- (void)answerQuestion:(NSNotification *)notification {
    
    NSString *question = [notification.userInfo objectForKey:@"QuestionKey"];
    NSLog(@"student name '%@' receive a question named '%@'.", _name, question);

    if (_delegate &&
        [_delegate conformsToProtocol:@protocol(StudentDelegate)] &&
        [_delegate respondsToSelector:@selector(student:answeredQustionWithResult:)]) {
        [_delegate student:self answeredQustionWithResult:@"male"];
    }
}



@end










