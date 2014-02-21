//
//  AnimationTransitionViewController.m
//  高级动画
//
//  Created by 张鹏 on 14-2-20.
//  Copyright (c) 2014年 rimi. All rights reserved.
//

#import "AnimationTransitionViewController.h"

@interface AnimationTransitionViewController ()

- (void)initializeUserInterface;
- (void)startAnimationTransition;

@end

@implementation AnimationTransitionViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.title = NSStringFromClass([self class]);
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self initializeUserInterface];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self startAnimationTransition];
}

- (void)initializeUserInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = @"Animation";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:40];
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
}

- (void)startAnimationTransition {
    
    self.view.backgroundColor = [UIColor specialRandomColor];
    
    NSArray *subtypes = @[kCATransitionFromBottom, kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.delegate = self;
    transition.type = kCATransitionMoveIn;
    transition.subtype = subtypes[arc4random() % 4];
    [self.view.layer addAnimation:transition forKey:@"transition"];
}

- (void)animationDidStart:(CAAnimation *)anim {
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
