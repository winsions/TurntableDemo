//
//  ZJTimerTaskModel.h
//  PaoTui
//
//  Created by jie on 2017/7/18.
//  Copyright © 2017年 UU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJBaseModel.h"

typedef void(^TimerTaskDealBlock)(void);
@interface ZJTimerTaskModel : ZJBaseModel

@property(nonatomic,copy)NSString *mark;
@property(nonatomic,strong)TimerTaskDealBlock taskBlock;

/**
 创建定时器需要执行的任务
 
 @param taskBlock 任务内容（里面必须是若指针）
 @param rateTime 多长时间执行一次
 @param allTimes 需要执行多少次
 @return 任务的唯一区分标示
 */
+(NSString*)createTimerTaskWithTaskBlock:(TimerTaskDealBlock)taskBlock andRateTime:(NSInteger)rateTime andAllTimes:(NSInteger)allTimes;

@end
