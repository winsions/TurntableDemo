//
//  CircleBigView.m
//  TurntableDemo
//
//  Created by jie on 2017/11/15.
//  Copyright © 2017年 jie. All rights reserved.
//

#import "CircleBigView.h"

@implementation CircleBigView

+(CircleBigView *)createBigCircleView{
    
    CircleBigView *bigView = [[CircleBigView alloc]initWithFrame:CGRectMake(0, 0,2*CircleOptionBigRadius,2*CircleOptionBigRadius)];
    bigView.layer.masksToBounds = YES;
    bigView.layer.cornerRadius = CircleOptionBigRadius;
    return bigView;
    
}

-(void)configUI:(CircleViewModel *)model{
    
    [self setTitle:model.labelTip forState:UIControlStateNormal];
    [self setBackgroundColor:[ZJFactoryMethod colorWithHexString:model.baseViewColor]];
    [self setTintColor:[ZJFactoryMethod colorWithHexString:model.fontColor]];
    
}

@end
