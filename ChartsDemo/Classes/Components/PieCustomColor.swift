//
//  PieCustomColor.swift
//  ChartsDemo
//
//  Created by sunhong on 2016/10/11.
//  Copyright © 2016年 dcg. All rights reserved.
//

import Foundation
import Charts

open class PieCustomColor: ChartColorTemplates
{
    open class func pieColorMarket () -> [NSUIColor]
    {
        let pieColor = [
            NSUIColor(red: 69/255.0, green: 193/255.0, blue: 51/255.0, alpha: 1.0),
            NSUIColor(red: 117/255.0, green: 211/255.0, blue: 34/255.0, alpha: 1.0),
            NSUIColor(red: 177/255.0, green: 244/255.0, blue: 63/255.0, alpha: 1.0),
            NSUIColor(red: 255/255.0, green: 194/255.0, blue: 57/255.0, alpha: 1.0),
            NSUIColor(red: 255/255.0, green: 148/255.0, blue: 8/255.0, alpha: 1.0),
            NSUIColor(red: 255/255.0, green: 91/255.0, blue: 0/255.0, alpha: 1.0),
            NSUIColor(red: 244/255.0, green: 63/255.0, blue: 0/255.0, alpha: 1.0),
            NSUIColor(red: 80/255.0, green: 134/255.0, blue: 214/255.0, alpha: 1.0),
            NSUIColor(red: 82/255.0, green: 177/255.0, blue: 255/255.0, alpha: 1.0),
            NSUIColor(red: 74/255.0, green: 211/255.0, blue: 221/255.0, alpha: 1.0)
        ]
        return pieColor
    }
}
