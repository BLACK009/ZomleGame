//
//  MainViewController.m
//  ZombieGame
//
//  Created by 周巍昆 on 17/11/16.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    NSLog(@"MainViewController:  viewDidLoad");
   }

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view performSelector:@selector(viewDisapper)];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    MainView *view = [[MainView alloc]init];
//   self.view = view;
    static int i = 0;
    if (!i){
        self.view = [MainView sharedMainView];
    }
    else
        self.view = [[MainView sharedMainView]init];
//    NSLog(@"MainViewController:  viewWilAppear");
    i++;
}


@end
