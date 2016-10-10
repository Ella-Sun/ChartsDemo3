
/*********************************************************************************
 *Copyright (c) 2016 Appscomm Inc. All rights reserved.
 *FileName:  PieChartPercent.swift
 *Author:  孙红
 *Date:  2016.06.13
 *Description: 饼状图 重新计算百分比
 **********************************************************************************/

import Foundation

extension PieChartView
{
    func reCalcAngles(drawAngles: [CGFloat]) -> [CGFloat] {
        
        var _drawAngles = drawAngles
        
        var maxAngle = _drawAngles[0]
        var minAngle = _drawAngles[_drawAngles.count - 1]
        let count = _drawAngles.count
        var maxIndex = 0
        var minIndex = 0
        
        for _ in 0..<count {
            
            for k in 0..<count {
                
                maxAngle = _drawAngles[k] > maxAngle ?  _drawAngles[k] : maxAngle
                
                for a in 0..<count {
                    if(_drawAngles[a] == maxAngle){
                        maxIndex = a;
                        break;
                    }
                }
                minAngle = _drawAngles[k] < minAngle ?  _drawAngles[k] : minAngle
                for b in 0..<count {
                    
                    if(_drawAngles[b] == minAngle){
                        minIndex = b;
                        break;
                    }
                }
            }
            
            if(minAngle < 18){
                maxAngle = maxAngle - 18 + minAngle
                minAngle = 18
                _drawAngles[maxIndex] = maxAngle
                _drawAngles[minIndex] = minAngle
            }
        }
        
        return (_drawAngles)
    }
    
    func reCalAbsoluteAngles(drawAngles: [CGFloat]) -> [CGFloat] {
        
        var _drawAngles = drawAngles
        var _absoluteAngles = [CGFloat]()
        
        var ct = 0
        let count = _drawAngles.count
        for _ in 0..<count
        {
            if (ct == 0)
            {
                _absoluteAngles.append(_drawAngles[ct])
            }
            else
            {
                _absoluteAngles.append(_absoluteAngles[ct - 1] + _drawAngles[ct])
            }
            
            ct+=1
        }
        return _absoluteAngles
    }
}
