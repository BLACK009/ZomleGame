//
//  me.h
//  Zombie
//
//  Created by 周巍昆 on 17/10/29.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Me : NSObject

@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic) int life;
@property (nonatomic) float step;
@property (nonatomic) float stepFrequency;
@property (nonatomic,strong)CADisplayLink *moveLink;

@property (nonatomic) double angle;

+ (instancetype)publicMe;

- (instancetype)initWithLocation:(CGPoint )location Image:(UIImage *)image;

@end
