//
//  DDGameResultScene.m
//  「UI」精灵(day18)
//
//  Created by 萧川 on 14-3-3.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDGameResultScene.h"
#import "DDMyScene.h"

@interface DDGameResultScene ()

- (void)translateToGameScene;

@end

@implementation DDGameResultScene

- (instancetype)initWithSize:(CGSize)size result:(BOOL)success
{
    if (self = [super initWithSize:size]) {
        [self initializeUserInterfaceWithResult:success];
    }
    return self;
}

- (void)translateToGameScene
{
    NSLog(@"----");
    // 初始化游戏场景并展现
    DDMyScene *myScene = [[DDMyScene alloc] initWithSize:self.size];
    SKTransition *transition = [SKTransition revealWithDirection:SKTransitionDirectionDown
                                                        duration:0.5f];
    [self.view presentScene:myScene transition:transition];
}

- (void)initializeUserInterfaceWithResult:(BOOL)success
{
    self.backgroundColor = [SKColor orangeColor];
    
    // 初始化结果显示标签
    SKLabelNode *resultLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    resultLabel.text = success ? @"You win" : @"You loser";
    resultLabel.fontSize = 30;
    resultLabel.fontColor = [SKColor blackColor];
    resultLabel.position = CGPointMake(self.size.width / 2, self.size.height / 2);
    NSLog(@"%@",NSStringFromCGPoint(resultLabel.position));
    NSLog(@"%f", self.size.height);
    [self addChild:resultLabel];
    
    // 重新开始
    SKLabelNode *restart = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    restart.text = @"Try again";
    restart.fontSize = 20;
    restart.fontColor = [SKColor grayColor];
    restart.name = @"Restart";
    restart.position = CGPointMake(self.size.width / 2, self.size.height / 2 - 50);
    [self addChild:restart];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [[touches anyObject] locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    if ([node.name isEqualToString:@"Restart"]) {
        [self translateToGameScene];
    }
}

@end
