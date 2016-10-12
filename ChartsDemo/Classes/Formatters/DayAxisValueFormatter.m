//
//  DayAxisValueFormatter.m
//  ChartsDemo
//  Copyright © 2016 dcg. All rights reserved.
//

#import "DayAxisValueFormatter.h"

@implementation DayAxisValueFormatter
{
    NSArray *mulBars, *singleBars;
    __weak BarLineChartViewBase *_chart;
}

- (id)initForChart:(BarLineChartViewBase *)chart
{
    self = [super init];
    if (self)
    {
        self->_chart = chart;
        mulBars = @[@"净:",@"收:",@"支:"];
        singleBars = @[@"收:",@"支:"];
    }
    return self;
}

- (NSString *)stringForValue:(double)value
                        axis:(ChartAxisBase *)axis
{
    NSInteger setCount = _chart.data.dataSetCount;
    
    if (setCount == 2) {
        int index = value;
        return singleBars[index];
    }
    
    if (setCount == 3) {
        int index = value;
        return mulBars[index];
    }
    //只能用于一个1组的
    int days = (int)value - 1;
    
    NSString *headTitle = singleBars[0];
    
    //如果1个1组 收： 支：
    ChartDataSet *dataSet = (ChartDataSet *)_chart.data.dataSets[0];
    ChartDataEntry *entry = dataSet.values[days];
    float data = entry.y;
    if (data < 0) {
        headTitle = singleBars[1];
    }
    
    return headTitle;
}

@end
