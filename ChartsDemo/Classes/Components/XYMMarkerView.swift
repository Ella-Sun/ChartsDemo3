//
//  XYMMarker.swift
//  ChartsDemo
//
//  Created by sunhong on 2016/10/12.
//  Copyright © 2016年 dcg. All rights reserved.
//
/**
 *  气泡显示净、收、支
 */

import Foundation
import Charts

open class XYMMarkerView: BalloonMarker
{
    open var xAxisValueFormatter: IAxisValueFormatter?
    fileprivate var yFormatter = NumberFormatter();
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets,
                xAxisValueFormatter: IAxisValueFormatter)
    {
        super.init(color: color, font: font, textColor: textColor, insets: insets)
        self.xAxisValueFormatter = xAxisValueFormatter
        yFormatter = self.generateDefaultValueFormatter();
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        let newText = yFormatter.number(from: String(entry.y))
        let numLabel = yFormatter.string(from: newText!)!
        
        let label = xAxisValueFormatter!.stringForValue(Double(highlight.dataSetIndex), axis: nil) + numLabel
        
        setLabel(String(label))
    }
}
