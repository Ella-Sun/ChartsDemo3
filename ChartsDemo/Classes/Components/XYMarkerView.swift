//
//  XYMarkerView.swift
//  ChartsDemo
//  Copyright © 2016 dcg. All rights reserved.
//
/**
 *  气泡显示收、支——>可删除DayAxisValueFormatter，在代码中添加
 */

import Foundation
import Charts

open class XYMarkerView: BalloonMarker
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
        
        let label = xAxisValueFormatter!.stringForValue(entry.x, axis: nil) + numLabel
        
        setLabel(String(label))
    }
}
