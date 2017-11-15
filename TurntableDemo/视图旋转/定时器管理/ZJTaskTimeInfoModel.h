//
//  ZJTaskTimeInfoModel.h
//  PaoTui
//
//  Created by jie on 2017/7/21.
//  Copyright © 2017年 UU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJTaskTimeInfoModel : NSObject

@property (nonatomic)NSInteger recordTime;//开始执行到现在的时间
@property (nonatomic)NSInteger alreadyExecuteTimes;//已经执行了多少次
@property (nonatomic)NSInteger allTimes;

@end
