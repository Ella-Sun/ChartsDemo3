//
//  LineChart1ViewController.h
//  ChartsDemo
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

#import <UIKit/UIKit.h>
#import "DemoBaseViewController.h"
#import <Charts/Charts.h>

@interface LineChart1ViewController : DemoBaseViewController

@property (nonatomic, assign) BOOL isTouchLiminLine;

//记录返回的最大金额
@property (nonatomic, assign) CGFloat maxBalance;
//记录返回的最小金额
@property (nonatomic, assign) CGFloat minBalance;

@end
