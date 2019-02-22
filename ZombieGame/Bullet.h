//
//  Bullet.h
//  Zombie
//
//  Created by 周巍昆 on 17/10/29.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Zombies.h"

@interface Bullet : NSObject

@property (nonatomic,strong) UIImageView *imageView;
//@property (nonatomic) float force;
@property (nonatomic) double angle;
@property (nonatomic,strong) NSNumber *serial;

@property (nonatomic,strong)NSTimer *timerBulletMove;

- initWithState:(NSString*)state FromMe:(Me*)me;


/*
@property (nonatomic) float aBulletMoveFrequency;
@property (nonatomic,strong) CADisplayLink *aBulletMoveLink;    //在Gun类中的beginLaunch方法中开启，与bulletMoveAStepInZombies:连接,并在其中关闭。频率由Gun通过aBulletMoveFrequency来决定

+ (NSNumber *)bulletRadius;
+ (NSNumber *)bulletStep;


- (instancetype)initWithLocation:(CGPoint)location angle:(double)angle name:(NSString *)name;

- (void)reuseForChangedNameWithLocation:(CGPoint)location angle:(double)angle name:(NSString *)name;

- (void)reuseForUnchangedNameWithLocation:(CGPoint)location angle:(double)angel name:(NSString *)name;

- (void)aBulletMoveAStepInZombies:(Zombies *)Zombies;
*/
@end
