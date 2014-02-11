//
//  PersonProtocol.h
//  2014.1.18
//
//  Created by 张鹏 on 14-1-18.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PersonProtocol <NSObject>

@property (copy ,nonatomic) NSString *age;
@property (copy ,nonatomic) NSString *code;

- (void)uppercaseName;

@end
















