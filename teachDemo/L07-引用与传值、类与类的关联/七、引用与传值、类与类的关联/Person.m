
//
//  Person.m
//  七、引用与传值、类与类的关联
//
//  Created by 张鹏 on 13-11-4.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import "Person.h"

@interface Person ()

- (void)processBirthday;

@end

@implementation Person

- (id)initWithName:(NSString *)name age:(NSInteger)age identity:(NSString *)identity {
    
    self = [super init];
    if (self) {
        
        _name     = [name copy];
        _age      = age;
        _identity = [identity copy];
        [self processBirthday];
        
    }
    return self;
}

- (void)dealloc {
    
    [_name     release];
    [_identity release];
    [_birthday release];
    
    [super dealloc];
}

- (NSDictionary *)dictionary {
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:4];
    [dictionary setObject:_name     ? _name     : @"" forKey:@"name"];
    [dictionary setObject:@(_age)   ? @(_age)   : @"" forKey:@"age"];
    [dictionary setObject:_identity ? _identity : @"" forKey:@"identity"];
    [dictionary setObject:_birthday ? _birthday : @"" forKey:@"birthday"];
    
    return dictionary;
}

- (void)processBirthday {
    
    if (!_identity || _identity.length != 18) {
        NSLog(@"student '%@' process birthday failed for bad identity '%@'.", _name, _identity);
        return;
    }
    
    NSString *year  = [_identity substringWithRange:NSMakeRange(6, 4)];
    NSString *month = [_identity substringWithRange:NSMakeRange(10, 2)];
    NSString *day   = [_identity substringWithRange:NSMakeRange(12, 2)];
    
    _birthday = [[NSString stringWithFormat:@"%@-%@-%@", year, month, day] copy];
}

- (void)saveInformationForKey:(NSString *)key {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *informationList = [NSMutableArray arrayWithArray:[userDefaults objectForKey:key]];
    [informationList addObject:[self dictionary]];
    [userDefaults setObject:informationList forKey:key];
    [userDefaults synchronize];
}

+ (NSArray *)loadInformationsForKey:(NSString *)key {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end








