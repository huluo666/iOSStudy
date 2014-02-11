//
//  Student.m
//  demotext
//
//  Created by 张鹏 on 14-1-10.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Student.h"

@implementation Student

- (id)init {
    
    self = [self initWithName:@"tony"
                          age:24
                    telephone:@"135333333"
                         code:@"10"];
    if (self) {
        
    }
    return self;
}

- (id)initWithName:(NSString *)name
               age:(NSInteger)age
         telephone:(NSString *)telephone
              code:(NSString *)code {
    
    self = [super initWithName:name age:age];
    if (self) {
        
        _telephone = telephone;
        _code = code;
        
    }
    return self;
}

+ (Student *)studentWithName:(NSString *)name
                         age:(NSInteger)age
                   telephone:(NSString *)telephone
                        code:(NSString *)code {
    
    Student *student = [[self alloc] initWithName:name
                                              age:age
                                        telephone:telephone
                                             code:code];
    return student;
}

- (void)print {
    
    NSLog(@"%@ name:%@ age:%ld telephone:%@ code:%@.", self, _name, _age, _telephone, _code);
}

- (void)setTelephone:(NSString *)telephone {
    
    _telephone = telephone;
}

- (NSString *)telephone {
    
    return _telephone;
}

- (void)setCode:(NSString *)code {
    
    _code = code;
}

- (NSString *)code {
    
    return _code;
}

+ (Student *)elderStudent:(Student *)student
           anotherStudent:(Student *)anotherStudent {
    
    return [student age] > [anotherStudent age] ? student : anotherStudent;
}

- (Student *)elderStudent:(Student *)student {
    
    return _age > [student age] ? self : student;
}
















@end
