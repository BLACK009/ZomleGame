//
//  BeginViewController.h
//  ZombieGame
//
//  Created by 周巍昆 on 17/11/16.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface BeginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIButton *botton;
@property (strong,nonatomic) CADisplayLink *changeColorLink;

@property (strong,nonatomic) MainViewController *mainVC;

-(IBAction)play:(id)sender;


//- (IBAction)pushMainView:(id)sender;

@end
