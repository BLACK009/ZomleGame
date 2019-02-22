//
//  Scorer.m
//  ZombieGame
//
//  Created by 周巍昆 on 17/11/17.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "Scorer.h"

@implementation Scorer

+ (instancetype)sharedScorer{
    static Scorer *score = nil;
    if (!score) {
        score = [[self alloc]initPrivate];
    }
    return score;
} 

- (instancetype)initPrivate{
    self = [super init];
    if(self){
    _bigZombie = 0;
    _littleZombie = 0;
    _soldier = 0;
    _attack = 0;
    _defaultBullet = 0;
    _lastScorce = 0;
    }
    return self;
}

- (void)reSet{
    _bigZombie = 0;
    _littleZombie = 0;
    _soldier = 0;
    _attack = 0;
    _defaultBullet = 0;
    _lastScorce = 0;

}

-(int)lastScorce{
    _lastScorce = self.bigZombie * 20
    + self.littleZombie * 7
    + self.soldier * 3
    + self.attack * 30
    + self.defaultBullet * 1;
    
    return _lastScorce;
}
@end
