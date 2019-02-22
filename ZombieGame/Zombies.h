//
//  Zombies.h
//  Zombie
//
//  Created by 周巍昆 on 17/10/29.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "zombie.h"
#import "Me.h"
#import "AddedView.h"

@interface Zombies : NSObject

@property (nonatomic,strong) NSMutableDictionary *zombies;


//管理攻击波数
@property (nonatomic) float attackCount;

//管理僵尸数量
@property (nonatomic) float initAmount;
@property (nonatomic) float addAmount;
@property (nonatomic) float currentAmount;
@property (nonatomic) float allAmount;

@property (nonatomic,strong)NSTimer *timerAddAZombieToView;
@property (nonatomic,strong)NSTimer *timerMoveZombiesAStep;
@property (nonatomic,strong) NSTimer *timerIfBeginAttack;
//循环:询问是否开始一波攻击：在mainView中开启，与addAttackToView:ForPoint:连接，不关闭。频率：1次/秒
@property (nonatomic) BOOL isViewValid;


+ (instancetype)sharedZombies;
- (instancetype)initPrivate;

- (void)MoveZombiesAStepForMe:(Me *)me;
- (NSTimer *)timerMoveZombiesAStepForMe:(Me *)me;
- (void)keepMovingZombiesForMe:(Me *)me;

- (void)addAZombieToView:(UIView *)view;
- (NSTimer *)timerAddAZombieToView:(UIView *)view;
- (void)keepAddingAZombieToView:(UIView *)view;

- (void)ifBeginAttackWithInfo:(NSArray *)info;
- (NSTimer *)timerIfBeginAttackInView:(UIView *)view ForMe:(Me *)me;
//+ (instancetype)publicZombies;//共享对象，一个应用只有一个该类对象

@end
