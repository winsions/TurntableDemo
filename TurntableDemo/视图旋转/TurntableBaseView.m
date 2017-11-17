//
//  TurntableBaseView.m
//  TurntableDemo
//
//  Created by jie on 2017/11/15.
//  Copyright © 2017年 jie. All rights reserved.
//

#import "TurntableBaseView.h"
#import "ZJTimersManger.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define CircleRadius 100
#define CircleDiam (2*CircleRadius)
#define MoveCircleRadius 30

#define screenW self.view.bounds.size.width
#define RADIAN_TO_DEGREE(__ANGLE__) ((__ANGLE__) * 180/M_PI)
#define DEGREE_TO_RADIAN(__ANGLE__) ((__ANGLE__) * M_PI/180.0)

@interface TurntableBaseView()

@property (nonatomic)BOOL isStartTurntable;
@property (nonatomic,assign) float angle;
@property (nonatomic,assign) BOOL updateEnable;
@property (nonatomic,strong) NSString *taskMark;

@end

@implementation TurntableBaseView

-(void)startUpTurntableFunction{
    if (self.isStartTurntable) {
        return;
    }
    self.isStartTurntable = YES;
    [self initPara];
}

-(void)initPara{
    WEAKSELF;
    _updateEnable = NO;
    _angle = 0;
    self.taskMark = [ZJTimerTaskModel createTimerTaskWithTaskBlock:^{
        [weakSelf updateMyAngle];
    } andRateTime:1.0/60 andAllTimes:-1];
}

- (void)updateMyAngle
{
    if(_updateEnable)
    {
        if(fabs(_angle)>1)
        {
            [self setRotate:_angle];
            _angle = 0.95 * _angle;
        }
        else
        {
            _angle = 0;
        }
    }
}

- (void)setRotate:(CGFloat)degress
{
    CGFloat rotate = DEGREE_TO_RADIAN(degress);
    CGAffineTransform transform = self.transform;
    transform = CGAffineTransformRotate(transform, rotate);
    self.transform = transform;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isStartTurntable) {
        _updateEnable = NO;
        _angle = 0;
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isStartTurntable) {
        UITouch *touch = [touches anyObject];
        //1.捕捉起始点
        //2.算出相对与转盘中点的坐标
        //3.点（也就是坐标）转换成弧度
        //4.弧度转换成角度
        CGPoint previousLocation = [touch previousLocationInView:touch.view];
        CGPoint previousPoint = [self relativePoint:previousLocation and:self.center];
        CGFloat previousVector = [self toAngle:previousPoint];
        CGFloat previousDrgress = RADIAN_TO_DEGREE(previousVector);
        //捕捉终点
        CGPoint nowLocation = [touch locationInView:touch.view];
        CGPoint nowPoint = [self relativePoint:nowLocation and:self.center];
        CGFloat nowVector = [self toAngle:nowPoint];
        CGFloat nowDrgress = RADIAN_TO_DEGREE(nowVector);
        
        //得出相对角度
        _angle = -(nowDrgress - previousDrgress);
        NSLog(@"angle = %f",_angle);
        [self setRotate:_angle];
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isStartTurntable) {
        _updateEnable = YES;
    }
}

- (CGPoint)relativePoint:(CGPoint)point1 and:(CGPoint)point2
{
    CGPoint point;
    point.x = point1.x - point2.x;
    point.y = point1.y - point2.y;
    
    return point;
}

- (float)toAngle:(CGPoint)point
{
    //以弧度为单位计算并返回点 y/x 的角度值
    //该角度从圆的 x 轴（其中，0,0 表示圆心）沿逆时针方向测量
    return atan2f(point.x, point.y);
}

-(void)stopTurntableFunction{
    [[ZJTimersManger manger]removeTimerTaskWithMark:self.taskMark];
}

-(void)dealloc{
    [[ZJTimersManger manger]removeTimerTaskWithMark:self.taskMark];
}


@end
