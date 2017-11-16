//
//  CircleLayoutPathView.m
//  TurntableDemo
//
//  Created by jie on 2017/11/16.
//  Copyright © 2017年 jie. All rights reserved.
//

#import "CircleLayoutPathView.h"

@implementation CircleLayoutPathView

+(CircleLayoutPathView *)createLayoutPathWithData:(CircleViewManger *)viewManger{
    
    CircleLayoutPathView *baseView = [[CircleLayoutPathView alloc]initWithFrame:CGRectMake(0,HEIGHT / 2.0 - WIDTH/2.0, WIDTH, WIDTH)];
    baseView.viewManger = viewManger;
    [baseView startUpTurntableFunction];
    baseView.backgroundColor = [UIColor whiteColor];
    CGFloat diameter = WIDTH - CirclePageMargin * 2 - CircleOptionSmallRadius * 2;
    UIView *pathView = [[UIView alloc]initWithFrame:CGRectMake((WIDTH - diameter)/2.0,(WIDTH - diameter)/2.0, diameter, diameter)];
    pathView.backgroundColor = [UIColor whiteColor];
    pathView.layer.masksToBounds = YES;
    pathView.layer.cornerRadius = diameter/2.0;
    pathView.layer.borderColor = [UIColor blackColor].CGColor;
    pathView.layer.borderWidth = 1;
    [baseView addSubview:pathView];
    [baseView addOptionCircle];
    return baseView;
}


-(void)addOptionCircle{
    NSMutableArray *viewDataArray = [self.viewManger getViewData];
    for (int i = 0; i<viewDataArray.count; i++) {
        CircleSmallView *smallView = viewDataArray[i];
        [self addSubview:smallView];
    }
}

@end
