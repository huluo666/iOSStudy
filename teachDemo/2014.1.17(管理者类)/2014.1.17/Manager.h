//
//  Manager.h
//  2014.1.17
//
//  Created by 张鹏 on 14-1-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

@interface Manager : NSObject {
    
    NSMutableArray *_students;
}

@property (retain, nonatomic) NSMutableArray *students;

- (id)initWithStudents:(NSMutableArray *)students;

- (void)sortStudents;
- (Student *)highestScoreStudent;

@end










