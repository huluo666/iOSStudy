//
//  Student.h
//  demotext
//
//  Created by 张鹏 on 14-1-10.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Person.h"

@interface Student : Person {
    
    NSString *_telephone;
    NSString *_code;
}

- (id)init;
- (id)initWithName:(NSString *)name
               age:(NSInteger)age
         telephone:(NSString *)telephone
              code:(NSString *)code;
+ (Student *)studentWithName:(NSString *)name
                         age:(NSInteger)age
                   telephone:(NSString *)telephone
                        code:(NSString *)code;

- (void)setTelephone:(NSString *)telephone;
- (NSString *)telephone;

- (void)setCode:(NSString *)code;
- (NSString *)code;

+ (Student *)elderStudent:(Student *)student
           anotherStudent:(Student *)anotherStudent;

- (Student *)elderStudent:(Student *)student;



- (void)print;













@end
