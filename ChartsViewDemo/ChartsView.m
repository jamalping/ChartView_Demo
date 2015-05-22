//
//  ChartsView.m
//  ChartsViewDemo
//
//  Created by 李小平 on 14-12-16.
//  Copyright (c) 2014年 jamalping. All rights reserved.
//

#define GridWidth [[UIScreen mainScreen] bounds].size.width/xNum
#define GridHeight GridWidth


#import "ChartsView.h"

@implementation ChartsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        bigenPoint = CGPointMake(0, 0);
        endPoint = CGPointMake(GridWidth*xNum, GridHeight*yNum);
        self.backgroundColor = [UIColor clearColor];
        xDatas = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",];
        yDatas = @[@"51期",@"52期",@"53期",@"54期",@"55期",@"56期",@"57期",@"58期",@"59期",@"60期"];
        fillDatas = [NSMutableArray array];
        for (NSString *index in yDatas) {
            NSMutableArray *array;
            for (int i = 0; i < 3; i++) {
                array = getUnRepeatRadomNumber(3, 11);
                NSLog(@"%@--%d",array,(int)array.count);
            }
            [fillDatas addObject:array];
            NSLog(@"-----%d",(int)fillDatas.count);
        }
    }
    return self;
}

int randomValueBetween(int min,int max) {
    if(min>max||min<0){
        return -1;
    }
    return arc4random()%(max-min+1)+min;
}

int randomValueBetweenOutOfSome(int min,int max,NSArray *deleteArray)
{
    int a = randomValueBetween(min, max);
    for (id oldNumber in deleteArray) {
        if (a == [oldNumber intValue]) {
            return randomValueBetweenOutOfSome(min, max, deleteArray);
        }
    }
    return a;
}

NSMutableArray *getRadomNumber(int number,int high) {
    NSMutableArray *ball = [NSMutableArray arrayWithCapacity:number];
    for (int i = 0;i < number; i++)
    {
        int rad = randomValueBetween(1,high);
        [ball addObject:[NSString stringWithFormat:@"%02d",rad]];
    }
    
    return ball;
}

NSMutableArray *getRadomNumberFromZero(int number,int high)
{
    NSMutableArray *ball = [NSMutableArray arrayWithCapacity:number];
    for (int i = 0;i < number; i++) {
        int rad = randomValueBetween(0,high);
        [ball addObject:[NSString stringWithFormat:@"%02d",rad]];
    }
    
    return ball;
}

// 多少个数里面随机选出不重复的几个数
NSMutableArray *getUnRepeatRadomNumber(int number,int high) {
    NSMutableArray *ball = [NSMutableArray arrayWithCapacity:number];
    for (int i = 0;i < number; i++) {
        int rad = randomValueBetween(1,high);
        BOOL skip = NO;
        for (int j = 0; j <[ball count]; j++) {
            if (rad == [[ball objectAtIndex:j] intValue]) {
                //NSLog(@"skip this number:%d",number);
                return getUnRepeatRadomNumber(number, high);
                skip = YES;
                break;
            }
        }
        if (!skip)
            [ball addObject:[NSString stringWithFormat:@"%02d",rad]];
    }
    
    return ball;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // 图形上下文，得到一个画笔，画布是view
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /*
     * @kCGPathFill, 设置填充
     * @kCGPathStroke, 设置线条
     * @kCGPathFillStroke, 两者兼有
     */
    // 画线
    
    // 设置画笔粗细
    
    for (int i = 0; i <= yNum; i++) {
        if (i<yNum&&i>0) {
            CGContextSetLineWidth(context, 1);
            
            NSString *period = yDatas[i-1];
            
            [period drawInRect:CGRectMake(0, i*GridHeight+7, GridWidth, GridHeight) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor redColor]}];
        }
        // 设置画笔颜色
        CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
        CGContextSetLineWidth(context, .4);
        // 画笔的起始坐标
        CGContextMoveToPoint(context, 0, i*GridHeight);
        CGContextAddLineToPoint(context, GridWidth*xNum+7, i*GridHeight);
        CGContextDrawPath(context, kCGPathStroke);
    }
    for (int j = 0; j <= xNum; j++) {
        if (j<xNum&&j>0) {
            for (int i = 0; i < yNum; i++) {
                NSString *period = xDatas[j-1];
                
                [period drawInRect:CGRectMake(j*GridWidth+10, i*GridHeight+7, GridWidth, GridHeight) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor redColor]}];
            }
        }
        CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
        CGContextSetLineWidth(context, .4);
        CGContextMoveToPoint(context, j*GridWidth, 0);
        CGContextAddLineToPoint(context, j*GridWidth, yNum*GridHeight);
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    // 画填充圆
    for (int i = 0; i<fillDatas.count; i++) {
        CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
        CGContextSetLineWidth(context, .4);
        NSArray *numbers = fillDatas[i];
        for (int x = 0; x < xDatas.count; x++) {
            for (NSNumber *number in numbers) {
                if ([number intValue]==x) {
                    CGContextAddArc(context, GridWidth*x+GridWidth/2, GridHeight*i+GridHeight/2, GridHeight/2, 0, M_PI*2, 1);
                    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
                    CGContextDrawPath(context, kCGPathStroke);
                    
                    CGContextAddArc(context, GridWidth*x+GridWidth/2, GridHeight*i+GridHeight/2, GridHeight/2, 0, M_PI*2, 1);
                    CGContextSetFillColorWithColor(context, [UIColor cyanColor].CGColor);
                    CGContextDrawPath(context, kCGPathFill);
                    NSString *numberStr = [NSString stringWithFormat:@"%@",number];
//                    [number stringValue];
                    
                    [numberStr drawInRect:CGRectMake(x*GridWidth+6.5, i*GridHeight+6.5, GridWidth, GridHeight) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor redColor]}];
                    
                }
            }
        }
    }
}


@end
