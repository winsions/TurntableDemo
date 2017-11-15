//
//  CircleBigView.h
//  TurntableDemo
//
//  Created by jie on 2017/11/15.
//  Copyright © 2017年 jie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleViewModel.h"

@interface CircleBigView : UIButton

+(CircleBigView *)createBigCircleView;

-(void)configUI:(CircleViewModel *)model;

@end
