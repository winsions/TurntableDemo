//
//  TurntableView.h
//  TurntableDemo
//
//  Created by jie on 2017/11/13.
//  Copyright © 2017年 jie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TurntableView : UIView

@property (nonatomic,assign) float angle;
@property (nonatomic,strong) NSTimer * timer;
@property (nonatomic,assign) BOOL updateEnable;
@property (nonatomic,strong)UIView *transparentView;


+(TurntableView *)createTurnableView;

@end
