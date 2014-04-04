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
#define kUserDefaults [NSUserDefaults standardUserDefaults]
#define kRandomColor [UIColor colorWithRed:arc4random() % 128 / 255.0f green:arc4random() % 64 / 255.0f blue:arc4random() % 255 / 255.0f alpha:1.000]

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
#define kSearchMenuViewTag 97

#endif

// sign
#ifndef LighterReader_DDSignViewController_m
#define LighterReader_DDSignViewController_m

#define kSignupURL @"http://192.243.119.92/lighterReader/signup.php"
#define kSigninURL @"http://192.243.119.92/lighterReader/signin.php"

#endif

// mainUI
#ifndef LighterReader_DDMainUIViewController_m
#define LighterReader_DDMainUIViewController_m

#define kReloadButtonTag 200

#endif

// mainUINavi
#ifndef LighterReader_DDMainUINaviController_m
#define LighterReader_DDMainUINaviController_m

#define kClearViewTag 210
#define kSettingViewTag 211
#define kFloaterAdjustDislplayButtonTag 250

#endif
