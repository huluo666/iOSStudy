//
//  Person+Compare.h
//  2014.1.17plus
//
//  Created by 张鹏 on 14-1-17.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Person.h"

@interface Person (Compare)

@property (copy, nonatomic) NSString *identity;

- (Person *)elderPerson:(Person *)person;
- (void)print;

@end











