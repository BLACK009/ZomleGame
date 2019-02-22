//
//  GunController.h
//  Zombie
//
//  Created by 周巍昆 on 17/11/10.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BulletController.h"

@interface GunController : NSObject

+ (void)launchABulletWithTimer:(NSTimer*)timer;

+ (void)keepLaunchingWithGun:(Gun*)gun Me:(Me*)me Zombies:(Zombies*)zombies View:(UIView*)view;

@end
