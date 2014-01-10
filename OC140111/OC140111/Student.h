//
//  Student.h
//  OC140111
//
//  Created by cuan on 14-1-10.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "Person.h"

@interface Student : Person
{
    NSString *_telephone;
    NSString *_code;
}

- (NSString *) telephone;
- (void) Settelephone:(NSString *)telephone;

- (id) init;
- (id) initWithName:(NSString *)name
                age:(NSInteger)age
          telephone:(NSString *)telephone
               code:(NSString *)code;
- (void) print;
+ (Student *) student;
+ (Student *) studentWithName:(NSString *)name
                          age:(NSInteger)age
                    telephone:(NSString *)telephone
                         code:(NSString *)code;

@end
