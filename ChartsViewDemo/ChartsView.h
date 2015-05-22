//
//  ChartsView.h
//  ChartsViewDemo
//
//  Created by 李小平 on 14-12-16.
//  Copyright (c) 2014年 jamalping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartsView : UIView {
    CGPoint bigenPoint;    // 表格开始的点
    CGPoint endPoint;      // 表格结束的点
    NSArray *xDatas;       // X轴上的数据
    NSArray *yDatas;       // Y轴上的数据
    NSMutableArray *fillDatas;    // 填充的数据
}


@end
