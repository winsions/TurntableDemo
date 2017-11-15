//
//  ZJTimersManger.h
//  PaoTui
//
//  Created by jie on 2017/7/18.
//  Copyright © 2017年 UU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJTimerTaskModel.h"
#import "ZJTimerTaskStatisticsTimeModel.h"
#import "ZJTaskTimeInfoModel.h"

/***********说在前面的话****************

    使用定时器的控制器，dealloc方法中要根据标示清除任务!!!

***********说在前面的话****************/

@interface ZJTimersManger : NSObject

/**
 获取定时器管理单例

 @return 定时器管理单例
 */
+ (instancetype)manger;


/**
 添加任务
 
 @param taskModel 任务model
 @param statisticsTimeModel 任务统计时间model
 */
-(void)addTimerTaskWithTaskmodel:(ZJTimerTaskModel*)taskModel andStatisticsModel:(ZJTimerTaskStatisticsTimeModel*)statisticsTimeModel;

/**
 删除任务
 
 @param mark 区别任务的唯一标示
 */
-(void)removeTimerTaskWithMark:(NSString*)mark;

/**
 获取和任务相关信息
 
 @param mark 区别任务的唯一标示
 @return 任务信息model
 */
-(ZJTaskTimeInfoModel*)getTaskTimeInfoWithMark:(NSString*)mark;


@end
