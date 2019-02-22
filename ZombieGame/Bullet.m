//
//  Bullet.m
//  Zombie
//
//  Created by 周巍昆 on 17/10/29.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "Bullet.h"
#import "Gun.h"

# define BULLET_DEBUG

@implementation Bullet

- (id)initWithState:(NSString *)state FromMe:(Me *)me{
#ifdef BULLET_DEBUG
    NSLog(@"Bullet类方法：\n initWithState:FomrMe:初始化一颗子弹");
#endif
    self = [super init];
    CGPoint location = me.imageView.center;
    if([state isEqualToString:@"default"]){
        _imageView = [[UIImageView  alloc]initWithFrame:CGRectMake(location.x, location.y, 15, 2)];
        _imageView.image = [UIImage imageNamed:@"default"];
    }
    else if([state isEqualToString:@"highFrequency"]){
        _imageView = [[UIImageView  alloc]initWithFrame:CGRectMake(location.x, location.y, 15, 2)];
        _imageView.image = [UIImage imageNamed:@"default"];
    }
    else if([state isEqualToString:@"strongForce"]){
        _imageView = [[UIImageView  alloc]initWithFrame:CGRectMake(location.x, location.y, 18, 20)];
        _imageView.image = [UIImage imageNamed:@"strongForce"];
    }
    //_force = [Gun sharedGun].bulletforce;
    _imageView.contentMode = UIViewContentModeScaleToFill;
    
    //设置图片射出后的偏转角，位置
    _angle = me.angle;
    CGAffineTransform transfrom = CGAffineTransformMakeRotation(me.angle);
    _imageView.transform = transfrom;
    
    CGPoint point = _imageView.center;
    point.x += 15 *cos(me.angle);
    point.y += 15 *sin(me.angle);
    _imageView.center = point;
    
    return self;
}//初始化后在mainView中将其添加到view


@end
