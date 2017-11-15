//
//  CircleSmallView.m
//  TurntableDemo
//
//  Created by jie on 2017/11/15.
//  Copyright © 2017年 jie. All rights reserved.
//

#import "CircleSmallView.h"

@interface CircleSmallView()

@end

@implementation CircleSmallView

+(CircleSmallView *)createSmallCircleView{
    CircleSmallView *smallView = [[CircleSmallView alloc]initWithFrame:CGRectMake(0, 0,2*CircleOptionSmallRadius,2*CircleOptionSmallRadius)];
    smallView.layer.masksToBounds = YES;
    smallView.layer.cornerRadius = CircleOptionSmallRadius;
    return smallView;
}

-(void)configUI:(CircleViewModel *)model{
    [self setTitle:model.labelTip forState:UIControlStateNormal];
    [self setBackgroundColor:[ZJFactoryMethod colorWithHexString:model.baseViewColor]];
    [self setTintColor:[ZJFactoryMethod colorWithHexString:model.fontColor]];
}

@end
