//
//  Student.h
//  2014.1.17
//
//  Created by 张鹏 on 14-1-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject {
    
    NSString *_name;
    NSInteger _age;
    double _score;
}

@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;
@property (assign, nonatomic) double score;

- (id)initWithName:(NSString *)name
               age:(NSInteger)age
             score:(double)score;

- (NSComparisonResult)compareScore:(Student *)student;

@end
















