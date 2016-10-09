//
//  BalloonMarker.swift
//  ChartsDemo
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//

import Foundation
import Charts


open class BalloonMarker: MarkerImage
{
    open var color: UIColor?
    open var arrowSize = CGSize(width: 15, height: 11)
    open var font: UIFont?
    open var textColor: UIColor?
    open var insets = UIEdgeInsets()
    open var minimumSize = CGSize()
    
    //TODO:添加
    public var barDescription = NSMutableArray()
    public var lineDateDescription = NSMutableArray()
    
    fileprivate var labelns: NSString?
    fileprivate var _labelSize: CGSize = CGSize()
    fileprivate var _paragraphStyle: NSMutableParagraphStyle?
    fileprivate var _drawAttributes = [String : AnyObject]()
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets)
    {
        super.init()
        
        self.color = color
        self.font = font
        self.textColor = textColor
        self.insets = insets
        
        _paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
        _paragraphStyle?.alignment = .center
    }
    
    open override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint
    {
        let size = self.size
        var point = point
        point.y -= size.height
        return super.offsetForDrawing(atPoint: point)
    }
    
    open override func draw(context: CGContext, point: CGPoint)
    {
        if labelns == nil
        {
            return
        }
        
        let offset = self.offsetForDrawing(atPoint: point)
        let size = self.size
        
        var rect = CGRect(
            origin: CGPoint(
                x: point.x,
                y: point.y + offset.y),
            size: size)
        rect.origin.x -= size.width / 2.0
        rect.origin.y -= size.height
        
        //TODO:
        let maxXpiex = rect.origin.x + rect.size.width
        let APP_Width = UIScreen.main.bounds.size.width
        var newXpiex = rect.origin.x
        
        if maxXpiex > APP_Width {
            newXpiex = APP_Width - rect.size.width;
        }
        
        context.saveGState()
        
        if let color = color
        {
            context.setFillColor(color.cgColor)
            context.beginPath()
            //left up
            context.move(to: CGPoint(
                x: newXpiex,
                y: rect.origin.y))
            //right up
            context.addLine(to: CGPoint(
                x: newXpiex + rect.size.width,
                y: rect.origin.y))
            //right down
            context.addLine(to: CGPoint(
                x: newXpiex + rect.size.width,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            //center point right
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            //center point
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width / 2.0,
                y: rect.origin.y + rect.size.height))
            //center point left
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            //left down
            context.addLine(to: CGPoint(
                x: newXpiex,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            //left up
            context.addLine(to: CGPoint(
                x: newXpiex,
                y: rect.origin.y))
            context.fillPath()
        }
        
        //TODO:新增
        if maxXpiex > APP_Width {
            rect.origin.x = newXpiex
        }
        
        rect.origin.y += self.insets.top
        
        rect.size.height -= self.insets.top + self.insets.bottom
        
        UIGraphicsPushContext(context)
        
        labelns?.draw(in: rect, withAttributes: _drawAttributes)
        
        UIGraphicsPopContext()
        
        context.restoreGState()
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        //TODO:
        let yFormatter: NumberFormatter = generateDefaultValueFormatter()
        let newText = yFormatter.number(from: String(entry.y))//——>number
        let numLabel = yFormatter.string(from: newText!)!//——>String
        
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
        
        let label = (text as String) + numLabel
        
        setLabel(String(label))
    }
    
    open func setLabel(_ label: String)
    {
        labelns = label as NSString
        
        _drawAttributes.removeAll()
        _drawAttributes[NSFontAttributeName] = self.font
        _drawAttributes[NSParagraphStyleAttributeName] = _paragraphStyle
        _drawAttributes[NSForegroundColorAttributeName] = self.textColor
        
        _labelSize = labelns?.size(attributes: _drawAttributes) ?? CGSize.zero
        
        var size = CGSize()
        size.width = _labelSize.width + self.insets.left + self.insets.right
        size.height = _labelSize.height + self.insets.top + self.insets.bottom
        //TODO:
        if(self.lineDateDescription.count > 0){
            size.height += 6
        }
        size.width = max(minimumSize.width, size.width)
        size.height = max(minimumSize.height, size.height)
        self.size = size
    }
    
    func generateDefaultValueFormatter() -> NumberFormatter
    {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 1//整数显示最少位数不足前面补零
        formatter.maximumFractionDigits = 2//小数显示最多位数超出四舍五入
        formatter.minimumFractionDigits = 2//小数显示最少位数不足后面补零
        formatter.usesGroupingSeparator = true//分组样式 默认为true 200,300.00
        formatter.positiveFormat = "#,##0.00"
        return formatter
    }
}
