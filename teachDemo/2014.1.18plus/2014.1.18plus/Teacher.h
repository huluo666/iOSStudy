//
//  Teacher.h
//  2014.1.18plus
//
//  Created by 张鹏 on 14-1-18.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompareProtocol.h"
#import "Student.h"

@interface Teacher : NSObject <CompareProtocol> {
    
    NSString *_name;
    NSInteger _age;
    Student *_student;
}

- (id)initWithName:(NSString *)name
               age:(NSInteger)age
           student:(Student *)student;

@end
