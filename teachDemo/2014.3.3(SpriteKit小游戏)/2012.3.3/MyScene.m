//
//  MyScene.m
//  2012.3.3
//
//  Created by 张鹏 on 14-3-3.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "MyScene.h"
#import "GameResultScene.h"
#import <AVFoundation/AVFoundation.h>

@interface MyScene () {
    
    SKSpriteNode *_player;
    
    NSMutableArray *_monsters;
    NSMutableArray *_projectiles;
    
    AVAudioPlayer *_backgroundMusicPlayer;
    SKAction *_projectileSoundEffetAction;
    
    NSInteger _monsterKilledNumber;
}

- (void)initializeMedia;
- (void)initializeUserInterfaceWithSize:(CGSize)size;

// 添加怪物
- (void)addMonster;
// 添加飞镖
- (void)addProjectileAtPoint:(CGPoint)point;
// 碰撞检测
- (void)updateColission;

- (void)translateToGameResultSceneWithResult:(BOOL)result;

@end

@implementation MyScene

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        _monsterKilledNumber = 0;
        [self initializeMedia];
        [self initializeUserInterfaceWithSize:size];
    }
    return self;
}

- (void)initializeMedia {
    
    // 背景音乐
    NSURL *url = [[NSBundle mainBundle] URLForAuxiliaryExecutable:@"background-music-aac.caf"];
    NSError *error = nil;
    _backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    NSAssert(!error, @"Initialize background music player failed with error message '%@'.",
             [error localizedDescription]);
    _backgroundMusicPlayer.numberOfLoops = -1;
    [_backgroundMusicPlayer prepareToPlay];
    [_backgroundMusicPlayer play];
    
    // 初始化武器音效播放行为
    _projectileSoundEffetAction = [SKAction playSoundFileNamed:@"pew-pew-lei.caf" waitForCompletion:NO];
}

- (void)initializeUserInterfaceWithSize:(CGSize)size {
    
    self.backgroundColor = [SKColor whiteColor];
    
    // 使用图片初始化玩家精灵，精灵大小为图片大小
    _player = [SKSpriteNode spriteNodeWithImageNamed:@"player.png"];
    // 配置精灵位置
    _player.position = CGPointMake(_player.size.width / 2, size.height / 2);
    // 将精灵添加到场景中
    [self addChild:_player];
    
    // 添加怪物
    SKAction *addMonsterAction = [SKAction runBlock:^{
        [self addMonster];
    }];
    SKAction *waitAction = [SKAction waitForDuration:0.1 withRange:0.05];
    // 将添加怪物和等待行为打包成一个行为
    SKAction *totalAction = [SKAction sequence:@[addMonsterAction, waitAction]];
    // 创建无限行为
    SKAction *foreverAction = [SKAction repeatActionForever:totalAction];
    // 让场景执行行为
    [self runAction:foreverAction];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    // 获取触摸在场景中的坐标
    CGPoint location = [touch locationInNode:self];
    [self addProjectileAtPoint:location];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    // 获取触摸在场景中的坐标
    CGPoint location = [touch locationInNode:self];
    [self addProjectileAtPoint:location];
}

- (void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [self updateColission];
}

- (void)updateColission {
    
    SKSpriteNode *deleteMonster = nil;
    SKSpriteNode *deleteProjectile = nil;
    for (SKSpriteNode *monster in _monsters) {
        for (SKSpriteNode *projetile in _projectiles) {
            // 判定碰撞，矩形相交
            if (CGRectIntersectsRect(monster.frame, projetile.frame)) {
                deleteMonster = monster;
                deleteProjectile = projetile;
            }
        }
    }
    // 若存在，则删除
    if (deleteMonster && deleteProjectile) {
        [deleteMonster removeFromParent];
        [deleteProjectile removeFromParent];
        [_monsters removeObject:deleteMonster];
        [_projectiles removeObject:deleteProjectile];
        // 判断是否胜利
        if (++_monsterKilledNumber >= 100) {
            [self translateToGameResultSceneWithResult:YES];
        }
    }
}

#pragma mark - Sprite add methods

- (void)addMonster {
    
    if (!_monsters) {
        _monsters = [NSMutableArray array];
    }
    
    CGSize size = self.size;
    // 初始化敌人精灵
    SKSpriteNode *monster = [SKSpriteNode spriteNodeWithImageNamed:@"monster.png"];
    // 最小y坐标
    NSInteger minimumY = monster.size.height / 2;
    // 最大y坐标
    NSInteger maximumY = size.height - monster.size.height / 2;
    // y的随机范围
    NSInteger rangeY = maximumY - minimumY;
    // 实际y坐标
    NSInteger actualY = minimumY + arc4random() % rangeY;
    monster.position = CGPointMake(size.width + monster.size.width / 2, actualY);
    [self addChild:monster];
    [_monsters addObject:monster];
    
    // 计算移动时长
    NSInteger minimumDuration = 2.0;
    NSInteger maximumDuration = 4.0;
    // 时长的随机范围
    NSInteger rangeDuration = maximumDuration - minimumDuration;
    // 实际时长
    NSInteger actualDuration = minimumDuration + arc4random() % rangeDuration;
    
    // 初始化并执行移动行为
    SKAction *moveAction = [SKAction moveTo:CGPointMake(-monster.size.width / 2, monster.position.y)
                                   duration:actualDuration];
    // 执行行为
    [monster runAction:moveAction completion:^{
        // 把怪物从场景中移除，清理内存
        [monster removeFromParent];
        [_monsters removeObject:monster];
        // 游戏失败
        [self translateToGameResultSceneWithResult:NO];
    }];
}

- (void)addProjectileAtPoint:(CGPoint)point {
    
    // 判断点击是否有效
    if (point.x < _player.position.x) {
        return;
    }
    if (!_projectiles) {
        _projectiles = [NSMutableArray array];
    }
    // 初始化飞镖
    SKSpriteNode *projectile = [SKSpriteNode spriteNodeWithImageNamed:@"projectile.png"];
    projectile.position = CGPointMake(_player.position.x + projectile.size.width / 2,
                                      _player.position.y);
    [self addChild:projectile];
    [_projectiles addObject:projectile];
    
    CGSize size = self.size;
    // 获取偏移量
    CGPoint offset = CGPointMake(point.x - projectile.position.x, point.y - projectile.position.y);
    // 最终x坐标
    CGFloat actualX = size.width + projectile.size.width / 2;
    // 最终y坐标
    CGFloat actualY = projectile.position.y + offset.y / offset.x * (actualX - projectile.position.x);
    // 最终点位置
    CGPoint actualPoint = CGPointMake(actualX, actualY);
    
    // 求移动时间
    CGFloat actualOffsetX = actualPoint.x - projectile.position.x;
    CGFloat actualOffsetY = actualPoint.y - projectile.position.y;
    // 移动距离
    CGFloat distance = sqrt(pow(actualOffsetX, 2) + pow(actualOffsetY, 2));
    // 移动速度
    CGFloat velocity = size.width / 1;
    // 移动时长
    NSTimeInterval duration = distance / velocity;
    
    // 移动行为
    SKAction *moveAction = [SKAction moveTo:actualPoint duration:duration];
    // 旋转行为
    SKAction *rotateAction = [SKAction rotateByAngle:M_PI duration:0.2];
    SKAction *rotateRepeatAction = [SKAction repeatAction:rotateAction count:10];
    // 执行行为
    [projectile runAction:[SKAction group:@[moveAction, rotateRepeatAction, _projectileSoundEffetAction]] completion:^{
        [projectile removeFromParent];
        [_projectiles removeObject:projectile];
    }];
}

- (void)translateToGameResultSceneWithResult:(BOOL)result {
  
    // 取消全部行为
    [self removeAllActions];
    [_backgroundMusicPlayer stop];
    NSLog(@"size: %f", self.size.width);
    // 初始化游戏结束场景
    GameResultScene *resultScene = [[GameResultScene alloc] initWithSize:self.size result:result];
    SKTransition *transition = [SKTransition revealWithDirection:SKTransitionDirectionUp
                                                        duration:0.5];
    [self.view presentScene:resultScene transition:transition];
}

@end

















