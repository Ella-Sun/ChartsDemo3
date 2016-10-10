//
//  LineXLabel.swift
//  Charts
//
//  Created by IOS-Sun on 16/6/8.
//  Copyright © 2016年 dcg. All rights reserved.
//

import Foundation

fileprivate var _xLabelHidden = false

extension XAxis//ChartXAxis
{
    public var xLabelHidden: Bool
        {
        get
        {
            return _xLabelHidden
        }
        set
        {
            if (_xLabelHidden != newValue)
            {
                _xLabelHidden = newValue
            }
        }
    }
}
