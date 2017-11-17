//
//  ViewController.m
//  TurntableDemo
//
//  Created by jie on 2017/11/13.
//  Copyright © 2017年 jie. All rights reserved.
//

#import "ViewController.h"
#import "TurntableView.h"
#import "CircleViewModel.h"
#import "CircleViewManger.h"
#import "CircleLayoutPathView.h"

@interface ViewController ()

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ViewController


-(void)createData{
    self.dataArray = [NSMutableArray array];
    for (int i = 0; i<6; i++) {
        CircleViewModel *model = [[CircleViewModel alloc]init];
        model.labelTip = @"标签";
        model.contentDes = @"这个是内容描述";
        model.baseViewColor = @"#FF0000";
        model.fontColor = @"#000000";
        [self.dataArray addObject:model];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:[TurntableView createTurnableView]];
    /*
    [self createData];
    CircleViewManger *viewManger = [CircleViewManger mangerWithData:self.dataArray];
    [viewManger setUILayoutWithType:UICircleLayout];
    CircleLayoutPathView *pathView = [CircleLayoutPathView createLayoutPathWithData:viewManger];
    [self.view addSubview:pathView];
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
