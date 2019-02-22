//
//  Bullets.m
//  Zombie
//
//  Created by 周巍昆 on 17/10/29.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "Gun.h"


#define BULLET_DEBUG

@implementation Gun


+(instancetype)sharedGun{
    static Gun *gun = nil;
    if (!gun){
        gun = [[Gun alloc]initPrivate];
    }
    return gun;
}

- (instancetype)initPrivate{
    self = [super init];
    _bullets = [[NSMutableDictionary alloc]init];
    _launchFrequency = 2.5;
    _bulletRadius = 15;
    _bulletforce = 1;
    
    //设置子弹状态
    _lastState = _currentState = @"default";
    _bulletDistancePerMove = 7;
    _bulletMoveFrequency = 60;
    
    //设置子弹数量
    _defaultBulletAmount = 50;
    _otherBulletAmount = 0;
    _awardBulletAmount = 5;
    
    return self;

}

- (void)reset{
    self.currentState = @"default";
    self.launchFrequency = 2.5;
    self.bulletRadius = 15;
    self.bulletforce = 1;
}

- (instancetype)init{
#ifdef BULLET_DEBUG
    NSLog(@"Gun类方法：\n init初始化一只gun");
#endif
    _bullets = [[NSMutableDictionary alloc]init];
    _launchFrequency = 2.5;
    _bulletRadius = 15;
    _bulletforce = 1;
    
    //设置子弹状态
    _lastState = _currentState = @"default";
    _bulletDistancePerMove = 7;
    _bulletMoveFrequency = 60;
    
    //设置子弹数量
    _defaultBulletAmount = 50;
    _otherBulletAmount = 0;
    _awardBulletAmount = 5;
    
    return self;
}

- (Bullet *)LoadABullletWithMe:(Me *)me View:(UIView *)view{
#ifdef BULLET_DEBUG
    NSLog(@"Gun类方法：\n LoadABulletWithMe：，装载（生成）一颗子弹");
#endif
    Bullet *bullet = [[Bullet alloc]initWithState:self.currentState FromMe:me];
    [view addSubview:bullet.imageView];
    
//    if ([self. currentState isEqualToString:@"defaulet"])
//        self.defaultBulletAmount --;
//    else
//        self.otherBulletAmount --;
    return bullet;
}
@end
