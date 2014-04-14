//
//  DDFeeds.m
//  LighterReader
//
//  Created by 萧川 on 14-4-14.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDFeeds.h"

@implementation DDFeeds

+ (id)feeds {
    
    DDFeeds *feeds = [[self alloc] init];
    NSInteger random = arc4random() % 5;
    switch (random) {
        case 0:
        {
            feeds.title = @"Copyright (C) 1989, 1991 Free Software Foundation, Inc.";
            feeds.content = @"The licenses for most software are designed to take away your "
            " freedom to share and change it.  By contrast, the GNU General Public"
            "License is intended to guarantee your freedom to share and change free"
            "software--to make sure the software is free for all its users.  This"
            "General Public License applies to most of the Free Software"
            "Foundation's software and to any other program whose authors commit to"
            "using it.  (Some other Free Software Foundation software is covered by"
            "the GNU Lesser General Public License instead.)  You can apply it to"
            "your programs, too."
            "he licenses for most software are designed to take away your "
            " freedom to share and change it.  By contrast, the GNU General Public"
            "License is intended to guarantee your freedom to share and change free"
            "software--to make sure the software is free for all its users.  This"
            "General Public License applies to most of the Free Software"
            "Foundation's software and to any other program whose authors commit to"
            "using it.  (Some other Free Software Foundation software is covered by"
            "the GNU Lesser General Public License instead.)  You can apply it to"
            "your programs, too."
            "The licenses for most software are designed to take away your "
            " freedom to share and change it.  By contrast, the GNU General Public"
            "License is intended to guarantee your freedom to share and change free"
            "software--to make sure the software is free for all its users.  This"
            "General Public License applies to most of the Free Software"
            "Foundation's software and to any other program whose authors commit to"
            "using it.  (Some other Free Software Foundation software is covered by"
            "the GNU Lesser General Public License instead.)  You can apply it to"
            "your programs, too."
            "he licenses for most software are designed to take away your "
            " freedom to share and change it.  By contrast, the GNU General Public"
            "License is intended to guarantee your freedom to share and change free"
            "software--to make sure the software is free for all its users.  This"
            "General Public License applies to most of the Free Software"
            "Foundation's software and to any other program whose authors commit to"
            "using it.  (Some other Free Software Foundation software is covered by"
            "the GNU Lesser General Public License instead.)  You can apply it to"
            "your programs, too";
            feeds.hint = @"300k sina / 3d";
            feeds.review = @"51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA"
            "Everyone is permitted to copy and distribute verbatim copies"
            "of this license document, but changing it is not allowed.";

        }
            break;
        case 1:
        {
            feeds.title = @" You must cause the modified files to carry prominent notices"
            "stating that you changed the files and the date of any change";
            feeds.content = @"When we speak of free software, we are referring to freedom, not"
            "price.  Our General Public Licenses are designed to make sure that you"
            "have the freedom to distribute copies of free software (and charge for"
            "this service if you wish), that you receive source code or can get it"
            "if you want it, that you can change the software or use pieces of it"
            "in new free programs; and that you know you can do these things."
            "When we speak of free software, we are referring to freedom, not"
            "price.  Our General Public Licenses are designed to make sure that you"
            "have the freedom to distribute copies of free software (and charge for"
            "this service if you wish), that you receive source code or can get it"
            "if you want it, that you can change the software or use pieces of it"
            "in new free programs; and that you know you can do these things."
            "When we speak of free software, we are referring to freedom, not"
            "price.  Our General Public Licenses are designed to make sure that you"
            "have the freedom to distribute copies of free software (and charge for"
            "this service if you wish), that you receive source code or can get it"
            "if you want it, that you can change the software or use pieces of it"
            "in new free programs; and that you know you can do these things."
            "When we speak of free software, we are referring to freedom, not"
            "price.  Our General Public Licenses are designed to make sure that you"
            "have the freedom to distribute copies of free software (and charge for"
            "this service if you wish), that you receive source code or can get it"
            "if you want it, that you can change the software or use pieces of it"
            "in new free programs; and that you know you can do these things";
            feeds.hint = @"50k baidu / 7h";
            feeds.hint = @"50k baidu / 7h";
            feeds.review = @"This program is free software; you can redistribute it and/or modify"
            "it under the terms of the GNU General Public License as published by"
            "the Free Software Foundation;";
            
        }
            break;
        case 2:
        {
            feeds.title = @"Accompany it with the complete corresponding machine-readable"
            "source code, which must be distributed under the terms of Sections"
            "1 and 2 above on a medium customarily used for software interchange";
            feeds.content = @"To protect your rights, we need to make restrictions that forbid"
            "anyone to deny you these rights or to ask you to surrender the rights."
            "These restrictions translate to certain responsibilities for you if you"
            "distribute copies of the software, or if you modify it."
            "When we speak of free software, we are referring to freedom, not"
            "price.  Our General Public Licenses are designed to make sure that you"
            "have the freedom to distribute copies of free software (and charge for"
            "this service if you wish), that you receive source code or can get it"
            "if you want it, that you can change the software or use pieces of it"
            "in new free programs; and that you know you can do these things."
            "When we speak of free software, we are referring to freedom, not"
            "price.  Our General Public Licenses are designed to make sure that you"
            "have the freedom to distribute copies of free software (and charge for"
            "this service if you wish), that you receive source code or can get it"
            "if you want it, that you can change the software or use pieces of it"
            "in new free programs; and that you know you can do these things";
            feeds.hint = @"900k yahoo / 1d";
            feeds.review = @"You should have received a copy of the GNU General Public License along"
            "with this program";
        }
            break;
        case 3:
        {
            feeds.title = @"This section is intended to make thoroughly clear what is believed to"
            "be a consequence of the rest of this License";
            feeds.content = @" For example, if you distribute copies of such a program, whether"
            "gratis or for a fee, you must give the recipients all the rights that"
            "you have.  You must make sure that they, too, receive or can get the"
            "source code.  And you must show them these terms so they know their"
            "rights"
            "For example, if you distribute copies of such a program, whether"
            "gratis or for a fee, you must give the recipients all the rights that"
            "you have.  You must make sure that they, too, receive or can get the"
            "source code.  And you must show them these terms so they know their"
            "rights";
            feeds.hint = @"59k google / 7d";
            feeds.review = @"Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.";
        }
            break;
        case 4:
        {
            feeds.title = @"This program is distributed in the hope that it will be useful,"
            "but WITHOUT ANY WARRANTY";
            feeds.content = @" These requirements apply to the modified work as a whole.  If"
            "identifiable sections of that work are not derived from the Program,"
            "and can be reasonably considered independent and separate works in"
            "themselves, then this License, and its terms, do not apply to those"
            "sections when you distribute them as separate works.  But when you"
            "distribute the same sections as part of a whole which is a work based"
            "on the Program, the distribution of the whole must be on the terms of"
            "this License, whose permissions for other licensees extend to the"
            "entire whole, and thus to each and every part regardless of who wrote it."
            "These requirements apply to the modified work as a whole.  If"
            "identifiable sections of that work are not derived from the Program,"
            "and can be reasonably considered independent and separate works in"
            "themselves, then this License, and its terms, do not apply to those"
            "sections when you distribute them as separate works.  But when you"
            "distribute the same sections as part of a whole which is a work based"
            "on the Program, the distribution of the whole must be on the terms of"
            "this License, whose permissions for other licensees extend to the"
            "entire whole, and thus to each and every part regardless of who wrote it.";
            feeds.hint = @"1m Apple / 29d";
            feeds.review = @"If your program is a subroutine library, you may"
            "consider it more useful to permit linking proprietary applications with the"
            "library. ";
        }
            break;
        default:
            break;
    }
    return feeds;
}

+ (NSArray *)feedsWithCapacity:(NSInteger)capacity {
    
    NSMutableArray *feeds = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < capacity; i++) {
        [feeds addObject:[self feeds]];
    }
    
    return feeds;
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"title = %@\n review = %@\n hint = %@\n, content=  %@",
            _title, _review, _hint, _content];
}

@end
