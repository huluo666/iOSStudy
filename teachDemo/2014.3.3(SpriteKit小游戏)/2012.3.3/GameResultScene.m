//
//  GameResultScene.m
//  2012.3.3
//
//  Created by 张鹏 on 14-3-3.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "GameResultScene.h"
#import "MyScene.h"

@interface GameResultScene ()

- (void)initializeUserInterfaceWithResult:(BOOL)result;
- (void)translateToGameScene;

@end

@implementation GameResultScene

- (id)initWithSize:(CGSize)size result:(BOOL)result {
    
    self = [super initWithSize:size];
    if (self) {
        [self initializeUserInterfaceWithResult:result];
    }
    return self;
}

- (void)initializeUserInterfaceWithResult:(BOOL)result {
    
    self.backgroundColor = [SKColor whiteColor];
    
    // 初始化结果显示标签
    SKLabelNode *resultLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    resultLabel.text = result ? @"You Win" : @"You Lose";
    resultLabel.fontSize = 30;
    resultLabel.fontColor = [SKColor blackColor];
    resultLabel.position = CGPointMake(self.size.width / 2, self.size.height / 2);
    [self addChild:resultLabel];
    NSLog(@"%@",NSStringFromCGPoint(resultLabel.position));
    // 重新开始
    SKLabelNode *retryLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    retryLabel.text = @"Try Again";
    retryLabel.fontSize = 20;
    retryLabel.fontColor = [SKColor grayColor];
    retryLabel.name = @"RetryLabel";
    retryLabel.position = CGPointMake(self.size.width / 2, self.size.height / 2 - 50);
    [self addChild:retryLabel];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 判断重新开始点击
    CGPoint location = [[touches anyObject] locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    if ([node.name isEqualToString:@"RetryLabel"]) {
        // 开始新游戏
        [self translateToGameScene];
    }
}

- (void)translateToGameScene {
    
    // 初始化游戏场景并展现
    MyScene *gameScene = [[MyScene alloc] initWithSize:self.size];
    SKTransition *transition = [SKTransition revealWithDirection:SKTransitionDirectionDown
                                                        duration:0.5];
    [self.view presentScene:gameScene transition:transition];
}

@end



















