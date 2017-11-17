//
//  TurntableView.m
//  TurntableDemo
//
//  Created by jie on 2017/11/13.
//  Copyright © 2017年 jie. All rights reserved.
//

#import "TurntableView.h"

typedef NS_ENUM(NSInteger,ViewLocation){
    LeftLocation = 0,
    UpLocation,
    RightLocation,
    DownLocation
};

@interface TurntableView ()

@property (nonatomic,strong)TurntableBaseView *transparentView;

@end

@implementation TurntableView

+(TurntableView *)createTurnableView{
    
    //最底层
    TurntableView *turnView = [[TurntableView alloc]initWithFrame:CGRectMake(0, (HEIGHT - WIDTH)/2.0, WIDTH,WIDTH)];
    turnView.backgroundColor = [UIColor whiteColor];
   
    //第二层 旋转层
    TurntableBaseView *transparentView = [[TurntableBaseView alloc]initWithFrame:CGRectMake(0, 0,turnView.bounds.size.width,turnView.bounds.size.height)];
    transparentView.alpha = 1;
    transparentView.backgroundColor = [UIColor whiteColor];
    [turnView addSubview:transparentView];
    //[transparentView startUpTurntableFunction];
    turnView.transparentView = transparentView;
    UIRotationGestureRecognizer *turnGes = [[UIRotationGestureRecognizer alloc]initWithTarget:turnView action:@selector(turnRote:)];
    [transparentView addGestureRecognizer:turnGes];
    
    //旋转层的东西
    //  圆圈
    UIView *baseCircleView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH / 2.0 - CircleRadius, WIDTH / 2.0 - CircleRadius, CircleDiam,CircleDiam)];
    baseCircleView.backgroundColor = [UIColor whiteColor];
    baseCircleView.layer.masksToBounds = YES;
    baseCircleView.layer.cornerRadius = CircleRadius;
    baseCircleView.layer.borderWidth = 1;
    baseCircleView.layer.borderColor = [UIColor blackColor].CGColor;
    [transparentView addSubview:baseCircleView];
    
    //yuan
    UIView *leftView = [self createCircleView:LeftLocation];
    [transparentView addSubview:leftView];
    
    UIView *upView = [self createCircleView:UpLocation];
    [transparentView addSubview:upView];
    
    UIView *rightView = [self createCircleView:RightLocation];
    [transparentView addSubview:rightView];
    
    UIView *downView = [self createCircleView:DownLocation];
    [transparentView addSubview:downView];
    
    //第五层是中间层 不旋转
    UIView *centerView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH / 2.0 - 20, WIDTH / 2.0 - 20, 40, 40)];
    centerView.backgroundColor = [UIColor greenColor];
    [turnView addSubview:centerView];
    return turnView;
}

//旋转事件

-(void)turnRote:(UIRotationGestureRecognizer *)rote
{
    
    //通过transform 进行旋转变换
    self.transparentView.transform = CGAffineTransformRotate(self.transparentView.transform, rote.rotation);
    //将旋转角度 置为 0
    rote.rotation = 0;
    
}


+(UIButton *)createCircleView:(NSInteger)location{
    CGRect locationRect;
    switch (location) {
        case LeftLocation:
            locationRect = CGRectMake(WIDTH/2.0 - CircleRadius - MoveCircleRadius,WIDTH / 2.0 - MoveCircleRadius, 2 * MoveCircleRadius, 2 * MoveCircleRadius);
            break;
        case UpLocation:
            locationRect = CGRectMake(WIDTH / 2.0 - MoveCircleRadius, WIDTH / 2.0 - CircleRadius - MoveCircleRadius, 2*MoveCircleRadius, 2*MoveCircleRadius);
            break;
        case RightLocation:{
            locationRect = CGRectMake(WIDTH / 2.0 + CircleRadius - MoveCircleRadius, WIDTH / 2.0 - MoveCircleRadius, 2 * MoveCircleRadius, 2 * MoveCircleRadius);
        }
            break;
        case DownLocation:{
            locationRect = CGRectMake(WIDTH / 2.0 - MoveCircleRadius, WIDTH / 2.0 + CircleRadius - MoveCircleRadius, 2*MoveCircleRadius, 2*MoveCircleRadius);
        }
            break;
        default:
            locationRect = CGRectMake(0, 0, 0, 0);
            break;
    }
    
    UIButton *moveCircleView = [[UIButton alloc]initWithFrame:locationRect];
    [moveCircleView addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    moveCircleView.backgroundColor = [UIColor redColor];
    moveCircleView.layer.masksToBounds = YES;
    moveCircleView.layer.cornerRadius = MoveCircleRadius;
    return moveCircleView;
}

+(void)btnClick{
    DLog(@"按钮的响应");
    
}

@end
