//
//  AddedView.h
//  ZombieGame
//
//  Created by 周巍昆 on 17/11/20.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddedView : UIView

@property (nonatomic,strong) NSMutableArray *labels;
//
//@property (nonatomic)int greenZombie;
//@property (nonatomic)int whiteZombie;
//@property (nonatomic)int soldier;

@property (nonatomic,strong) UILabel *tip;

+ (instancetype)addedView;
- (void)reSet;
@end
