//
//  mainView.m
//  Zombie
//
//  Created by 周巍昆 on 17/10/21.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "MainView.h"
#import "ChangeStore.h"

@implementation MainView

#pragma mark - 属性设置
-(UIImageView *)moveCircleSide{
    if (!_moveCircleSide){
        CGRect rect;
        rect.origin.x = 10;
        rect.origin.y = self.frame.size.height - 110;
        rect.size.width = 100;
        rect.size.height = 100;
        
        _moveCircleSide = [[UIImageView alloc]initWithFrame:rect];
        
        _moveCircleSide.image = [UIImage imageNamed:@"circleSide"];
    }
    return _moveCircleSide;
}


-(UIImageView *)trendCircleSide{
    if (!_trendCircleSide){
        CGRect rect;
        rect.origin.x = self.frame.size.width - 110;
        rect.origin.y = self.frame.size.height - 110;
        rect.size.width = 100;
        rect.size.height = 100;
        
        _trendCircleSide = [[UIImageView alloc]initWithFrame:rect];
        
        _trendCircleSide.image = [UIImage imageNamed:@"circleSide"];
    }
    return _trendCircleSide;
}

-(UIImageView *)moveCircle{
    if (!_moveCircle){
        _moveCircle = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        _moveCircle.center = self.moveCircleSide.center;
        _moveCircle.image = [UIImage imageNamed:@"circle"];
    }
    return _moveCircle;
}

-(UIImageView *)trendCircle{
    if (!_trendCircle){
        _trendCircle = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        _trendCircle.center = self.trendCircleSide.center;
        _trendCircle.image = [UIImage imageNamed:@"circle"];
    }
    return _trendCircle;
}

#pragma mark - moveLink设置
-(CADisplayLink *)moveLink{
    if (!_moveLink || self.moved == NO){
        _moveLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(meMoveAStep)];
        _moveLink.preferredFramesPerSecond = self.me.stepFrequency;
    }
    return _moveLink;
}

-(BOOL)moved{
    if (!_moved)
        _moved = NO;
    return _moved;
}

-(void)meMoveAStep{
    
    CGPoint center;
    center = self.me.imageView.center;
    center.x += self.me.step * cos(self.moveAngle);
    center.y += self.me.step * sin(self.moveAngle);
    
    if(center.x < 0
       || center.x > self.frame.size.width
       || center.y < 0
       || center.y > self.frame.size.height)
        return ;
    
    self.me.imageView.center = center;
    [self addSubview:self.me.imageView];
    //访问chagneStore
    if([[ChangeStore sharedChangeStore].changes count]){
        float x,y;
        NSArray *changes = [[ChangeStore sharedChangeStore].changes allValues];
        for (Change *change in changes){
            x = self.me.imageView.center.x - change.image.center.x;
            y = self.me.imageView.center.y - change.image.center.y;
            //如果和change的距离足够小：
            if (sqrtf(x*x + y*y)< 0.7 * change.image.frame.size.width){
                [change removeChange];
                
                if ([change.name isEqualToString:@"red"]){
                    self.gun.defaultBulletAmount += 20.0;
                    UILabel *label = [AddedView addedView].labels[0];
                    label.text = [NSString stringWithFormat:@"Left Bulelts:%d",self.gun.defaultBulletAmount];

                }
                
                else if ([change.name isEqualToString:@"black"]){
                    
                        self.gun.currentState = @"strongForce";
                        self.gun.launchFrequency = 2;
                        self.gun.bulletforce = 10.0;
                        self.gun.bulletRadius = 30;
                        self.gun.otherBulletAmount = 17;
                }
            }
        }
    }
}

#pragma mark - view初始化

+ (instancetype)sharedMainView{
    static MainView *view = nil;
    if (!view){
        view = [[MainView alloc]initPrivate];
    }
    return view;
}

- (instancetype)initPrivate{
    NSLog(@"MainView:   initPrivate");
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    UIImageView *background = [[UIImageView alloc]initWithFrame:self.bounds];
    background.contentMode = UIViewContentModeScaleToFill;
    background.image = [UIImage imageNamed:@"background1"];
    [self addSubview:background];
    
    
    self.me = [[Me alloc]initWithLocation:self.center Image:[UIImage imageNamed:@"me"]];
    [self addSubview:self.me.imageView];
    
    [self addSubview:self.moveCircle];
    [self addSubview:self.moveCircleSide];
    [self addSubview:self.trendCircle];
    [self addSubview:self.trendCircleSide];
    
    
    static int j = 0;
    if (!j){
        self.zombies = [Zombies sharedZombies];
        self.gun = [Gun sharedGun];
    }
    else{
        self.zombies = [[Zombies sharedZombies]initPrivate];
        self.gun = [[Gun sharedGun]initPrivate];
    }
    j++;
    
    
    [self addSubview:[AddedView addedView]];
    [[AddedView addedView]reSet];
    UILabel *label = [AddedView addedView].labels[0];
    label.text = [NSString stringWithFormat:@"Left Bulelts:%d",self.gun.defaultBulletAmount];
    self.zombies.timerIfBeginAttack = [self.zombies timerIfBeginAttackInView:self ForMe:self.me];
    [self.zombies.timerIfBeginAttack fire];
    
    self.multipleTouchEnabled = YES;
    
    return self;
}



-(instancetype)init{
    NSLog(@"MainView:   init");
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    UIImageView *background = [[UIImageView alloc]initWithFrame:self.bounds];
    background.contentMode = UIViewContentModeScaleToFill;
    background.image = [UIImage imageNamed:@"background1"];
    [self addSubview:background];
    
    
    self.me = [[Me alloc]initWithLocation:self.center Image:[UIImage imageNamed:@"me"]];
    [self addSubview:self.me.imageView];
    
    [self addSubview:self.moveCircle];
    [self addSubview:self.moveCircleSide];
    [self addSubview:self.trendCircle];
    [self addSubview:self.trendCircleSide];
  
    self.zombies = [Zombies sharedZombies];
    self.gun = [Gun sharedGun];
    
    [self addSubview:[AddedView addedView]];
    [[AddedView addedView]reSet];
    UILabel *label = [AddedView addedView].labels[0];
    label.text = [NSString stringWithFormat:@"Left Bulelts:%d",self.gun.defaultBulletAmount];
    self.zombies.timerIfBeginAttack = [self.zombies timerIfBeginAttackInView:self ForMe:self.me];
    [self.zombies.timerIfBeginAttack fire];
    
    self.multipleTouchEnabled = YES;
    
    return self;
}



#pragma mark - touchBegan
//只有当触碰从圆内开始时才为有效操作
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for(UITouch *t in touches){
        CGPoint touchPoint = [t locationInView:self];
        
        float x_move = touchPoint.x - self.moveCircle.center.x;
        float y_move = touchPoint.y - self.moveCircle.center.y;
        
        float x_trend = touchPoint.x - self.trendCircle.center.x;
        float y_trend = touchPoint.y - self.trendCircle.center.y;
        
        float radius = self.moveCircleSide.frame.size.width/2;
        
        float moveDistance = sqrtf( x_move * x_move + y_move * y_move );
        float trendDistance = sqrtf(x_trend * x_trend + y_trend * y_trend);
        
        if (moveDistance < radius)
            self.moveBegan = YES;
        
        if (trendDistance < radius)
            self.trendBegan = YES;
        
    }
}

#pragma mark touchMove
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint;
    
    for(UITouch *t in touches){
        touchPoint = [t locationInView:self];
        
        float x_move = touchPoint.x - self.moveCircleSide.center.x;
        float y_move = touchPoint.y - self.moveCircleSide.center.y;
        
        float x_trend = touchPoint.x - self.trendCircleSide.center.x;
        float y_trend = touchPoint.y - self.trendCircleSide.center.y;
        
        float radius = self.moveCircleSide.frame.size.width/2;
        
        float moveDistance = sqrtf( x_move * x_move + y_move * y_move );
        float trendDistance = sqrtf(x_trend * x_trend + y_trend * y_trend);
    
        //如果触碰点在圆边的范围内，圆点随着触碰点移动，左圆盘响应
        if(self.moveBegan == YES){
            //产生moveAngle
            if ((x_move>0 && y_move>0) || (x_move>0 && y_move<0))
                self.moveAngle = atan(y_move / x_move);
            else
                self.moveAngle = atan(y_move / x_move) + M_PI;
            
            //move圆盘的移动
            if (moveDistance <= radius)
                self.moveCircle.center = touchPoint;
            else{
                CGPoint center;
                center.x = self.moveCircleSide.center.x + radius * cos(self.moveAngle);
                center.y = self.moveCircleSide.center.y + radius * sin(self.moveAngle);
                self.moveCircle.center = center;
            }
            
            //加入moveCircleLink，me移动
            if(self.moved == NO){
                [self.moveLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
                self.moved = YES;
            }
        }
        
        //如果触碰点在圆边的范围内，圆点随着触碰点移动，右圆盘响应
        if (self.trendBegan == YES){
            //产生trendAngle
            if ((x_trend>0 && y_trend>0) || (x_trend>0 && y_trend<0))
                self.trendAngle = atan(y_trend / x_trend);
            else
                self.trendAngle = atan(y_trend / x_trend) + M_PI;
            
            //trend圆盘的移动
            if (trendDistance <= radius)
                self.trendCircle.center = touchPoint;
            else{
                CGPoint center;
                center.x = self.trendCircleSide.center.x + radius * cos(self.trendAngle);
                center.y = self.trendCircleSide.center.y + radius * sin(self.trendAngle);
                self.trendCircle.center = center;
            }
            //me转向
            CGAffineTransform transform = CGAffineTransformMakeRotation(self.trendAngle);
            self.me.angle = self.trendAngle;
            self.me.imageView.transform = transform;
            [self addSubview:self.me.imageView];
            
            //发射子弹
            if (!self.gun.timer || self.gun.timer.isValid == NO)
                [GunController keepLaunchingWithGun:self.gun Me:self.me Zombies:self.zombies View:self];
            
        }
    }
}

#pragma mark touchEnd
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.moveCircle.center = self.moveCircleSide.center;
    self.trendCircle.center = self.trendCircleSide.center;
    
    self.moveBegan = NO;
    self.trendBegan = NO;
    [self.gun.timer invalidate];
    
    if(self.moved){
        [self.moveLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.moved = NO;
    }
}


- (void)viewDisapper{
    [self.zombies.timerIfBeginAttack invalidate];
    [self.zombies.timerAddAZombieToView invalidate];
    [self.zombies.timerMoveZombiesAStep invalidate];
    
    if (self.gun.timer.isValid)
        [self.gun.timer invalidate];
    self.zombies.isViewValid = NO;
    
    Scorer *score = [Scorer sharedScorer];
    score.attack = self.zombies.attackCount;
    score.defaultBullet = self.gun.defaultBulletAmount;
    
    [[ChangeStore sharedChangeStore]reset];
}

@end
