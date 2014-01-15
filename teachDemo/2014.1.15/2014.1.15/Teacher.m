//
//  Teacher.m
//  2014.1.15
//
//  Created by 张鹏 on 14-1-15.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher

- (id)initWithStudent:(Student *)student {
    
    self = [super init];
    if (self) {

        
    }
    return self;
}

- (void)dealloc {
    
    [_student release];
    
    [super dealloc];
}

@end
