//
//  ZJFactoryMethod.h
//  TurntableDemo
//
//  Created by jie on 2017/11/15.
//  Copyright © 2017年 jie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJFactoryMethod : NSObject


+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert alpha:(CGFloat)alpha;

#pragma mark 计算圆圈上点在IOS系统中的坐标
+(CGPoint) calcCircleCoordinateWithCenter:(CGPoint) center  andWithAngle : (CGFloat) angle andWithRadius: (CGFloat) radius;

@end
