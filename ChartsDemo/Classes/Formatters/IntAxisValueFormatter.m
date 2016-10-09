//
//  IntAxisValueFormatter.m
//  ChartsDemo
//  Copyright © 2016 dcg. All rights reserved.
//
/**
 *  X轴整数显示
 */

#import "IntAxisValueFormatter.h"

@implementation IntAxisValueFormatter
{
}

- (NSString *)stringForValue:(double)value
                        axis:(ChartAxisBase *)axis
{
    return [@((NSInteger)value) stringValue];
}

@end
