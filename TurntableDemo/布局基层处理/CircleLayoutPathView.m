//
//  CircleLayoutPathView.m
//  TurntableDemo
//
//  Created by jie on 2017/11/16.
//  Copyright © 2017年 jie. All rights reserved.
//

#import "CircleLayoutPathView.h"

@interface CircleLayoutPathView()

@property (nonatomic)CGPoint previousPoint;
@property (nonatomic,assign) float angle;
@property (nonatomic,assign) BOOL updateEnable;
@property (nonatomic,strong) NSString *taskMark;

@end


@implementation CircleLayoutPathView

+(CircleLayoutPathView *)createLayoutPathWithData:(CircleViewManger *)viewManger{
    
    CircleLayoutPathView *baseView = [[CircleLayoutPathView alloc]initWithFrame:CGRectMake(0,HEIGHT / 2.0 - WIDTH/2.0, WIDTH, WIDTH)];
    baseView.viewManger = viewManger;
    [baseView addGesTurn];
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

-(void)addGesTurn{
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handlePan:)];
    [self addGestureRecognizer:panGestureRecognizer];
}

- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    
    if (recognizer.state == UIGestureRecognizerStateBegan ) {
        CGPoint translation = [recognizer translationInView:self];
        self.previousPoint = translation;
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        //4.弧度转换成角度
        CGPoint previousLocation = self.previousPoint;
        CGPoint previousPoint = [self relativePoint:previousLocation and:self.center];
        CGFloat previousVector = [self toAngle:previousPoint];
        CGFloat previousDrgress = RADIAN_TO_DEGREE(previousVector);
        //捕捉终点
        CGPoint nowLocation = [recognizer translationInView:self];
        CGPoint nowPoint = [self relativePoint:nowLocation and:self.center];
        CGFloat nowVector = [self toAngle:nowPoint];
        CGFloat nowDrgress = RADIAN_TO_DEGREE(nowVector);
        //得出相对角度
        _angle = -(nowDrgress - previousDrgress);
        [self setRotate:_angle];
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


- (void)setRotate:(CGFloat)degress
{
    CGFloat rotate = DEGREE_TO_RADIAN(degress);
    CGAffineTransform transform = self.transform;
    transform = CGAffineTransformRotate(transform, rotate);
    self.transform = transform;
    
    NSMutableArray *viewDataArray = [self.viewManger getViewData];
    for (int i = 0; i<viewDataArray.count; i++) {
        CircleSmallView *smallView = viewDataArray[i];
        CGAffineTransform circleTransform = smallView.transform;
        transform = CGAffineTransformRotate(circleTransform, -rotate);
        smallView.transform = transform;
    }
}

@end
