//
//  Change.h
//  ZombieGame
//
//  Created by 周巍昆 on 17/11/21.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Change : NSObject

@property (nonatomic,strong)UIImageView *image;

@property (nonatomic,strong)NSString *name;

@property (nonatomic,strong)NSNumber *serial;

@property (nonatomic,strong)CADisplayLink *link;

@property (nonatomic)NSUInteger beginTime;

- (instancetype)initWithView:(UIView*)view;

- (void)controlAChange;

- (void)removeChange;

@end
