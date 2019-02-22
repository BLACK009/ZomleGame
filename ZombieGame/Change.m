//
//  Change.m
//  ZombieGame
//
//  Created by 周巍昆 on 17/11/21.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "Change.h"
#import "ChangeStore.h"

@implementation Change

- (instancetype)initWithView:(UIView *)view{
    int x = arc4random() % (int)(view.frame.size.width - 100);
    int y = arc4random() % (int)(view.frame.size.height - 100);
    _image = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, 30, 30)];
    
    _serial = [[NSNumber alloc]initWithUnsignedInteger:time(NULL)];
    
    if (arc4random()%3 == 3){
        _image.image = [UIImage imageNamed:@"red"];
        _name = @"red";
    }
    else{
        _image.image = [UIImage imageNamed:@"black"];
        _name = @"black";
    }
    [view addSubview:_image];
    
    _beginTime = time(NULL);
    _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(controlAChange)];
    
    return self;
}


- (void)controlAChange{
    //开启闪烁循环
    _link.preferredFramesPerSecond = 4;
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    //在10秒后结束
    if (time(NULL) > self.beginTime + 10){
        [self removeChange];
        return ;
    }
    
    //在link有效时间内闪烁
    if (self.image.alpha)
        [UIView animateWithDuration:0.25 animations:^{
            self.image.alpha = 0;
        }];
    else
        [UIView animateWithDuration:0.25 animations:^{
            self.image.alpha = 1;
        }];
}

//清除自己
- (void)removeChange{
    //如果changeStore中还有自己，就清除自己
    if ([[ChangeStore sharedChangeStore].changes objectForKey:self.serial]){
        
        [self.link removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        
        [self.image removeFromSuperview];
        
        [[ChangeStore sharedChangeStore].changes removeObjectForKey:self.serial];
    }
    
}


@end
