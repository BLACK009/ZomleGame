//
//  AddedView.m
//  ZombieGame
//
//  Created by 周巍昆 on 17/11/20.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "AddedView.h"
#import "MainView.h"

@implementation AddedView



+ (instancetype)addedView{
    static AddedView *view = nil;
    if (!view) {
        view = [[self alloc]initPrivate];
    }
    return view;
}


- (instancetype)initPrivate{
    self = [super init];
    if (self){
        _labels = [[NSMutableArray alloc]init];
        for (float i = 0 ; i < 5 ;i++){
            CGRect rect = CGRectMake(i / 5 * [UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width / 5, 35);
            UILabel *label = [[UILabel alloc]initWithFrame:rect];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            [self.labels addObject:label];
        }
        UILabel *label;
        label = _labels[0];
        label.text = [NSString stringWithFormat:@"Left Bullet:0"];
        label = _labels[1];
        label.text = [NSString stringWithFormat:@"Attack:0th"];
        label = _labels[2];
        label.text = [NSString stringWithFormat:@"GreenZombie:0"];
        label = _labels[3];
        label.text = [NSString stringWithFormat:@"WhiteZombie:0"];
        label = _labels[4];
        label.text = [NSString stringWithFormat:@"Soldier:0"];
        for (UILabel *label in _labels)
            [self addSubview:label];
        
        CGSize size = [UIScreen mainScreen].bounds.size;
        _tip = [[UILabel alloc]initWithFrame:CGRectMake(0, size.height, size.width, 100)];
        _tip.textAlignment = NSTextAlignmentCenter;
        _tip.textColor = [UIColor whiteColor];
    
        [self addSubview:_tip];
        
    }

    return self;
}

- (void)reSet{
    UILabel *label;
    label = _labels[0];
    label.text = [NSString stringWithFormat:@"Left Bullet:0"];
    label = _labels[1];
    label.text = [NSString stringWithFormat:@"Attack:0th"];
    label = _labels[2];
    label.text = [NSString stringWithFormat:@"GreenZombie:0"];
    label = _labels[3];
    label.text = [NSString stringWithFormat:@"WhiteZombie:0"];
    label = _labels[4];
    label.text = [NSString stringWithFormat:@"Soldier:0"];


}


@end
