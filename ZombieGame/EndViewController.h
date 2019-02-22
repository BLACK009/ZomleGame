//
//  EndViewController.h
//  ZombieGame
//
//  Created by 周巍昆 on 17/11/16.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EndViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *bigZombie;
@property (strong, nonatomic) IBOutlet UILabel *littleZombie;
@property (strong, nonatomic) IBOutlet UILabel *soldier;
@property (strong, nonatomic) IBOutlet UILabel *attack;
@property (strong, nonatomic) IBOutlet UILabel *defaultBullet;
@property (strong, nonatomic) IBOutlet UILabel *lastScorce;

@property (strong, nonatomic) IBOutlet UILabel *otherBullet;

- (IBAction)replay:(id)sender;
- (IBAction)quit:(id)sender;
@end
