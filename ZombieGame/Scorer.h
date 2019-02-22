//
//  Scorer.h
//  ZombieGame
//
//  Created by 周巍昆 on 17/11/17.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Scorer : NSObject

@property (nonatomic) int bigZombie;
@property (nonatomic) int littleZombie;
@property (nonatomic) int soldier;
@property (nonatomic) int attack;
@property (nonatomic) int defaultBullet;
@property (nonatomic) int lastScorce;

- (instancetype)initPrivate;
- (int)lastScorce;
- (void)reSet;
+ (instancetype)sharedScorer;
@end
