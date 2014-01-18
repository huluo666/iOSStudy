//
//  Student.h
//  2014.1.18plus
//
//  Created by 张鹏 on 14-1-18.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompareProtocol.h"

@interface Student : NSObject <CompareProtocol> {
    
    NSString *_name;
    NSInteger _age;
}

- (id)initWithName:(NSString *)name age:(NSInteger)age;

@end
