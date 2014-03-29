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

// menu
#ifndef LighterReader_DDMenuView_m
#define LighterReader_DDMenuView_m

#define kMenuViewTag 99
#define kMenuButtonTag 100

#endif

// sign
#ifndef LighterReader_DDSignViewController_m
#define LighterReader_DDSignViewController_m

#define kSignupURL @"http://192.243.119.92/lighterReader/signup.php"

#endif
