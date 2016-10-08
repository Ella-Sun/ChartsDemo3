//
//  YRedefine.swift
//  BarChartSample
//
//  Created by IOS-Sun on 16/6/1.
//  Copyright © 2016年 IOS-Sun. All rights reserved.
//

import Foundation

extension YAxisRenderer//ChartYAxisRenderer
{
    //TODO:当数值大于万位，省略后边位数
    public func getBackNewTextFromYpiex(text: String) -> String
    {
        
        let startWord: Character = text[text.startIndex]
        
        var newText: String = text
        newText = newText.replacingOccurrences(of: ",", with: "")
        newText = newText.replacingOccurrences(of: "-", with: "")
        newText = newText.replacingOccurrences(of: " ", with: "")
        newText = newText.replacingOccurrences(of: "$", with: "")

        let len = newText.characters.count;
        
        if newText == "0" {
            return newText
        }
        
        if len < 2 {
            return newText
        }
        
        switch len {
        case 2:
            let endIndex = newText.index(newText.endIndex, offsetBy: -1)
            newText = newText.substring(to: endIndex)
            newText = "0.00" + newText
        case 3:
            let endIndex = newText.index(newText.endIndex, offsetBy: -2)
            newText = newText.substring(to: endIndex)
            newText = "0.0" + newText
        case 4:
            let endIndex = newText.index(newText.endIndex, offsetBy: -3)
            newText = newText.substring(to: endIndex)
            newText = "0." + newText
        default:
            let endIndex = newText.index(newText.endIndex, offsetBy: -3)
            newText = newText.substring(to: endIndex)
            
            let lEndIndex = newText.index(newText.endIndex, offsetBy: -1)
            let lRange = lEndIndex..<newText.endIndex
            let lastWord : String = newText[lRange]
            newText.removeSubrange(lRange)
            
            newText = newText + "." + lastWord
        }
        
        if startWord == "-" {
            newText = "-" + newText
        }
        
        return newText
    }
}
