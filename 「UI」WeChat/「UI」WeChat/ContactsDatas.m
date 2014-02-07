//
//  PersonInformationsDatas.m
//  「UI」WeChat
//
//  Created by cuan on 14-2-3.
//  Copyright (c) 2014年 cuan. All rights reserved.
//

#import "ContactsDatas.h"
#import "PersonInformations.h"

@implementation ContactsDatas

+ (NSMutableArray *)datas
{
    NSMutableArray *datasArray = [NSMutableArray array];
    
    // 随机产生数据
    NSArray *names = @[@"Jack", @"Mike", @"Lucy", @"Lily", @"Matt", @"Micheal", @"kalus", @"Bob", @"Anni", @"andy", @"Damon", @"Edison", @"Eric", @"Frank", @"France", @"German", @"Hoke", @"Holo", @"Ian", @"James", @"Nina", @"Peny", @"Queue", @"Rich", @"Sarla", @"Tina", @"Viki", @"Will"];
    
    NSArray *regions = @[@"四川 成都", @"四川 达州", @"四川 自贡", @"四川 绵阳", @"四川 德阳", @"四川 内江", @"四川 乐山", @"四川 宜宾", @"广东 深圳", @"广东 广州", @"广东 东莞", @"广东 惠州", @"湖北 武汉", @"湖南 长沙"];
    
    NSArray *avatars = @[[UIImage imageNamed:@"avatar1"], [UIImage imageNamed:@"avatar2"], [UIImage imageNamed:@"avatar3"], [UIImage imageNamed:@"avatar4"]];
    
    NSArray *photos = @[[UIImage imageNamed:@"iphoto1@2x"], [UIImage imageNamed:@"iphoto2@2x"], [UIImage imageNamed:@"iphpto3@2x"]];
    
    NSMutableArray *letter = [[NSMutableArray alloc] init];
    for (int i = 'A'; i < 'Z'; i++)
    {
        [letter addObject:[NSString stringWithFormat:@"%c", i]];
    }

    NSString *signature = nil;
    for (int i = 0; i < 100; i++)
    {
        // 性别
        Sex sex;
        if (0 == i%2)
        {
            sex = male;
            signature = [NSString stringWithFormat:@"Everythings that kills me makes me feel alive %d", i];
        }
        else
        {
            if (i%35)
            {
                sex = none;
            }
            else
            {
                sex = famale;
            }
            signature = [NSString stringWithFormat:@"没有个性签名--没有个性签名--%d", i];
            
        }
        if (0 == i%5)
        {
            signature = nil;
        }

        
        // 昵称
        NSString *nickName = [NSString stringWithFormat:@"%@ %d", names[arc4random()%names.count], i];
        if (!(i%27))
        {
            nickName = [NSString stringWithFormat:@"<%@", nickName];
        }
        if (!(i%42))
        {
            nickName = [NSString stringWithFormat:@"@%@", nickName];
        }
        if (!(i%71))
        {
            nickName = [NSString stringWithFormat:@"^&%@", nickName];
        }
        
        // 备注名
        NSString *remarkName = nil;
        if (i%2)
        {
            remarkName = [NSString stringWithFormat:@"%@-%@-备注",letter[arc4random()%letter.count], nickName];
        }
        
        // 头像
        UIImage *avatar = nil;
        if (i%3)
        {
            avatar = avatars[arc4random()%avatars.count];
        }

        // 账号
        NSString *account = [NSString stringWithFormat:@"%d", i];
        
        // 地区
        NSString *region = regions[arc4random()%regions.count];
        
        // 个人相册
        NSMutableArray *iphots = [[NSMutableArray alloc] init];
        if (0 == i%4)
        {
            [iphots addObject:photos[0]];
        }
        else if (1 == i%4)
        {
            [iphots addObject:photos[0]];
            [iphots addObject:photos[1]];
        }
        else if (2 == i%4)
        {
            [iphots addObject:photos[0]];
            [iphots addObject:photos[1]];
            [iphots addObject:photos[2]];
        }
        else
        {
            iphots = nil;
        }
        
        PersonInformations *pInfos = [PersonInformations personInfomationsWithNickName:nickName remarkName:remarkName sex:sex account:account avatar:avatar region:region signature:signature photos:iphots];
        
        if (!(i%19))
        {
            pInfos.start = YES;
        }
      
        [datasArray addObject:pInfos];
        [iphots release];
    }
    [letter release];
    
    // 模拟特殊账户(新的朋友，群聊，服务号，订阅号)
    PersonInformations *newFriends = [PersonInformations personInfomationsWithNickName:@"↑新的朋友" remarkName:nil sex:none account:@"777" avatar:[UIImage imageNamed:@"default_fmessage"] region:nil signature:nil photos:nil];
    [datasArray addObject:newFriends];
    
    PersonInformations *chats = [PersonInformations personInfomationsWithNickName:@"↑群聊" remarkName:nil sex:none account:@"999" avatar:[UIImage imageNamed:@"default_chatroom"] region:nil signature:nil photos:nil];
    [datasArray addObject:chats];
    
    PersonInformations *service = [PersonInformations personInfomationsWithNickName:@"↑服务号" remarkName:nil sex:none account:@"888" avatar:[UIImage imageNamed:@"default_servicebrand_contact"] region:nil signature:nil photos:nil];
    [datasArray addObject:service];
    
    PersonInformations *feed = [PersonInformations personInfomationsWithNickName:@"↑订阅号" remarkName:nil sex:none account:@"666" avatar:[UIImage imageNamed:@"default_brand_contact"]region:nil signature:nil photos:nil];
    [datasArray addObject:feed];
    
    
    return datasArray;
}

@end
