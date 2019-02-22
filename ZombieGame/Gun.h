//
//  Bullets.h
//  Zombie
//
//  Created by 周巍昆 on 17/10/29.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Bullet.h"
#import "AddedView.h"

@interface Gun : NSObject

@property (nonatomic,strong) NSMutableDictionary *bullets;

//枪的状态
@property (nonatomic) float launchFrequency;
@property (nonatomic) float bulletRadius;
@property (nonatomic) float bulletforce;
//子弹状态
@property (nonatomic,strong) NSString *lastState;
@property (nonatomic,strong) NSString *currentState;
@property (nonatomic) float bulletDistancePerMove;
@property (nonatomic) float bulletMoveFrequency;
//子弹数量
@property (nonatomic) int defaultBulletAmount;
@property (nonatomic) int awardBulletAmount;
@property (nonatomic) int otherBulletAmount;

//timer
@property (nonatomic,strong) NSTimer *timer;


//
//+ (instancetype)publicGun;
//
//- (instancetype)initWithLocation:(CGPoint)point;
//
//- (void)changeBulletWithName:(NSString *)name;
//
//- (void)launchBullet;
//
//- (void)stopLaunching;


+ (instancetype)sharedGun;

- (instancetype)initPrivate;

- (Bullet*)LoadABullletWithMe:(Me*)me View:(UIView*)view;


@end
