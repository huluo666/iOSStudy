//
//  Teacher.h
//  2014.1.17plus
//
//  Created by 张鹏 on 14-1-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

@interface Teacher : NSObject <StudentDelegate> {
    
    NSString *_name;
}

@property (copy, nonatomic) NSString *name;

- (id)initWithName:(NSString *)name;

- (void)askQuestion:(NSString *)question;

@end











