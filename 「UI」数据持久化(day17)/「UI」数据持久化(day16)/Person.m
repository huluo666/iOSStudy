//
//  Person.m
//  「UI」数据持久化(day16)
//
//  Created by 萧川 on 14-2-28.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "Person.h"

@implementation Person



- (void)dealloc
{
    [_name release];
    [_age release];
    [_birthday release];
    [_telephone release];
    [_address release];
    [super dealloc];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            // KVC
            [self setValue:obj forKey:key];
        }];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    NSArray *propertyList = @[@"name", @"age", @"sex", @"birthday", @"telephone", @"address"];
    [propertyList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [aCoder encodeObject:[self valueForKey:obj] forKey:obj];
    }];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _name = [[aDecoder decodeObjectForKey:@"name"] copy];
        _age = [[aDecoder decodeObjectForKey:@"age"] copy];
        _sex = [[aDecoder decodeObjectForKey:@"sex"] copy];
        _birthday = [[aDecoder decodeObjectForKey:@"birthday"] copy];
        _telephone = [[aDecoder decodeObjectForKey:@"telephone"] copy];
        _address = [[aDecoder decodeObjectForKey:@"address"] copy];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"contact information : \nname:%@\nage:%@\nsex:%@\nbirthday:%@\ntelephone:%@\naddress:%@", self.name, self.age, self.sex, self.birthday, self.telephone, self.address];
}

@end
