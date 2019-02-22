//
//  Zombies.m
//  Zombie
//
//  Created by 周巍昆 on 17/10/29.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "Zombies.h"
#import "Scorer.h"

@implementation Zombies


#pragma mark - 返回一个僵尸群
+ (instancetype)sharedZombies{
    static Zombies *publicZombies = nil;
    if (!publicZombies)
        publicZombies = [[self alloc]initPrivate];
    return publicZombies;
}


#pragma mark - zombies初始化
- (instancetype)initPrivate{
    _zombies = [[NSMutableDictionary alloc]init];
    
    _attackCount = 0;
    
    _initAmount = 10;
    _addAmount = 5;
    _currentAmount = 0;
    
    _isViewValid = YES;
    return self;
    
}



#pragma mark - zombies初始化
- (instancetype)init{
    self = [super init];
    _zombies = [[NSMutableDictionary alloc]init];
    
    _attackCount = 0;
    
    _initAmount = 10;
    _addAmount = 5;
    _currentAmount = 0;
    
    _isViewValid = YES;
    return self;
    
}


#pragma mark - 添加一只僵尸至视图：
- (void)addAZombieToView:(NSTimer*)timer{
    //在屏幕周围随机产生一个点
    //NSLog(@"Zombies类方法：addAzombieToView被调用");
    CGPoint location;
    CGSize size = [UIScreen mainScreen].bounds.size;
    int sideNumber = arc4random()%3;
    if (sideNumber == 0){
        location.x = 0;
        location.y = arc4random() % (int)size.height;
    }
    else if (sideNumber == 1){
        location.y = 0;
        location.x = arc4random() % (int)size.width;
    }
    else if (sideNumber == 2){
        location.x = size.width;
        location.y = arc4random() % (int)size.height;
    }
    else{
        location.y = size.height;
        location.x = arc4random() % (int)size.width;
    }
    
    //当一波僵尸还未添加完毕时：向zombies字典中充填zombie对象,并向屏幕添加imageView
    if (self.currentAmount < self.allAmount){
        Zombie *zombie;
        int zombieKind = arc4random() % 7;
        //if (self.currentAmount < (self.allAmount * 5/10))
        if (zombieKind == 6)
            zombie = [[Zombie alloc]initWithLocation:location name:@"bigZombie"];
        //else if (self.currentAmount <  self.allAmount * 7/10)
        else if (zombieKind == 5 || zombieKind == 4)
            zombie = [[Zombie alloc]initWithLocation:location name:@"littleZombie" ];
        else
            zombie = [[Zombie alloc]initWithLocation:location name:@"soldier"];
        //NSLog(@"currentNumber:%f",self.currentAmount);
        
        self.currentAmount++;
        [self.zombies setObject:zombie forKey:zombie.serial];
        UIView *view = [(NSMutableDictionary*)[timer userInfo]objectForKey:@"view"];
        [view addSubview:zombie.imageView];
    }
    //当一波僵尸添加完毕时，关闭timer
    else
        [self.timerAddAZombieToView invalidate];
}

#pragma mark  配置计时器：连接-添加一只僵尸至视图
- (NSTimer *)timerAddAZombieToView:(UIView *)view{
    //NSLog(@"为连续添加僵尸至视图配置计时器:tiemrAddAZombieToView\n");
    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithObjectsAndKeys:view,@"view", nil];
    
    if (!_timerAddAZombieToView || _timerAddAZombieToView.isValid == NO){
        float interval = 30.0 / self.allAmount;
        _timerAddAZombieToView = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(addAZombieToView:) userInfo:info repeats:YES];
    }
    return _timerAddAZombieToView;
}

#pragma mark 开始持续地"添加一只僵尸至视图"
- (void)keepAddingAZombieToView:(UIView*)view{
    //NSLog(@"开始持续添加僵尸至视图:keepAddingAZombieToView\n");
    [self timerAddAZombieToView:view];
    [self.timerAddAZombieToView fire];
}




#pragma mark - 整个尸群移动一步
- (void)MoveZombiesAStepForMe:(NSTimer*)timer{
    //NSLog(@"zombies类方法：MoveZombiesAStepForMe被调用");
    //如果僵尸群为空:
    if (!self.zombies.count){
        if (self.timerAddAZombieToView.isValid == NO){
            self.currentAmount = 0;
            self.attackCount++;
            [self.timerMoveZombiesAStep invalidate];
            
            UILabel *label = [AddedView addedView].labels[1];
            label.text = [NSString stringWithFormat:@"Attack:%0.fth",self.attackCount + 1];
        }
        
    }
    else{
        Me *me = [(NSMutableDictionary*)[timer userInfo]objectForKey:@"me"];
        NSArray *zombies = [self.zombies allValues];
        for(Zombie *z in zombies)
            if (self.isViewValid == YES)
                [z  moveAStepForMe:me];
            else
                return;
    }
}

#pragma mark 配置计时器：连接-整个僵尸群移动一步
- (NSTimer *)timerMoveZombiesAStepForMe:(Me*)me{
    //NSLog(@"为僵尸群的持续移动配置计时器：timerMoveZombiesAStepForMe");
    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithObjectsAndKeys:me,@"me", nil];
 
    if(!_timerMoveZombiesAStep || _timerMoveZombiesAStep.isValid == NO){
        float stepsPerSecond= [[Zombie ZombieStepsPerSecond]floatValue];
        float interval = 1 / stepsPerSecond;
        _timerMoveZombiesAStep = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(MoveZombiesAStepForMe:) userInfo:info repeats:YES];
    }
    return _timerMoveZombiesAStep;
}

#pragma mark  整个僵尸群开始持续移动
- (void)keepMovingZombiesForMe:(Me*)me{
    //NSLog(@"使整个僵尸群保持移动：keepMovingZombiesForMe");
    [self timerMoveZombiesAStepForMe:me];
    [self.timerMoveZombiesAStep fire];
}



#pragma mark - 循环询问是否开始又一波攻击
- (void)ifBeginAttackWithInfo:(NSTimer*)timer{
    NSLog(@"开始又一波攻击吗？ifBeginAttackWithInfo");
    if ( !self.timerMoveZombiesAStep || self.timerMoveZombiesAStep.isValid == NO){
        NSLog(@"yes，开始又一波攻击\n");
        
        //设置AddedView的动画
        UIView *view = [[timer userInfo] objectForKey:@"view"];
        UILabel *tip = [AddedView addedView].tip;
        
        tip.center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height + 50);;
        tip.alpha = 0;
        tip.text = [NSString stringWithFormat:@"The %0.fth attack is coming!",self.attackCount+1];
        
        [UIView animateKeyframesWithDuration:2.0 delay:0 options:0 animations:^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.25 animations:^{
                tip.center = view.center;
                tip.alpha = 1;
            }];
            [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
                tip.center = CGPointMake(view.center.x, -50);
                tip.alpha = 0;
    
            }];
        }completion:NULL];
        

        self.allAmount = self.initAmount + self.addAmount * self.attackCount;
        [self keepAddingAZombieToView:[(NSMutableDictionary *)[timer userInfo] objectForKey:@"view"]];
        [self keepMovingZombiesForMe:[(NSMutableDictionary*)[timer userInfo] objectForKey:@"me"]];
        
    }
}

- (NSTimer *)timerIfBeginAttackInView:(UIView *)view ForMe:(Me *)me{
    if (!_timerIfBeginAttack || _timerIfBeginAttack.isValid == YES){
        NSMutableDictionary *info = [[NSMutableDictionary alloc]init];
        [info setObject:view forKey:@"view"];
        [info setObject:me forKey:@"me"];
        
        _timerIfBeginAttack = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(ifBeginAttackWithInfo:) userInfo:info repeats:YES];
    }
    return _timerIfBeginAttack;
}

//添加NSTimer or CADisplayLink 开启zombiesMoveAStepForPoint循环

@end
