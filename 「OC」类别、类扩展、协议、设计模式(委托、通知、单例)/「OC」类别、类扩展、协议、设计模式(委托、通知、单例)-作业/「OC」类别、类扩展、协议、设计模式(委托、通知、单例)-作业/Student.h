//
//  Student.h
//  「OC」类别、类扩展、协议、设计模式(委托、通知、单例)-作业
//
//  Created by cuan on 14-1-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Protocol.h"

@interface Student : NSObject <Protocol>
{
    NSString *_name;
    NSString *_code;
}

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *code;
@property (retain, nonatomic) NSMutableArray *scores;

- (id)initWithName:(NSString *)name code:(NSString *)code;
- (id)initWithName:(NSString *)name code:(NSString *)code scores:(NSMutableArray *)scores;
- (double)calculateAvg;

+ (instancetype)sharedStudent;

@end


@interface Student ()

- (NSInteger)comareRetainCount:(Student *)student;

@end




