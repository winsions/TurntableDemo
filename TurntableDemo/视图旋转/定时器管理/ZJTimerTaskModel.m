//
//  ZJTimerTaskModel.m
//  PaoTui
//
//  Created by jie on 2017/7/18.
//  Copyright © 2017年 UU. All rights reserved.
//

#import "ZJTimerTaskModel.h"
#import "ZJTimersManger.h"
#import "ZJTimerTaskStatisticsTimeModel.h"

@implementation ZJTimerTaskModel

/**
 创建定时器需要执行的任务
 
 @param taskBlock 任务内容（里面必须是若指针）
 @param rateTime 多长时间执行一次
 @param allTimes 需要执行多少次
 @return 任务的唯一区分标示
 */
+(NSString*)createTimerTaskWithTaskBlock:(TimerTaskDealBlock)taskBlock andRateTime:(NSInteger)rateTime andAllTimes:(NSInteger)allTimes{
    NSString *uniqueMark = @([NSDate date].timeIntervalSince1970).stringValue;
    ZJTimerTaskModel *taskModel = [[ZJTimerTaskModel alloc]init];
    taskModel.mark = uniqueMark;
    taskModel.taskBlock = taskBlock;
    
    ZJTimerTaskStatisticsTimeModel *statisticsTimeModel = [[ZJTimerTaskStatisticsTimeModel alloc]init];
    statisticsTimeModel.mark = uniqueMark;
    statisticsTimeModel.recordTime = 0;
    statisticsTimeModel.rateTime = rateTime;
    statisticsTimeModel.allTimes = allTimes;
    
    [[ZJTimersManger manger]addTimerTaskWithTaskmodel:taskModel andStatisticsModel:statisticsTimeModel];
    return uniqueMark;
}

@end
