//
//  me.m
//  Zombie
//
//  Created by 周巍昆 on 17/10/29.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "Me.h"

@implementation Me

+ (instancetype)publicMe{
    static Me *me =nil;
    return me;
}

-(instancetype)initWithLocation:(CGPoint )location Image:(UIImage *)image{
    self = [super init];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(location.x, location.y, 28, 15)];
    self.imageView.image = image;
    self.life = 1;
    self.step = 1.45;
    self.stepFrequency = 40;
    
    return self;
}

@end

