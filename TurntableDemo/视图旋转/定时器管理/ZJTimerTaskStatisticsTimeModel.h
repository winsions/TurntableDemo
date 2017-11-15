//
//  ZJTimerTaskStatisticsTimeModel.h
//  PaoTui
//
//  Created by jie on 2017/7/21.
//  Copyright © 2017年 UU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJTimerTaskStatisticsTimeModel : NSObject

@property(nonatomic,copy)NSString *mark;
@property(nonatomic)NSInteger rateTime;//频率(多长时间执行一次)
@property(nonatomic)NSUInteger recordTime;//时间记录
@property(nonatomic)NSInteger allTimes;//需要执行多少次
@property(nonatomic)NSInteger alreadyExecuteTimes;//已经执行次数

@end
