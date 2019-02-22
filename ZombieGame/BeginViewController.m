//
//  BeginViewController.m
//  ZombieGame
//
//  Created by 周巍昆 on 17/11/16.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "BeginViewController.h"

@interface BeginViewController ()

@end

@implementation BeginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additionalsetup after loading the view from its nib.
    UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    backgroundView.contentMode = UIViewContentModeScaleToFill;
    backgroundView.image = [UIImage imageNamed:@"beginBackground"];
    [self.view addSubview: backgroundView];
    [self.view sendSubviewToBack:backgroundView];
}

- (void)viewWillAppear:(BOOL)animated{
}


- (instancetype)init{
//    UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:self.view.frame];
//    backgroundView.contentMode = UIViewContentModeScaleToFill;
//    backgroundView.image = [UIImage imageNamed:@"beginBackground"];
//    [self.view addSubview: backgroundView];
//    [self.view sendSubviewToBack:backgroundView];
    
//    [self.label setTextColor:[UIColor lightGrayColor]];
//    self.changeColorLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeColor)];
//    self.changeColorLink.preferredFramesPerSecond = 2;
//    [self.changeColorLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//    
    return self;
    
}


- (void)changeColor{
    if(self.botton.titleLabel.textColor == [UIColor whiteColor])
        self.botton.titleLabel.textColor = [UIColor lightGrayColor];
    else
        self.botton.titleLabel.textColor = [UIColor whiteColor];
    NSLog(@"change color");
}


- (IBAction)play:(id)sender{
    self.mainVC = [[MainViewController alloc]init];
    [self.navigationController pushViewController:self.mainVC animated:YES];
}

@end
