//
//  ViewController.m
//  TurntableDemo
//
//  Created by jie on 2017/11/13.
//  Copyright © 2017年 jie. All rights reserved.
//

#import "ViewController.h"
#import "TurntableView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:[TurntableView createTurnableView]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
