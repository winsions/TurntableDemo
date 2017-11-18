//
//  ZJTimersManger.m
//  PaoTui
//
//  Created by jie on 2017/7/18.
//  Copyright © 2017年 UU. All rights reserved.
//

#import "ZJTimersManger.h"

@interface ZJTimersManger()
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic)BOOL isStart;//是否开始轮循
@property (nonatomic,strong)NSMutableArray *taskContainer;
@property (nonatomic,strong)NSMutableArray *statisticsTimeContainer;
@end

@implementation ZJTimersManger

/**
 获取定时器管理单例
 
 @return 定时器管理单例
 */
+ (instancetype)manger{
    static ZJTimersManger *m = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        m = [[self alloc] init];
        m.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/60 target:m selector:@selector(timerMainResponse) userInfo:nil repeats:YES];
        [m.timer setFireDate:[NSDate distantFuture]];
        m.isStart = NO;
        m.taskContainer = [NSMutableArray array];
        m.statisticsTimeContainer = [NSMutableArray array];
    });
    return m;
}


/**
 定时器主响应方法
 */
-(void)timerMainResponse{
    if (self.taskContainer.count == 0 || self.statisticsTimeContainer.count == 0) {
        //暂时关闭定时器
        self.isStart = NO;
        [self.timer setFireDate:[NSDate distantFuture]];
        DLog(@"定时器关闭");
    }else{
        [self dealTimerTask];
    }
}


/**
 处理定时器任务
 */
-(void)dealTimerTask{
    for (int index = 0; index < self.taskContainer.count; index++) {
        ZJTimerTaskModel *taskModel = [self.taskContainer objectAtIndex:index];
        ZJTimerTaskStatisticsTimeModel *statisticsModel = [self.statisticsTimeContainer objectAtIndex:index];
        statisticsModel.recordTime++;
        statisticsModel.alreadyExecuteTimes = (statisticsModel.recordTime/statisticsModel.rateTime);
        taskModel.taskBlock();
    }
}


/**
 添加任务

 @param taskModel 任务model
 @param statisticsTimeModel 任务时间model
 */
-(void)addTimerTaskWithTaskmodel:(ZJTimerTaskModel*)taskModel andStatisticsModel:(ZJTimerTaskStatisticsTimeModel*)statisticsTimeModel{
    [self.statisticsTimeContainer addObject:statisticsTimeModel];
    [self.taskContainer addObject:taskModel];
    if (self.isStart) {
        DLog(@"正在轮训中");
    }else{
        DLog(@"没有开启轮训,现在开启");
        self.isStart = YES;
        [self.timer setFireDate:[NSDate distantPast]];
    }
}


/**
 删除任务
 
 @param mark 任务标示
 */
-(void)removeTimerTaskWithMark:(NSString*)mark{
    NSMutableArray *completeTastArray = [NSMutableArray array];
    NSMutableArray *completeStatisticsArray = [NSMutableArray array];
    for (int index = 0; index < self.taskContainer.count; index++) {
        ZJTimerTaskModel *taskModel = [self.taskContainer objectAtIndex:index];
        ZJTimerTaskStatisticsTimeModel *statisticsModel = [self.statisticsTimeContainer objectAtIndex:index];
        if ([taskModel.mark isEqualToString:mark]) {
            [completeTastArray addObject:taskModel];
        }
        if ([statisticsModel.mark isEqualToString:mark]) {
            [completeStatisticsArray addObject:statisticsModel];
        }
    }
    [self removeTimerTaskWithTaskarray:completeTastArray andStatisticsarray:completeStatisticsArray];
}


/**
 获取和任务相关信息
 
 @param mark 区别任务的唯一标示
 @return 任务信息model
 */
-(ZJTaskTimeInfoModel*)getTaskTimeInfoWithMark:(NSString*)mark{
    for (ZJTimerTaskStatisticsTimeModel *model in self.statisticsTimeContainer) {
        if ([model.mark isEqualToString:mark]) {
            ZJTaskTimeInfoModel *infoModel = [[ZJTaskTimeInfoModel alloc]init];
            infoModel.recordTime = model.recordTime;
            infoModel.allTimes = model.allTimes;
            infoModel.alreadyExecuteTimes = model.alreadyExecuteTimes;
            return infoModel;
        }
    }
    return nil;
}


-(void)removeTimerTaskWithTaskarray:(NSArray*)taskArray andStatisticsarray:(NSArray*)statisticsArray{
    for (int index = 0; index < taskArray.count; index++) {
        ZJTimerTaskModel *taskModel = taskArray[index];
        ZJTimerTaskStatisticsTimeModel *sModel = statisticsArray[index];
        [self.taskContainer removeObject:taskModel];
        [self.statisticsTimeContainer removeObject:sModel];
    }
}

@end
