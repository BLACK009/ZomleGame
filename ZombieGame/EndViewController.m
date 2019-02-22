//
//  EndViewController.m
//  ZombieGame
//
//  Created by 周巍昆 on 17/11/16.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "EndViewController.h"
#import "Scorer.h"


@interface EndViewController ()

@end

@implementation EndViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//- (instancetype)init{
//    
//    return self;
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    Scorer * score = [Scorer sharedScorer];
    
    NSString *string1 = [[NSString alloc]initWithFormat:@"the GreenZombie you perished：%d  ✕ 20",score.bigZombie];
    self.bigZombie.text = string1;
    
    NSString *string2 = [[NSString alloc]initWithFormat:@"the WhiteZombie you perished：%d  ✕ 7", score.littleZombie];
    self.littleZombie.text = string2;
    
    NSString *string3 = [[NSString alloc]initWithFormat:@"the LittleSoldire you perished：%d  ✕ 3",
                         score.soldier];
    self.soldier.text = string3;
    
    NSString *string4 = [[NSString alloc]initWithFormat:@"the attack you defended：%d ✕ 30",score.attack ];
    self.attack.text = string4;
    
    NSString *string5 = [[NSString alloc]initWithFormat:@"the bullet you left：%d ✕ 1",score.defaultBullet];
    self.defaultBullet.text = string5;
    
    NSString *string6 = [[NSString alloc]initWithFormat:@"YOUR SCORCE: %d",score.lastScorce];
    self.lastScorce.text = string6;
    
    
    UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundView.contentMode = UIViewContentModeScaleToFill;
    backgroundView.image = [UIImage imageNamed:@"beginBackground"];
    [self.view addSubview: backgroundView];
    [self.view sendSubviewToBack:backgroundView];
}

- (IBAction)replay:(id)sender{
    [[Scorer sharedScorer]reSet];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)quit:(id)sender{
    exit(0);
}

@end
