//
//  GunController.m
//  Zombie
//
//  Created by 周巍昆 on 17/11/10.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "GunController.h"

#define BULLET_DEBUG

@implementation GunController : NSObject 

+ (void)launchABulletWithTimer:(NSTimer *)timer{
#ifdef BULLET_DEBUG
    NSLog(@"GunControler类方法：\n launchABulletWithTimer:构造一颗子弹，调用BulletControler方法");
#endif
    Gun *gun = [[timer userInfo]objectForKey:@"gun"];
    Zombies *zombies = [[timer userInfo]objectForKey:@"zombies"];
    Me *me = [[timer userInfo]objectForKey:@"me"];
    UIView *view = [[timer userInfo]objectForKey:@"view"];
    
    //调整枪的子弹
    if ([gun.currentState isEqualToString:@"default"] == NO){
        gun.otherBulletAmount--;
        if (gun.otherBulletAmount <= 0)
            gun.currentState = @"default";
        //从新配置gun.tiemr的频率
            gun.launchFrequency = 2.5;
            gun.bulletRadius = 15;
            gun.bulletforce = 1;
    }
    else{
        if (gun.defaultBulletAmount <= 0)
            return;
        gun.defaultBulletAmount--;
    
        //更新子弹数据
        UILabel *label = [AddedView addedView].labels[0];
        label.text = [NSString stringWithFormat:@"Left Bulelts:%d",gun.defaultBulletAmount];
    }

    //控制一颗子弹的移动
    Bullet *bullet = [gun LoadABullletWithMe:me View:view];
    [BulletController keepABullet:bullet MovingWithGun:gun zombies:zombies View:view];
}


+ (void)keepLaunchingWithGun:(Gun *)gun Me:(Me *)me Zombies:(Zombies *)zombies View:(UIView *)view{
    
#ifdef BULLET_DEBUG
    NSLog(@"GunController类方法： \n keepLaunchingWithGun:Me:Zombie:保持枪的持续发射");
#endif
    
    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithObjectsAndKeys:gun,@"gun",zombies,@"zombies",me,@"me",view,@"view",nil];
    //配置gun的timer
    float interval = 1 / gun.launchFrequency;
    gun.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:[self class] selector:@selector(launchABulletWithTimer:) userInfo:info repeats:YES];
    //gun的timer，fire
    [gun.timer fire];
}

@end
