//
//  MainViewController.h
//  ZombieGame
//
//  Created by 周巍昆 on 17/11/16.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EndViewController.h"

@interface MainViewController : UIViewController

@property(nonatomic,strong) EndViewController *endVC;

@property (nonatomic,strong)IBOutlet UILabel *label1;
@property (nonatomic,strong)IBOutlet UILabel *label2;
@property (nonatomic,strong)IBOutlet UILabel *label3;
@property (nonatomic,strong)IBOutlet UILabel *label4;
@property (nonatomic,strong)IBOutlet UILabel *label5;

@property (nonatomic,strong)NSArray *labels;

@end
