//
//  BulletController.m
//  Zombie
//
//  Created by 周巍昆 on 17/11/8.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "BulletController.h"
#import "ChangeStore.h"

#define BULLET_DEBUG

@implementation BulletController
+ (void)controlABulletWithTimer:(NSTimer *)timer{
#ifdef BULLET_DEBUG
    NSLog(@"BulletController方法：\n controlABulletWithTimer:控制一颗bullet移动一步");
#endif
    Zombies *zombies = [[timer userInfo]objectForKey:@"zombies"];
    Gun *gun = [[timer userInfo]objectForKey:@"gun"];
    Bullet *bullet = [[timer userInfo]objectForKey:@"bullet"];
    UIView *view = [[timer userInfo]objectForKey:@"view"];
    
    //如果僵尸群不为空，子弹开始挨个访问僵尸群中的僵尸
    if (zombies.zombies.count){
        float x,y;
        NSArray *keys = [zombies.zombies allKeys];
        for (NSNumber *serial in keys){
            Zombie *zombie = [zombies.zombies objectForKey:serial];
            x = bullet.imageView.center.x - zombie.imageView.center.x;
            y = bullet.imageView.center.y - zombie.imageView.center.y;
            
            //如果击中僵尸：僵尸死亡；子弹威力减一；加分；加子弹
            if ( sqrtf(x*x + y*y) < gun.bulletRadius ){
                zombie.life -= (int)[Gun sharedGun].bulletforce;
                NSLog(@"(int)[Gun sharedGun].bulletforce:%d",(int)[Gun sharedGun].bulletforce);
                if (zombie.life <= 0){
                    //僵尸死亡：
                    [zombie deadWithTimer:timer];
                    [[ChangeStore sharedChangeStore]setCounterWithView:view];

                    //按照死亡僵尸名加分,加子弹
                    if ([zombie.name isEqualToString: @"bigZombie"]){
                        [Scorer sharedScorer].bigZombie++;
                        
                        UILabel *label = [AddedView addedView].labels[2];
                        label.text = [NSString stringWithFormat:@"GreenZombie:%d",[Scorer sharedScorer].bigZombie];
                        
                        if ([gun.currentState isEqualToString:@"default"])
                            gun.defaultBulletAmount += 10;
                    }
                    else if ([zombie.name isEqualToString: @"littleZombie"]){
                        [Scorer sharedScorer].littleZombie++;
                        
                        UILabel *label = [AddedView addedView].labels[3];
                        label.text = [NSString stringWithFormat:@"WhiteZombie:%d",[Scorer sharedScorer].littleZombie];
                        
                        if ([gun.currentState isEqualToString:@"default"])
                            gun.defaultBulletAmount += 3;
                    }
                    else if ([zombie.name isEqualToString:@"soldier"]){
                        [Scorer sharedScorer].soldier++;
    
                        UILabel *label = [AddedView addedView].labels[4];
                        label.text = [NSString stringWithFormat:@"Soldier:%d",[Scorer sharedScorer].soldier];
                        
                        if ([gun.currentState isEqualToString:@"default"])
                            gun.defaultBulletAmount += 2;
                    }
                    
                    //更新子弹数据显示
                    UILabel *label = [AddedView addedView].labels[0];
                    label.text = [NSString stringWithFormat:@"Left Bulelts:%d",gun.defaultBulletAmount];
                }
            
                //删除子弹，关闭timer，结束方法
                    [bullet.imageView removeFromSuperview];
                    [bullet.timerBulletMove invalidate];
                    return;
            }
            //如果没击中僵尸:
            else
                //判断弹是否飞到了屏幕外面，如果是,调整枪的状态，删除子弹，关闭timer，结束方法
                if(bullet.imageView.center.x > [UIScreen mainScreen].bounds.size.width
                   ||bullet.imageView.center.x < 0
                   ||bullet.imageView.center.y > [UIScreen mainScreen].bounds.size.height
                   ||bullet.imageView.center.y < 0){
                
                    [bullet.imageView removeFromSuperview];
                    [bullet.timerBulletMove invalidate];
                    return;
                }
            //如果子弹还在屏幕内，就前进一步
                else{
                    CGPoint point;
                
                    point.x = bullet.imageView.center.x + gun.bulletDistancePerMove * cos(bullet.angle);
                    point.y = bullet.imageView.center.y + gun.bulletDistancePerMove * sin(bullet.angle);
                
                    bullet.imageView.center = point;
                    [view addSubview:bullet.imageView];
                }
        }//for循环结束
    }
    else
        //如果僵尸群为空，判断弹是否飞到了屏幕外面，如果是，删除子弹，关闭timer，结束方法
        if(bullet.imageView.center.x > [UIScreen mainScreen].bounds.size.width
           ||bullet.imageView.center.x < 0
           ||bullet.imageView.center.y > [UIScreen mainScreen].bounds.size.height
           ||bullet.imageView.center.y < 0){
            [bullet.imageView removeFromSuperview];
            [bullet.timerBulletMove invalidate];
            return;
        }
        //如果子弹还在屏幕内，就前进一步
        else{
            CGPoint point;
            
            point.x = bullet.imageView.center.x + gun.bulletDistancePerMove * cos(bullet.angle);
            point.y = bullet.imageView.center.y + gun.bulletDistancePerMove * sin(bullet.angle);
            
            bullet.imageView.center = point;
            [view addSubview:bullet.imageView];
        }

}

+(void)keepABullet:(Bullet*)bullet MovingWithGun:(Gun *)gun zombies:(Zombies *)zombies View:(UIView *)view{
#ifdef BULLET_DEBUG
    NSLog(@"BulletControler类方法: \n keepABullet:MovingWithGun:Zombies:保持一颗子弹的持续移动");
#endif
    float interval = 1 / gun.bulletMoveFrequency;
    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithObjectsAndKeys:gun,@"gun",zombies,@"zombies", view,@"view",bullet,@"bullet",nil];
    //配置bullet的timer
    bullet.timerBulletMove = [NSTimer scheduledTimerWithTimeInterval:interval target:[self class] selector:@selector(controlABulletWithTimer:) userInfo:info repeats:YES];
    //bullet的timer，fire
    [bullet.timerBulletMove fire];
}

@end
