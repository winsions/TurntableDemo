//
//  CircleLayoutPathView.h
//  TurntableDemo
//
//  Created by jie on 2017/11/16.
//  Copyright © 2017年 jie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleSmallView.h"
#import "CircleViewManger.h"

@interface CircleLayoutPathView : TurntableBaseView

@property (nonatomic,strong)CircleViewManger *viewManger;

+(CircleLayoutPathView *)createLayoutPathWithData:(CircleViewManger *)viewManger;


@end
