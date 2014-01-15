//
//  Student.m
//  2014.1.15
//
//  Created by 张鹏 on 14-1-15.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Student.h"

@implementation Student

//@synthesize name = _name;

- (id)initWithName:(NSString *)name
               age:(NSInteger)age
              code:(NSString *)code {
    
    self = [super init];
    if (self) {
        
        self.name = name;
        _age = age;
        _code = [code retain];
        
    }
    return self;
}

- (void)dealloc {
    
    [_name release];
    [_code release];
    
    [super dealloc];
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"student name = %@ age = %ld", _name, _age];
}

- (NSInteger)agesBetweenStudent:(Student *)student {
    
    return _age - student.age;
}

- (void)setName:(NSString *)name {
    
    if (_name != name) {
        [_name release];
        _name = [[name uppercaseString] retain];
    }
}

@end








