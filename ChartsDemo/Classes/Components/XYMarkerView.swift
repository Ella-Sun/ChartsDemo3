//
//  XYMarkerView.swift
//  ChartsDemo
//  Copyright © 2016 dcg. All rights reserved.
//
/**
 *  气泡显示X轴坐标+Y轴千分位格式化
 */

import Foundation
import Charts

open class XYMarkerView: BalloonMarker
{
    fileprivate var yFormatter = NumberFormatter();
    
    public override init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets)
    {
        super.init(color: color, font: font, textColor: textColor, insets: insets)
        yFormatter = self.generateDefaultValueFormatter();
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        let label = String(entry.x) + "\n" + yFormatter.string(from: NSNumber(floatLiteral: entry.y))!
        
        setLabel(String(label))
    }
}
