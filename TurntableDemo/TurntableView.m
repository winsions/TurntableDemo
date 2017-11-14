//
//  TurntableView.m
//  TurntableDemo
//
//  Created by jie on 2017/11/13.
//  Copyright © 2017年 jie. All rights reserved.
//

#import "TurntableView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define CircleRadius 100
#define CircleDiam (2*CircleRadius)
#define MoveCircleRadius 30

#define screenW self.view.bounds.size.width
#define RADIAN_TO_DEGREE(__ANGLE__) ((__ANGLE__) * 180/M_PI)
#define DEGREE_TO_RADIAN(__ANGLE__) ((__ANGLE__) * M_PI/180.0)

typedef NS_ENUM(NSInteger,ViewLocation){
    LeftLocation = 0,
    UpLocation,
    RightLocation,
    DownLocation
};

@interface TurntableView ()

@property (nonatomic,assign) float angle;
@property (nonatomic,strong) NSTimer * timer;
@property (nonatomic,assign) BOOL updateEnable;
@property (nonatomic,strong)UIView *transparentView;

@end

@implementation TurntableView

+(TurntableView *)createTurnableView{
    
    //最底层
    TurntableView *turnView = [[TurntableView alloc]initWithFrame:CGRectMake(0, (HEIGHT - WIDTH)/2.0, WIDTH,WIDTH)];
    turnView.backgroundColor = [UIColor whiteColor];
   
    //第二层 旋转层
    UIView *transparentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,turnView.bounds.size.width,turnView.bounds.size.height)];
    transparentView.alpha = 1;
    transparentView.backgroundColor = [UIColor whiteColor];
    [turnView addSubview:transparentView];
    turnView.transparentView = transparentView;
    
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
    [turnView initPara];
    return turnView;
}

+(UIView *)createCircleView:(NSInteger)location{
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
    
    UIView *moveCircleView = [[UIView alloc]initWithFrame:locationRect];
    moveCircleView.backgroundColor = [UIColor redColor];
    moveCircleView.layer.masksToBounds = YES;
    moveCircleView.layer.cornerRadius = MoveCircleRadius;
    return moveCircleView;
}

-(void)initPara{
    _updateEnable = NO;
    _angle = 0;
    
    //将NSTimer添加到NSRunloop
    NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
    _timer =[ NSTimer timerWithTimeInterval:1.0f/60 target:self selector:@selector(updateMyAngle) userInfo:nil repeats:YES];
    [runLoop addTimer:_timer forMode:NSDefaultRunLoopMode];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _updateEnable = NO;
    _angle = 0;
}


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    
    //1.捕捉起始点
    //2.算出相对与转盘中点的坐标
    //3.点（也就是坐标）转换成弧度
    //4.弧度转换成角度
    CGPoint previousLocation = [touch previousLocationInView:touch.view];
    CGPoint previousPoint = [self relativePoint:previousLocation and:_transparentView.center];
    CGFloat previousVector = [self toAngle:previousPoint];
    CGFloat previousDrgress = RADIAN_TO_DEGREE(previousVector);
    
    //捕捉终点
    CGPoint nowLocation = [touch locationInView:touch.view];
    CGPoint nowPoint = [self relativePoint:nowLocation and:_transparentView.center];
    CGFloat nowVector = [self toAngle:nowPoint];
    CGFloat nowDrgress = RADIAN_TO_DEGREE(nowVector);
    
    //得出相对角度
    _angle = -(nowDrgress - previousDrgress);
    NSLog(@"angle = %f",_angle);
    [self setRotate:_angle];
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _updateEnable = YES;
}

- (void)setRotate:(CGFloat)degress
{
    CGFloat rotate = DEGREE_TO_RADIAN(degress);
    
    CGAffineTransform transform = _transparentView.transform;
    transform = CGAffineTransformRotate(transform, rotate);
    _transparentView.transform = transform;
    
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

@end
