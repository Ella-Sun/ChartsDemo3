//
//  XYMarkerView.swift
//  ChartsDemo
//  Copyright © 2016 dcg. All rights reserved.
//

import Foundation
import Charts

open class XYMarkerView: BalloonMarker
{
    open var xAxisValueFormatter: IAxisValueFormatter?
    fileprivate var yFormatter = NumberFormatter()
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets,
                xAxisValueFormatter: IAxisValueFormatter)
    {
        super.init(color: color, font: font, textColor: textColor, insets: insets)
        self.xAxisValueFormatter = xAxisValueFormatter
        yFormatter.minimumFractionDigits = 1
        yFormatter.maximumFractionDigits = 1
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        //TODO:
        let isGroup = highlight.dataSetIndex
        let xIndex = highlight.axis.rawValue
        let detailDes: [NSString]
        var text: NSString = ""
        var childAry: [NSString]
        
        if self.barDescription.count > 0 {
            
            childAry = self.barDescription[0] as! [NSString]
            
            if childAry.count > xIndex {
                detailDes = self.barDescription[isGroup] as! [NSString]
                text = detailDes[xIndex]
            }
        }
        
        if(self.lineDateDescription.count > 0){
            text = lineDateDescription[xIndex] as! NSString
            text =  (text as String).appending("\n") as NSString
        }
        
        let defaultValue = "x: " + xAxisValueFormatter!.stringForValue(entry.x, axis: nil) + ", y: " + yFormatter.string(from: NSNumber(floatLiteral: entry.y))!
        
        let label = (text as String) + defaultValue
        
        setLabel(String(label))
    }
    
}
