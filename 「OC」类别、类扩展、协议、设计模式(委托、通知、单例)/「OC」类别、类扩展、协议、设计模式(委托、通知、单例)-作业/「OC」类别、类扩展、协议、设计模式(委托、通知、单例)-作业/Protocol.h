//
//  StudentProtocol.h
//  「OC」类别、类扩展、协议、设计模式(委托、通知、单例)-作业
//
//  Created by cuan on 14-1-17.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Protocol <NSObject>

@required
@property (copy, nonatomic) NSString *name;

- (NSComparisonResult)compare:(id <Protocol>)object;

@optional
@property (copy, nonatomic) NSString *code;

@end
