//
//  Zombie.h
//  Zombie
//
//  Created by 周巍昆 on 17/10/21.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Zombies.h"
#import "Me.h"

@interface Zombie : NSObject


@property (nonatomic,strong)UIImageView * imageView;

@property (nonatomic,strong) NSNumber *serial;
@property (nonatomic,strong) NSString *name;

@property (nonatomic) int life;
@property (nonatomic) int step;

+ (NSNumber *)ZombieStepsPerSecond;//步伐自定义为5步/秒

- (instancetype )initWithLocation:(CGPoint )location name:(NSString*)name;

- (void)moveAStepForMe:(Me*)me;

- (void)deadWithTimer:(NSTimer*)timer;
@end
