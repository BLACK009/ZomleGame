//
//  ChangeStore.m
//  ZombieGame
//
//  Created by 周巍昆 on 17/11/21.
//  Copyright © 2017年 Big Nerd Ranch. All rights reserved.
//

#import "ChangeStore.h"

@implementation ChangeStore


+ (instancetype)sharedChangeStore{
    static ChangeStore *store = nil;
    if (!store) {
        store = [[self alloc]initPrivate];
    }
    return store;
}

- (instancetype)initPrivate{
    self = [super init];
    if(self){
        _counter = 0;
        _changes = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)setCounterWithView:(UIView*)view{
    if (++self.counter == 5){
        self.counter = 0;
        
        //产生一个change
        Change *change = [[Change alloc]initWithView:view];
        [self.changes setObject:change forKey:change.serial];
        
        //管理一个change
        [change controlAChange];
    };
}


- (void)reset{
    [self.changes removeAllObjects];
    self.counter = 0;
}

@end
