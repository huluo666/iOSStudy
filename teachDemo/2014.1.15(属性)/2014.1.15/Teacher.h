//
//  Teacher.h
//  2014.1.15
//
//  Created by 张鹏 on 14-1-15.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

@interface Teacher : NSObject {
    
    Student *_student;
}

@property (retain, nonatomic) Student *student;

- (id)initWithStudent:(Student *)student;

@end













