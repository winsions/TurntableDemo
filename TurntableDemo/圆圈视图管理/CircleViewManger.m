//
//  CircleViewManger.m
//  TurntableDemo
//
//  Created by jie on 2017/11/15.
//  Copyright © 2017年 jie. All rights reserved.
//

#import "CircleViewManger.h"
#import "CircleSmallView.h"
#import "CircleBigView.h"

@interface CircleViewManger ()

@property (nonatomic ,strong)NSMutableArray *viewDataArray;
@property (nonatomic ,strong)NSMutableArray *modelDataArray;

@end


@implementation CircleViewManger

+(CircleViewManger *)mangerWithData:(NSMutableArray <CircleViewModel*> *)dataArray{
    
    CircleViewManger *manger = [[CircleViewManger alloc]init];
    manger.modelDataArray = dataArray;
    [manger createViewData];
    return manger;
}


-(NSMutableArray *)viewDataArray{
    if (!_viewDataArray) {
        _viewDataArray = [NSMutableArray array];
    }
    return _viewDataArray;
}


-(void)createViewData{
    
    for (int i = 0; i < self.modelDataArray.count; i++) {
        CircleViewModel *model = self.modelDataArray[i];
        CircleSmallView *smallView = [CircleSmallView createSmallCircleView];
        [smallView configUI:model];
        [self.viewDataArray addObject:smallView];
    }
}

-(void)setUILayoutWithType:(NSInteger)layoutType{
    switch (layoutType) {
        case UICircleLayout:{
            [self circleUILayout];
        }
            break;
        default:
            break;
    }
}


/**
 圆形布局(全部相当于整个屏幕)
 */
-(void)circleUILayout{
    for (int i =0; i < self.viewDataArray.count; i++) {
        CGFloat diameter = WIDTH - CirclePageMargin * 2 - CircleOptionSmallRadius * 2;
        CGPoint centerPoint = CGPointMake(WIDTH/2.0, WIDTH/2.0);
        CGFloat unitAngle = 360.0 / self.viewDataArray.count;
        CGPoint viewPoint = [ZJFactoryMethod calcCircleCoordinateWithCenter:centerPoint andWithAngle:unitAngle * (i+1) andWithRadius:diameter / 2.0];
        CircleSmallView *circleView = self.viewDataArray[i];
        circleView.mj_x = viewPoint.x - CircleOptionSmallRadius;
        circleView.mj_y = viewPoint.y - CircleOptionSmallRadius;
    }
}


-(NSMutableArray *)getViewData{
    
    return self.viewDataArray;
}


@end
