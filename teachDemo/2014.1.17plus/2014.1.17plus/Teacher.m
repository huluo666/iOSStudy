//
//  Teacher.m
//  2014.1.17plus
//
//  Created by 张鹏 on 14-1-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher

- (id)initWithName:(NSString *)name {
    
    self = [super init];
    if (self) {
        
        _name = [name copy];
        
    }
    return self;
}

- (void)askQuestion:(NSString *)question {
    
    NSLog(@"teacher name '%@' ask a question named '%@'.", _name, question);
    
    // 通知中心：接收并转发通知
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"AskAQuestionNotificationName"
     object:self
     userInfo:@{@"QuestionKey": question}];
}

- (void)student:(Student *)student answeredQustionWithResult:(NSString *)result {
    
    NSLog(@"student named '%@' answer question with result '%@'.", student.name, result);
}

@end

















