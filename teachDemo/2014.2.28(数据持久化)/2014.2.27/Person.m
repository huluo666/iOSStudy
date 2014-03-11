//
//  Person.m
//  2014.2.27
//
//  Created by 张鹏 on 14-2-28.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        // KVC - Key Value Coding（键值编码）
        [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [self setValue:obj forKey:key];
        }];
    }
    return self;
}

- (void)dealloc {
    
    [_name      release];
    [_age       release];
    [_sex       release];
    [_birthday  release];
    [_telephone release];
    [_address   release];
    
    [super dealloc];
}

#pragma mark - <NSCoding>

// 对象编码为NSData
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
//    NSArray *propertyList = @[@"name", @"age", @"sex", @"birthday", @"telephone", @"address"];
//    [propertyList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        [[self valueForKey:obj] encodeWithCoder:aCoder];
//    }];
    
    // 编码每个属性
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_age forKey:@"age"];
    [aCoder encodeObject:_sex forKey:@"sex"];
    [aCoder encodeObject:_birthday forKey:@"birthday"];
    [aCoder encodeObject:_telephone forKey:@"telephone"];
    [aCoder encodeObject:_address forKey:@"address"];
}

// NSData转化为对象
- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    if (self) {
        _name = [[aDecoder decodeObjectForKey:@"name"] copy];
        _age = [[aDecoder decodeObjectForKey:@"age"] copy];
        _sex = [[aDecoder decodeObjectForKey:@"sex"] copy];
        _birthday = [[aDecoder decodeObjectForKey:@"birthday"] copy];
        _telephone = [[aDecoder decodeObjectForKey:@"telephone"] copy];
        _address = [[aDecoder decodeObjectForKey:@"address"] copy];
    }
    return self;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"\ncontact information:\nname:%@\nage:%@\nsex:%@\nbirthday:%@\ntelephone:%@\naddress:%@", self.name, self.age, self.sex, self.birthday, self.telephone, self.address];
}

@end


















