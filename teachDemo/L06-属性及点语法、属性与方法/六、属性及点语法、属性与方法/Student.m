//
//  Student.m
//  四、属性及点语法、属性与方法
//
//  Created by 张鹏 on 13-11-2.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import "Student.h"

@implementation Student

- (id)initWithName:(NSString *)name
               age:(NSInteger)age
          identity:(NSString *)identity
          location:(NSPoint)location {
    
    self = [super init];
    if (self) {
        
        _name     = [name copy];
        _age      = age;
        _type     = [@"Student" copy];
        _location = location;
        
        self.identity = identity;
    }
    return self;
}

- (void)dealloc {
    
    [_name     release];
    [_identity release];
    [_birthday release];
    [_type     release];
    
    [super dealloc];
}

- (void)setIdentity:(NSString *)identity {
    
    // 判断身份证号是否有效
    if (!identity && identity.length != 18) {
        NSLog(@"bad identity code!");
        return;
    }
    
    if (_identity != identity) {
        [_identity release];
        _identity = [identity copy];

        // 清理当前生日
        if (_birthday) {
            [_birthday release];
            _birthday = nil;
        }
        // 获取对应当前身份证号码的生日
        _birthday = [[self dateWithIdentity:_identity] retain];
    }
}

- (NSDictionary *)birthdayWihIdentity:(NSString *)identity {

    NSMutableDictionary *dateInfo = [NSMutableDictionary dictionary];
    NSString *year  = [identity substringWithRange:NSMakeRange(6, 4)];
    NSString *month = [identity substringWithRange:NSMakeRange(10, 2)];
    NSString *day   = [identity substringWithRange:NSMakeRange(12, 2)];
    [dateInfo setObject:year  forKey:@"year"];
    [dateInfo setObject:month forKey:@"month"];
    [dateInfo setObject:day   forKey:@"day"];
    
    return [[dateInfo copy] autorelease];
}

- (NSDate *)dateWithIdentity:(NSString *)identity {
    
    NSDictionary *dateInfo = [self birthdayWihIdentity:identity];
    NSString *year  = [dateInfo objectForKey:@"year"];
    NSString *month = [dateInfo objectForKey:@"month"];
    NSString *day   = [dateInfo objectForKey:@"day"];
    
    // 使用NSCalendar及NSDateComponents获取日期
//    /*
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year  = [year integerValue];
    dateComponents.month = [month integerValue];
    dateComponents.day   = [day integerValue];
    NSDate *date = [calendar dateFromComponents:dateComponents];
    [dateComponents release];
//     */
    
    // 使用NSDateFormatter获取日期
    /*
    NSString *dateString = [NSString stringWithFormat:@"%@-%@-%@", year, month, day];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [formatter dateFromString:dateString];
    [formatter release];
     */
    
    return date;
}

- (float)distanceWithStudent:(Student *)student {
    
    NSPoint location = student.location;
    
    float distanceX = _location.x - location.x;
    float distanceY = _location.y - location.y;
    float distance  = sqrt(pow(distanceX, 2) + pow(distanceY, 2));
    
    return distance;
}

- (NSString *)description {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日";
    NSString *birthdayString = [formatter stringFromDate:_birthday];
    [formatter release];
    
    return [NSString stringWithFormat:
           @"\nstudent:\nname:%@\nage:%ld\nidentity:%@\n"
            "birthday:%@\nlocation:%.1f,%.1f\ntype:%@",
            _name,
            _age,
            _identity,
            birthdayString,
            _location.x,
            _location.y,
            _type];
}

@end






