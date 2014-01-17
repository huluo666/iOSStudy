//
//  GoodStudent.h
//  八、类别、类扩展、协议、单例、封装、继承
//
//  Created by 张鹏 on 13-11-6.
//  Copyright (c) 2013年 张鹏. All rights reserved.
//

#import "Student.h"

@interface GoodStudent : Student {
    
    NSString *_type;
}

@property (copy, nonatomic) NSString *type;

@end
