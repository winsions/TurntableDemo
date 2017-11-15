//
//  CircleViewManger.h
//  TurntableDemo
//
//  Created by jie on 2017/11/15.
//  Copyright © 2017年 jie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CircleViewModel.h"

typedef  NS_ENUM(NSInteger,UILayoutType){
    UICircleLayout = 0
};

@interface CircleViewManger : NSObject

+(CircleViewManger *)mangerWithData:(NSMutableArray <CircleViewModel*> *)dataArray;

-(void)setUILayoutWithType:(NSInteger)layoutType;

@end
