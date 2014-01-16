//
//  Person.m
//  2014.1.16
//
//  Created by 张鹏 on 14-1-16.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)initWithName:(NSString *)name
               age:(NSInteger)age
              info:(NSDictionary *)infoDict {
    
    self = [super init];
    if (self) {
        
        _name = [name copy];
        _age = age;
        _infoDict = [infoDict retain];
        
    }
    return self;
}

+ (Person *)personWithName:(NSString *)name
                       age:(NSInteger)age
                      info:(NSDictionary *)infoDict {
    
    Person *person = [[self alloc] initWithName:name
                                            age:age
                                           info:infoDict];
    return [person autorelease];
}

- (void)dealloc {
    
    [_name     release];
    [_infoDict release];
    
    [super dealloc];
}

@end
