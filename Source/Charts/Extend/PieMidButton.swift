
/*********************************************************************************
 *Copyright (c) 2016 Appscomm Inc. All rights reserved.
 *FileName:  PieMidButton.swift
 *Author:  孙红
 *Date:  2016.06.13
 *Description: 饼状图 绘制饼状图中间的按钮
 **********************************************************************************/

import Foundation

extension PieChartRenderer
{
    open func drawPieChartMiddleButton(holeRadius: CGFloat, center:CGPoint, chart: PieChartView) {
        
        if(centerButton == nil){
    
            centerButton = YZButton()
            
            let btnWH : CGFloat = holeRadius * 2
            
            centerButton?.frame = CGRect(x: center.x - holeRadius, y: center.y - holeRadius, width: btnWH, height: btnWH)
            centerButton?.backgroundColor = UIColor.clear
            centerButton?.adjustsImageWhenHighlighted = false
            centerButton?.layer.cornerRadius = holeRadius
            centerButton?.clipsToBounds = true
            centerButton?.setTitleColor(UIColor.black, for: UIControlState.normal)
            centerButton?.titleLabel!.textAlignment = .center
            centerButton?.titleLabel!.font = UIFont.systemFont(ofSize: 14)
            
//            centerButton!.imageView!.backgroundColor = UIColor.redColor()
            
            centerButton?.addTarget(self, action: #selector(PieChartRenderer.centerBtnDidClicked), for: UIControlEvents.touchUpInside)
            
            chart.addSubview(centerButton!)
            
        }
    }
    
    //中间按钮的点击事件发出通知
    func centerBtnDidClicked(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "centerBtnDidClicked"), object: nil);
    }
}
