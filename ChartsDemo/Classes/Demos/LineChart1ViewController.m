//
//  LineChart1ViewController.m
//  ChartsDemo
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

#import "LineChart1ViewController.h"
#import "ChartsDemo-Swift.h"

#define kColorWithRGB(r,g,b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) /255.0 alpha:1.0]

@interface LineChart1ViewController () <ChartViewDelegate>

@property (nonatomic, strong) IBOutlet LineChartView *chartView;
@property (nonatomic, strong) IBOutlet UISlider *sliderX;
@property (nonatomic, strong) IBOutlet UISlider *sliderY;
@property (nonatomic, strong) IBOutlet UITextField *sliderTextX;
@property (nonatomic, strong) IBOutlet UITextField *sliderTextY;

@end

@implementation LineChart1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Line Chart 1";
    
    self.options = @[
                     @{@"key": @"toggleValues", @"label": @"Toggle Values"},
                     @{@"key": @"toggleFilled", @"label": @"Toggle Filled"},
                     @{@"key": @"toggleCircles", @"label": @"Toggle Circles"},
                     @{@"key": @"toggleCubic", @"label": @"Toggle Cubic"},
                     @{@"key": @"toggleHorizontalCubic", @"label": @"Toggle Horizontal Cubic"},
                     @{@"key": @"toggleStepped", @"label": @"Toggle Stepped"},
                     @{@"key": @"toggleHighlight", @"label": @"Toggle Highlight"},
                     @{@"key": @"animateX", @"label": @"Animate X"},
                     @{@"key": @"animateY", @"label": @"Animate Y"},
                     @{@"key": @"animateXY", @"label": @"Animate XY"},
                     @{@"key": @"saveToGallery", @"label": @"Save to Camera Roll"},
                     @{@"key": @"togglePinchZoom", @"label": @"Toggle PinchZoom"},
                     @{@"key": @"toggleAutoScaleMinMax", @"label": @"Toggle auto scale min/max"},
                     @{@"key": @"toggleData", @"label": @"Toggle Data"},
                     ];
    
    _chartView.delegate = self;
    
    _chartView.chartDescription.enabled = NO;// 右下角描述
    _chartView.noDataText = @"You need to provide data for the chart."; // 当图表为空的时候的提示语
    
    _chartView.dragEnabled = YES;
    [_chartView setScaleEnabled:YES];
    _chartView.pinchZoomEnabled = YES;// yes的时候x 和 y轴均可缩放
    _chartView.drawGridBackgroundEnabled = NO;// 是否绘制网络背景
    
    _chartView.backgroundColor= [UIColor whiteColor];

    // x-axis limit line
//    ChartLimitLine *llXAxis = [[ChartLimitLine alloc] initWithLimit:10.0 label:@"Index 10"];
//    llXAxis.lineWidth = 4.0;
//    llXAxis.lineDashLengths = @[@(10.f), @(10.f), @(0.f)];
//    llXAxis.labelPosition = ChartLimitLabelPositionRightBottom;
//    llXAxis.valueFont = [UIFont systemFontOfSize:10.f];
//    
//    [_chartView.xAxis addLimitLine:llXAxis];
    
//    _chartView.xAxis.gridLineDashLengths = @[@10.0, @10.0];
//    _chartView.xAxis.gridLineDashPhase = 0.f;
    
    //X轴上的描述
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelTextColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255. alpha:1.0];
    xAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    xAxis.drawGridLinesEnabled = NO; // 是否显示横线
    xAxis.drawAxisLineEnabled = NO; // 是否显示X轴坐标轴
    xAxis.labelPosition = XAxisLabelPositionBottom; // X轴显示位置
//    xAxis.spaceBetweenLabels = 0.5;
    xAxis.xLabelHidden = YES;
    
    ChartLimitLine *ll1 = [[ChartLimitLine alloc] initWithLimit:150.0 label:@"预警线"];
    ll1.lineWidth = 2.0;
    ll1.lineDashLengths = @[@5.f, @5.f];
    ll1.labelPosition = ChartLimitLabelPositionRightTop;
    ll1.valueFont = [UIFont systemFontOfSize:10.0];
    
    // y 轴上的一些设置
    ChartYAxis *leftAxis = _chartView.leftAxis;
    [leftAxis removeAllLimitLines];
    [leftAxis addLimitLine:ll1];
    
    leftAxis.drawAxisLineEnabled = NO;
    leftAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    leftAxis.labelTextColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255. alpha:1.0];
    leftAxis.drawGridLinesEnabled = YES; // 是否显示平行于X 轴的虚线
    leftAxis.gridColor = [UIColor colorWithRed:228.0/255.0 green:230.0/255.0 blue:234.0/255. alpha:1.0];
    leftAxis.axisMaximum = 200.0;
    leftAxis.axisMinimum = -50.0;
//    leftAxis.gridLineDashLengths = @[@5.f, @5.f];
//    leftAxis.drawZeroLineEnabled = NO;
    leftAxis.drawLimitLinesBehindDataEnabled = YES;
    
    //TODO: 更改属性名
//    leftAxis.axisMinValue = 0.0;
//    leftAxis.startAtZeroEnabled = NO;
    
    _chartView.rightAxis.enabled = NO;
    
    //TODO:最大可发大两倍
    [_chartView.viewPortHandler setMaximumScaleY: 2.f];
    [_chartView.viewPortHandler setMaximumScaleX: 2.f];
    
//    BalloonMarker *marker = [[BalloonMarker alloc]
//                             initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
//                             font: [UIFont systemFontOfSize:12.0]
//                             textColor: UIColor.whiteColor
//                             insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
//    marker.chartView = _chartView;
//    marker.minimumSize = CGSizeMake(80.f, 40.f);
//    _chartView.marker = marker;
    XYMarkerView *marker = [[XYMarkerView alloc]
                             initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
                             font: [UIFont systemFontOfSize:12.0]
                             textColor: UIColor.whiteColor
                             insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];//前缀、后缀
    marker.chartView = _chartView;
    marker.minimumSize = CGSizeMake(80.f, 40.f);
    _chartView.marker = marker;
    
    /**<  图例  >**/
    _chartView.legend.form = ChartLegendFormLine;
    _chartView.legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    _chartView.legend.textColor = UIColor.blackColor;
    _chartView.legend.position = ChartLegendPositionRightOfChartInside;
    
    _sliderX.value = 15.0;
    _sliderY.value = 100.0;
    [self slidersValueChanged:nil];
    
    [_chartView animateWithXAxisDuration:2.5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateChartData
{
    if (self.shouldHideData)
    {
        _chartView.data = nil;
        return;
    }
    
    [self setDataCount:_sliderX.value range:_sliderY.value];
}

- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double val = arc4random_uniform(range) + 3;
        [values addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
    }
    
    LineChartDataSet *set1 = nil;
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        set1.values = values;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithValues:values label:@"当日余额"];
        
//        set1.lineDashLengths = @[@5.f, @2.5f];
//        set1.axisDependency = AxisDependencyLeft;
        [set1 setColor:kColorWithRGB(182, 162, 222)]; // 折线的颜色
        set1.lineWidth = 2.0; // 线宽
        set1.drawCubicEnabled = YES; // 让折线以圆弧形显示
        set1.drawValuesEnabled = NO; // 是否显示点上面的值
        
        [set1 setCircleColor:kColorWithRGB(182, 162, 222)]; // 拐点 点的颜色
        set1.circleRadius = 3.0; // 拐点半径
        set1.drawCircleHoleEnabled = YES; // NO 为实心圆，yes 为空心圆
        [set1 setCircleHoleColor:UIColor.whiteColor];
        
        set1.drawFilledEnabled = YES; // 画折线下面的彩色阴影
        set1.fillAlpha = 65/255.0; //填充颜色的透明度
        set1.fillColor = kColorWithRGB(182, 162, 222); //填充颜色
        
        set1.valueFont = [UIFont systemFontOfSize:9.f]; // 点上面的值得大小
        set1.highlightLineDashLengths = @[@15.f, @10.f]; // 点击后出现水平和竖直虚线长度和间隙长度
        set1.highlightLineWidth = 1.0; //点击后水平和竖直虚线宽度
        set1.highlightColor = [UIColor blackColor]; //点击后水平和竖直虚线颜色
        
//        NSArray *gradientColors = @[
//                                    (id)[ChartColorTemplates colorFromString:@"#00ff0000"].CGColor,
//                                    (id)[ChartColorTemplates colorFromString:@"#ffff0000"].CGColor
//                                    ];
//        CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        
//        set1.fillAlpha = 1.f;
//        set1.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
//        set1.drawFilledEnabled = YES;
        
//        CGGradientRelease(gradient);
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        
        _chartView.data = data;
    }
    
    [self.chartView animateWithXAxisDuration:1.5 yAxisDuration:1.5 easingOption:ChartEasingOptionEaseInOutCubic];
}

- (void)optionTapped:(NSString *)key
{
    if ([key isEqualToString:@"toggleFilled"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.drawFilledEnabled = !set.isDrawFilledEnabled;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"toggleCircles"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.drawCirclesEnabled = !set.isDrawCirclesEnabled;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    if ([key isEqualToString:@"toggleCubic"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.mode = set.mode == LineChartModeCubicBezier ? LineChartModeLinear : LineChartModeCubicBezier;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }

    if ([key isEqualToString:@"toggleStepped"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.drawSteppedEnabled = !set.isDrawSteppedEnabled;
        }

        [_chartView setNeedsDisplay];
    }
    
    if ([key isEqualToString:@"toggleHorizontalCubic"])
    {
        for (id<ILineChartDataSet> set in _chartView.data.dataSets)
        {
            set.mode = set.mode == LineChartModeHorizontalBezier ? LineChartModeCubicBezier : LineChartModeHorizontalBezier;
        }
        
        [_chartView setNeedsDisplay];
        return;
    }
    
    [super handleOption:key forChartView:_chartView];
}

#pragma mark - Actions

- (IBAction)slidersValueChanged:(id)sender
{
    _sliderTextX.text = [@((int)_sliderX.value) stringValue];
    _sliderTextY.text = [@((int)_sliderY.value) stringValue];
    
    [self updateChartData];
}
/*
#pragma mark - 移动预警虚线的方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.chartView];
    //TODO: 稍后修改
    if((self.chartView.leftYAxisRenderer.yPoint.y - 8) < point.y && point.y < (self.chartView.leftYAxisRenderer.yPoint.y + 8)){
        
        self.isTouchLiminLine = YES;
        //移除手势
//        [self.chartView removeGestureRecognizer:self.chartView._tapGestureRecognizer];
//        [self.chartView removeGestureRecognizer:self.chartView._panGestureRecognizer];
        
    }else{
        
        self.isTouchLiminLine = NO;
        
//        [self.chartView addGestureRecognizer:self.chartView._tapGestureRecognizer];
//        [self.chartView addGestureRecognizer:self.chartView._panGestureRecognizer];
    }
    
}

static CGPoint position;
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.chartView];
    
    if(self.isTouchLiminLine){
        //移除手势
//        [self.chartView removeGestureRecognizer:self.chartView._tapGestureRecognizer];
//        [self.chartView removeGestureRecognizer:self.chartView._panGestureRecognizer];
        
        // 反转坐标（将点对应的Y值转换为Y轴上对应的Y值）
        CGAffineTransform trans = self.chartView.xAxisRenderer.transformer.valueToPixelMatrix;
        CGAffineTransform invert = CGAffineTransformInvert(trans);
        position = CGPointApplyAffineTransform(point,invert);
        
        //如果移动的点超出y轴上的最大最小值就直接返回
        if(position.y > self.maxBalance || position.y < self.minBalance){
            return;
        }
        //通过传入Y轴上的新值将预警线移动到新的位置
        [self moveChartLimitLine:position.y];
        
    }else{
        
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [self.chartView addGestureRecognizer:self.chartView._tapGestureRecognizer];
//    [self.chartView addGestureRecognizer:self.chartView._panGestureRecognizer];
}

//将预警线移动的新传入值的位置同时 改变 下面预警余额的显示
- (void)moveChartLimitLine:(CGFloat)limitY{
    
    //移除之前的线
    [self.chartView.leftAxis removeAllLimitLines];
    
    // 添加新的线
    ChartLimitLine *ll1 = [[ChartLimitLine alloc] initWithLimit:0 label:@"预警线"];
    ll1.lineWidth = 2.0;
    ll1.limit = limitY;
    ll1.lineColor = [UIColor redColor];
    ll1.lineDashLengths = @[@5.f, @5.f]; //ll1线的长度以及 间距
    ll1.labelPosition = ChartLimitLabelPositionRightTop;
    ll1.valueFont = [UIFont systemFontOfSize:10.0];
    
    // y 轴上的一些设置
    ChartYAxis *leftAxis = self.chartView.leftAxis;
    [leftAxis addLimitLine:ll1];
    
    [self.chartView setNeedsDisplay];
    
//    NSString *moneyStr = [NSString stringWithFormat:@"%.2f",limitY];
//    self.fluctuationView.moneyStr = moneyStr;
}
*/

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}

@end
