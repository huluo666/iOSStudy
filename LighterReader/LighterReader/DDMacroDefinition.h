//
//  DDMacroDefinition.h
//  LighterReader
//
//  Created by 萧川 on 14-3-27.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#ifndef LighterReader_DDMacroDefinition_h
#define LighterReader_DDMacroDefinition_h

#define DDImageWithName(NAME) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:NAME ofType:@"png"]]
#define DDBounds [[UIScreen mainScreen] bounds]

#endif

//A better version of NSLog
#define NSLog(format, ...) do {                                             \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)

// menu
#ifndef LighterReader_DDMenuView_m
#define LighterReader_DDMenuView_m

#define kNaviMenuViewTag 98
#define kSignMenuViewTag 99
#define kMenuButtonTag 100

#endif

// sign
#ifndef LighterReader_DDSignViewController_m
#define LighterReader_DDSignViewController_m

#define kSignupURL @"http://192.243.119.92/lighterReader/signup.php"
#define kSigninURL @"http://192.243.119.92/lighterReader/signin.php"

#endif
