//
//  BrokenLine.swift
//  BarChartSample
//
//  Created by IOS-Sun on 16/5/31.
//  Copyright © 2016年 IOS-Sun. All rights reserved.
//

import Foundation

extension BarChartRenderer
{
    func drawBrokenLine(context: CGContext, dataProvider: BarChartDataProvider,set: IBarChartDataSet, barData: BarChartData, index: Int, y1: Double, y2: Double, x: CGFloat) {

        //构建柱子中间的虚线，默认情况下显示虚线
        var _highlightPointBuffer = CGPoint()
        
        context.setStrokeColor(set.highlightColor.cgColor)
//        let width : Double = barData.barWidth
        context.setLineWidth(set.highlightLineWidth)
        
        if (set.highlightLineDashLengths != nil)
        {
            context.setLineDash(phase: set.highlightLineDashPhase, lengths: set.highlightLineDashLengths!)
        }
        else
        {
            context.setLineDash(phase: 0.0, lengths: [12.0, 10.0])
        }
        
        if y1 >= -y2 {
            _highlightPointBuffer.x = CGFloat(x)
            _highlightPointBuffer.y = 0
            
            let trans = dataProvider.getTransformer(forAxis: set.axisDependency)
            
            trans.pointValueToPixel(&_highlightPointBuffer)
            
            context.beginPath()
            context.move(to: CGPoint(x: _highlightPointBuffer.x, y: 0.0))
            context.addLine(to: _highlightPointBuffer);
            context.strokePath()
            
        } else {
            _highlightPointBuffer.x = CGFloat(x)
            _highlightPointBuffer.y = 0
            
            let trans = dataProvider.getTransformer(forAxis: set.axisDependency)
            
            trans.pointValueToPixel(&_highlightPointBuffer)
            
            context.beginPath()
            context.move(to: CGPoint(x: _highlightPointBuffer.x, y: (viewPortHandler?.contentBottom)!))
            context.addLine(to: _highlightPointBuffer)
            context.strokePath()
        }
    }
    
}
