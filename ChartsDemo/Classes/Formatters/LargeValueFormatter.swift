//
//  LargeValueFormatter.swift
//  ChartsDemo
//  Copyright © 2016 dcg. All rights reserved.
//
/**
 *  Y轴以万为单位
 */

import Foundation
import Charts

open class LargeValueFormatter: NSObject, IValueFormatter, IAxisValueFormatter
{
    fileprivate static let MAX_LENGTH = 5
    
    /// Suffix to be appended after the values.
    ///
    /// **default**: suffix: ["", "k", "m", "b", "t"]
    open var suffix = ["", "w"]
    
    /// An appendix text to be added at the end of the formatted value.
    open var appendix: String?
    
    public override init()
    {
        
    }
    
    public init(appendix: String?)
    {
        self.appendix = appendix
    }
    
    fileprivate func format(value: Double) -> String
    {
        var sig = value
        var length = 0
        let maxLength = suffix.count - 1
        
        if (sig >= 10000.0 || sig <= -10000.0) && length < maxLength
        {
            sig /= 10000.0
            length += 1
        }
        
        var r = String(format: "%2.2f", sig) + suffix[length]
        
        if appendix != nil
        {
            r += appendix!
        }
        
        return r
    }
    
    open func stringForValue(
        _ value: Double, axis: AxisBase?) -> String
    {
        return format(value: value)
    }
    
    open func stringForValue(
        _ value: Double,
        entry: ChartDataEntry,
        dataSetIndex: Int,
        viewPortHandler: ViewPortHandler?) -> String
    {
        return format(value: value)
    }
}
