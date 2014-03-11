//
//  DDMyScene.m
//  「UI」精灵(day18)
//
//  Created by 萧川 on 14-3-3.
//  Copyright (c) 2014年 CUAN. All rights reserved.
//

#import "DDMyScene.h"
#import <AVFoundation/AVFoundation.h>
#import "DDGameResultScene.h"

@interface DDMyScene () {
    SKSpriteNode *_player;
    NSMutableArray *_monsters;
    NSMutableArray *_projectiles;
    
    AVAudioPlayer *_backgroundMusicPlayer;
    SKAction *_projectileSound;
    NSInteger _monsterKilledCount;
}

- (void)initUserInterfaceWithSize:(CGSize)size;
- (void)addMonster;
- (void)addProjectilAtPoint:(CGPoint)point;
// 检测碰撞
- (void)updateCloission;
- (void)initMedia;

- (void)translateToGameRresultWithResult:(BOOL)success;

@end

@implementation DDMyScene


-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        _monsterKilledCount = 0;

        [self initMedia];
        [self initUserInterfaceWithSize:size];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    [self addProjectilAtPoint:location];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    [self addProjectilAtPoint:location];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [self updateCloission];
}

#pragma mark 私有方法

- (void)initMedia
{
    NSURL *url = [[NSBundle mainBundle] URLForAuxiliaryExecutable:@"background-music-aac.caf"];
    NSError *error = nil;
    _backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    NSAssert(!error, @"Initialize background music player failed with error message %@", [error localizedDescription]);
    _backgroundMusicPlayer.numberOfLoops = -1;
    [_backgroundMusicPlayer prepareToPlay];
    [_backgroundMusicPlayer play];
    
    // 初始化武器音效
    _projectileSound = [SKAction playSoundFileNamed:@"pew-pew-lei.caf" waitForCompletion:NO];
}

- (void)initUserInterfaceWithSize:(CGSize)size {
    
    self.backgroundColor = [SKColor whiteColor];
    
    // 使用图片初始化玩家
    _player = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
    // 配置精灵位置
    _player.position = CGPointMake(_player.size.width / 2, size.height / 2);
    // 添加精灵到场景中
    [self addChild:_player];
    // 添加怪物
    SKAction *addMonsterAction = [SKAction runBlock:^{
        [self addMonster];
    }];
    // 等待
    SKAction *waitAction = [SKAction waitForDuration:1.0f withRange:0.5f];
    // 打包怪物和等待行为
    SKAction *totalAction = [SKAction sequence:@[addMonsterAction, waitAction]];
    // 创建无限行为
    SKAction *foreverAction = [SKAction repeatActionForever:totalAction];
    [self runAction:foreverAction];
}

- (void)updateCloission
{
    SKSpriteNode *deleteMonster = nil;
    SKSpriteNode *deleteProjectile = nil;
    for (SKSpriteNode *monster in _monsters) {
        for (SKSpriteNode *projectile in _projectiles) {
            if (CGRectIntersectsRect(monster.frame, projectile.frame)) {
                deleteMonster = monster;
                deleteProjectile = projectile;
            }
        }
    }
    // 若存在，删除
    if (deleteMonster && deleteProjectile) {
        [deleteMonster removeFromParent];
        [deleteProjectile removeFromParent];
        [_monsters removeObject:deleteMonster];
        [_projectiles removeObject:deleteProjectile];
        if (++_monsterKilledCount >= 20) {
            NSLog(@"赢了");
            [self translateToGameRresultWithResult:YES];
        }
    }
}

#pragma mark - 精灵添加方法

// 添加怪物
- (void)addMonster {

    if (!_monsters) {
        _monsters = [NSMutableArray array];
    }
    CGSize size = self.size;
    // 初始化敌人精灵
    SKSpriteNode *monster = [SKSpriteNode spriteNodeWithImageNamed:@"monster"];
    // 指定位置
    NSInteger minimumY = monster.size.height / 2;
    NSInteger maximumY = size.height - monster.size.height / 2;
    NSInteger rangeY = maximumY - minimumY;
    NSInteger actualY = minimumY + arc4random() % rangeY;
    monster.position = CGPointMake(size.width + monster.size.width / 2, actualY);
    [_monsters addObject:monster];
    [self addChild:monster];

    // 初始化并执行移动事件
    NSTimeInterval minimumDuration = 2.0f;
    NSTimeInterval maximumDuration = 4.0f;
    NSTimeInterval rangDuration = maximumDuration - minimumDuration;
    NSTimeInterval actualDuration = minimumDuration + arc4random() % (int)rangDuration;
    SKAction *moveAction = [SKAction moveTo:CGPointMake(-monster.size.width / 2, monster.position.y)
                                   duration:actualDuration];
    
    [monster runAction:moveAction completion:^{
        // 把怪物从场景中去除，清理内存
        [_monsters removeObject:monster];
        [monster removeFromParent];
        // 游戏失败
        NSLog(@"挂了");
        [self translateToGameRresultWithResult:NO];
    }];
}

- (void)addProjectilAtPoint:(CGPoint)point
{
    // 判断点击是否有效
    if (point.x < _player.position.x) {
        return;
    }
    // 初始化飞镖
    if (!_projectiles) {
        _projectiles = [NSMutableArray array];
    }
    SKSpriteNode *projectile = [SKSpriteNode spriteNodeWithImageNamed:@"projectile"];
    projectile.position = CGPointMake(_player.position.x + projectile.size.width / 2, _player.position.y);
    [_projectiles addObject:projectile];
    [self addChild:projectile];
    // 获取偏移量
    CGSize size = self.size;
    CGPoint offset = CGPointMake(point.x - projectile.position.x, point.y - projectile.position.y);
    // 最终x坐标
    CGFloat actualX = size.width + projectile.size.width / 2;
    // 最终y坐标
    CGFloat actualY = _player.position.y + offset.y  / offset.x * (actualX - projectile.position.x);
    // 最终坐标点
    CGPoint actualPoint = CGPointMake(actualX, actualY);

    //
    CGFloat actualOffsetX = actualPoint.x - projectile.position.x;
    CGFloat acutalOffsetY = actualPoint.y - projectile.position.y;
    // 移动距离
    CGFloat distance = sqrt(pow(actualOffsetX, 2) + pow(acutalOffsetY, 2));
    // 移动速度
    CGFloat velocity = size.width / 1.0f;
    // 移动时间
    NSTimeInterval duration = distance / velocity;
    // 移动行为
    SKAction *moveAction = [SKAction moveTo:actualPoint duration:duration];
    // 旋转行为
    SKAction *rotation = [SKAction rotateByAngle:M_PI duration:0.2];
    SKAction *rotateRepeatAction = [SKAction repeatAction:rotation count:10];
    [projectile runAction:[SKAction group:@[moveAction, rotateRepeatAction, _projectileSound]] completion:^{
        [_projectiles removeObject:projectile];
        [projectile removeFromParent];
    }];
}

- (void)translateToGameRresultWithResult:(BOOL)success
{
    [self removeAllActions];
    [_backgroundMusicPlayer stop];

    DDGameResultScene *resultScens = [[DDGameResultScene alloc] initWithSize:self.size result:success];
    SKTransition *transition = [SKTransition revealWithDirection:SKTransitionDirectionUp duration:0.5];
    [self.view presentScene:resultScens transition:transition];
}

@end
