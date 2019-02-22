//
//  BulletController.h
//  Zombie
//
//  Created by 周巍昆 on 17/11/8.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gun.h"
#import "Scorer.h"

@interface BulletController : NSObject



+ (void)controlABulletWithTimer:(NSTimer*)timer;

+ (void)keepABullet:(Bullet*)bullet MovingWithGun:(Gun*)gun zombies:(Zombies*)zombies View:(UIView*)view;

@end
