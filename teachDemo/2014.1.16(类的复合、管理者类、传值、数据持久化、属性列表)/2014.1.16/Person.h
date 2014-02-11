//
//  Person.h
//  2014.1.16
//
//  Created by 张鹏 on 14-1-16.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject {
    
    NSString *_name;
    NSInteger _age;
    NSDictionary *_infoDict;
}

// 声明了成员变量
// 合成setter和getter
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;
@property (retain, nonatomic) NSDictionary *infoDict;

- (id)initWithName:(NSString *)name
               age:(NSInteger)age
              info:(NSDictionary *)infoDict;
+ (Person *)personWithName:(NSString *)name
                       age:(NSInteger)age
                      info:(NSDictionary *)infoDict;

@end












