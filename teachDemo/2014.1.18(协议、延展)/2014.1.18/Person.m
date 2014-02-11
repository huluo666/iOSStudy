//
//  Person.m
//  2014.1.18
//
//  Created by 张鹏 on 14-1-18.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)initWithName:(NSString *)name
               age:(NSString *)age
              code:(NSString *)code {
    
    self = [super init];
    if (self) {
        
        _name = [name copy];
        _age  = [age copy];
        _code = [code copy];
        
    }
    return self;
}

- (void)dealloc {
    
    [_name release];
    [_age  release];
    [_code release];
    
    [super dealloc];
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"person name:%@ age:%@ code:%@",
            _name, _age, _code];
}

- (void)uppercaseName {
    
    if (_name && [_name length] > 0) {
        self.name = [_name uppercaseString];
    }
}

@end












