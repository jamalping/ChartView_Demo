//
//  ViewController.m
//  ChartsViewDemo
//
//  Created by 李小平 on 14-12-16.
//  Copyright (c) 2014年 jamalping. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _chartsView = [[ChartsView alloc] initWithFrame:CGRectMake(0, 100, 320, 320)];
//    _chartsView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_chartsView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
