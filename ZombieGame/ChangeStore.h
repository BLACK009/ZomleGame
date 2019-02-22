//
//  ChangeStore.h
//  ZombieGame
//
//  Created by 周巍昆 on 17/11/21.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Change.h"

@interface ChangeStore : NSObject

@property (nonatomic,strong) NSMutableDictionary *changes;

@property (nonatomic) int counter;

+ (instancetype)sharedChangeStore;

- (void)setCounterWithView:(UIView*)view;

- (void)reset;

@end
