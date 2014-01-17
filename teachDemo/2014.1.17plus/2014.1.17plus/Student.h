//
//  Student.h
//  2014.1.17plus
//
//  Created by 张鹏 on 14-1-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Student;

// 委托：通过协议来完成
// 委托协议
@protocol StudentDelegate <NSObject>

- (void)student:(Student *)student
        answeredQustionWithResult:(NSString *)result;

@end

@interface Student : NSObject {
    
    NSString *_name;
    id<StudentDelegate> _delegate;
}

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) id<StudentDelegate> delegate;

- (id)initWithName:(NSString *)name;

- (void)answerQuestion:(NSNotification *)notification;

@end











