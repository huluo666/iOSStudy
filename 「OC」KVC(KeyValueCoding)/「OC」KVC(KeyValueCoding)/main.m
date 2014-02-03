//
//  main.m
//  「OC」KVC(KeyValueCoding)
//
//  Created by cuan on 14-1-27.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayList.h"
#import "PlayItem.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        
        // 两个类：PlayList、 PlayItem
    
        // 测试KVC
        PlayList *list = [[PlayList alloc] init];
        [list setValue:@"播放列表" forKey:@"name"];
        NSLog(@"name is %@", list.name);
    
        id value = [list valueForKey:@"number"];
        NSLog(@"value is %@", value);
        
        // 设置currentItem.name字段
        [list setValue:@"当前播放列表" forKeyPath:@"currentItem.name"];
        NSLog(@"list.currentItem.nameis %@", [list valueForKeyPath:@"currentItem.name"]);
        
        // 设置一批 key value
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@22, @"number",
                              @"list", @"name" ,nil];
        [list setValuesForKeysWithDictionary:dict];
        NSLog(@"number is %@, name is %@", list.number, list.name);
        
        [list setValue:@"helloe" forKey:@"test"]; // 因为list对象里面没有test这个key,所以崩
        
        id obj = [list valueForKey:@"itemList"];
        NSLog(@"obj is %@", obj);
        
        id objName = [list valueForKeyPath:@"itemList.name"];
        NSLog(@"objName is %@", objName);
        
        NSLog(@"itemList price sum is %@", [list.itemList valueForKeyPath:@"@sum.price"]);
        NSLog(@"itemList price avg is %@", [list.itemList valueForKeyPath:@"@avg.price"]);
        NSLog(@"itemList price max is %@", [list.itemList valueForKeyPath:@"@max.price"]);
        NSLog(@"itemList price min is %@", [list.itemList valueForKeyPath:@"@min.price"]);
        [list release];
    }
    return 0;
}

