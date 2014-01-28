//
//  Student.m
//  OC140111
//
//  Created by cuan on 14-1-10.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Student.h"

@implementation Student:Person

- (NSString *) telephone
{
    return _telephone;
}

- (void) Settelephone:(NSString *)telephone;
{
    _telephone = telephone;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        ;
    }
    return self;
}

- (id) initWithName:(NSString *)name
                age:(NSInteger)age
          telephone:(NSString *)telephone
               code:(NSString *)code
{
    self = [super initWithName:name age:age];
    if (self)
    {
        _telephone  = telephone;
        _code       = code;
    }
    
    return self;
}

- (void) print
{
    NSLog(@"%@, name:%@, age:%ld, tele:%@, code:%@", self, _name, _age, _telephone, _code);
}

+ (Student *) student
{
    return [self alloc];
}

+ (Student *) studentWithName:(NSString *)name
                          age:(NSInteger)age
                    telephone:(NSString *)telephone
                         code:(NSString *)code;
{
    return [[self alloc] initWithName:name age:age telephone:telephone code:code];
}

@end

