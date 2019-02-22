//
//  mainView.h
//  Zombie
//
//  Created by 周巍昆 on 17/10/21.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GunController.h"


#define ZOMBIE_DEBUG
#define BULLET_DEBUG

@interface MainView : UIView
//控制
@property (nonatomic,strong)UIImageView *moveCircle;
@property (nonatomic,strong)UIImageView *moveCircleSide;
@property (nonatomic,strong)UIImageView *trendCircle;
@property (nonatomic,strong)UIImageView *trendCircleSide;

@property (nonatomic,strong)CADisplayLink *moveLink;
@property (nonatomic)BOOL moved;
@property (nonatomic,strong)CADisplayLink *trendLink;

@property (nonatomic)double moveAngle;
@property (nonatomic)double trendAngle;

@property (nonatomic)BOOL moveBegan;
@property (nonatomic)BOOL trendBegan;

@property (nonatomic,strong)Me *me;
@property (nonatomic,strong)Zombies *zombies;
@property (nonatomic,strong)Gun *gun;

+ (instancetype)sharedMainView;
- (instancetype)initPrivate;
- (void)viewDisapper;

@end
