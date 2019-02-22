//
//  Zombie.m
//  Zombie
//
//  Created by 周巍昆 on 17/10/21.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "Zombie.h"
#import "MainViewController.h"
#import "EndViewController.h"

@implementation Zombie

- (UIImageView*)imageViewWithRect:(CGRect)rect{
    if (_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:rect];
    }
    return _imageView;
}

#pragma mark - 返回整个僵尸群移动多少步/秒，为zombies准备
+ (NSNumber *)ZombieStepsPerSecond{
    static NSNumber *stepsPerSecond = nil;
    if (!stepsPerSecond)
        stepsPerSecond = [NSNumber numberWithFloat:5];
    return stepsPerSecond;
}

#pragma mark - 一只zombie的初始化：位置，生命，编号，图片，步伐长度
-(instancetype )initWithLocation:(CGPoint )location name:(NSString *)name{
#ifdef ZOMBIE_DEBUG
    //NSLog(@"zombie方法：初始化一只zombie\n");
#endif
    CGRect rect;
    if ([name isEqualToString:@"soldier"]){
        if (location.x == 0)
            rect = CGRectMake(-15, location.y, 15, 30);
        else if (location.y == 0)
            rect = CGRectMake(location.x, -40, 15, 30);
        else if (location.x == [UIScreen mainScreen].bounds.size.width)
            rect = CGRectMake(location.x, location.y, 15, 30);
        else if (location.y == [UIScreen mainScreen].bounds.size.height)
            rect = CGRectMake(location.x, location.y, 15, 30);
        
        _name = @"soldier";
        _imageView = [[UIImageView alloc]initWithFrame:rect];
        _imageView.image = [UIImage imageNamed:@"soldier"];
        _life = 1;
        _step = 5;
    }
    else if([name isEqualToString:@"littleZombie"]){
        if (location.x == 0)
            rect = CGRectMake(-15, location.y, 15, 30);
        else if (location.y == 0)
            rect = CGRectMake(location.x, -40, 15, 30);
        else if (location.x == [UIScreen mainScreen].bounds.size.width)
            rect = CGRectMake(location.x, location.y, 15, 30);
        else if (location.y == [UIScreen mainScreen].bounds.size.height)
            rect = CGRectMake(location.x, location.y, 15, 30);
        
        _name = @"littleZombie";
        _imageView = [[UIImageView alloc]initWithFrame:rect];
        _imageView.image = [UIImage imageNamed:@"littleZombie"];
        _life = 1;
        _step = 8;

    }
    else if([name isEqualToString:@"bigZombie"]){
        if (location.x == 0)
            rect = CGRectMake(-40, location.y, 40, 20);
        else if (location.y == 0)
            rect = CGRectMake(location.x, -30, 40, 20);
        else if (location.x == [UIScreen mainScreen].bounds.size.width)
            rect = CGRectMake(location.x, location.y, 40, 20);
        else if (location.y == [UIScreen mainScreen].bounds.size.height)
            rect = CGRectMake(location.x, location.y, 40, 20);
        
        _name = @"bigZombie";
        _imageView = [[UIImageView alloc]initWithFrame:rect];
        _imageView.image = [UIImage imageNamed:@"bigZombie"];
        _life = 7;
        _step = 5;
    }
    
    _serial = [NSNumber numberWithUnsignedLong:time(NULL)];
    
    return self;
}

#pragma mark - 一只zombie移动一步
- (void)moveAStepForMe:(Me *)me{
    //NSLog(@"zombie方法：一只zombie移动一步\n");
    CGPoint point = me.imageView.center;
    double x = point.x - self.imageView.center.x;
    double y = point.y - self.imageView.center.y;
    
    //如果zombie和me的距离足够小，结束游戏
    if (sqrt(x*x + y*y) < self.imageView.frame.size.width / 2){
        //获取当前屏幕的根视图控制器
        UINavigationController *navController =(UINavigationController*)[[UIApplication sharedApplication]keyWindow].rootViewController;
        //将结束界面推入视图
        EndViewController *endVC = [[EndViewController alloc]init];
        [navController pushViewController:endVC animated:YES];
    }
    else{
    double angle;
    if ((x > 0 && y > 0) || (x > 0 && y < 0))
        angle = atan(y / x);
    else
        angle = atan(y / x) + M_PI;
    
    //定义旋转量
    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
    //定义位移点
    CGPoint nextPoint = self.imageView.center;
    nextPoint.x += self.step * cos(angle);
    nextPoint.y += self.step * sin(angle);
    
    //添加位移和旋转动画
    float steps = [[Zombie ZombieStepsPerSecond] floatValue];
    float interval = 1 /steps;
    
    [UIView animateWithDuration:interval delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.imageView.center = nextPoint;
        self.imageView.transform = transform;
    }completion:nil];
    }
}

#pragma mark - 一只zombie死亡
- (void)deadWithTimer:(NSTimer*)timer{
    UIView *view = [[timer userInfo]objectForKey:@"view"];
    Zombies *zombies = [[timer userInfo]objectForKey:@"zombies"];
    
    //删除zombie
    [self.imageView removeFromSuperview];
    [zombies.zombies removeObjectForKey:self.serial];
    
    //添加boom
    UIImageView *boom = [[UIImageView alloc]initWithFrame:CGRectMake( self.imageView.frame.origin.x, self.imageView.frame.origin.y, 70, 50)];
    boom.image = [UIImage imageNamed:@"Boom"];
    [view addSubview:boom];

    [UIView animateWithDuration:1.8 delay:0 options:0 animations:^{
        boom.alpha = 0;
    }completion:^(BOOL finished){
        [boom removeFromSuperview];
    }];
   // [self.imageView removeFromSuperview];
    
}

@end
