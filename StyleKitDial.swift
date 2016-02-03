//
//  StyleKitDial.swift
//  LASS Dial
//
//  Created by Paul Wu on 2016/2/2.
//  Copyright (c) 2016 Prodisky Inc. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//



import UIKit

public class StyleKitDial : NSObject {

    //// Drawing Methods

    public class func drawRing(value value: CGFloat = 0.14) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Color Declarations
        let color4 = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000)
        let color3 = UIColor(red: 1.000, green: 1.000, blue: 0.000, alpha: 1.000)
        let color2 = UIColor(red: 0.000, green: 1.000, blue: 0.000, alpha: 1.000)
        let color1 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        let colorRingBack = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.200)

        //// Variable Declarations
        let expressionAngle: CGFloat = -value * 360
        let expressionColor = value > 0.75 ? color4 : (value > 0.5 ? color3 : (value > 0.25 ? color2 : color1))

        //// Oval Line Back Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 100, 100)
        CGContextRotateCTM(context, -90 * CGFloat(M_PI) / 180)

        let ovalLineBackPath = UIBezierPath(ovalInRect: CGRectMake(-91, -91, 182, 182))
        colorRingBack.setStroke()
        ovalLineBackPath.lineWidth = 16
        ovalLineBackPath.stroke()

        CGContextRestoreGState(context)


        //// Oval Line Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 100, 100)
        CGContextRotateCTM(context, -90 * CGFloat(M_PI) / 180)

        let ovalLineRect = CGRectMake(-91, -91, 182, 182)
        let ovalLinePath = UIBezierPath()
        ovalLinePath.addArcWithCenter(CGPointMake(ovalLineRect.midX, ovalLineRect.midY), radius: ovalLineRect.width / 2, startAngle: 0 * CGFloat(M_PI)/180, endAngle: -expressionAngle * CGFloat(M_PI)/180, clockwise: true)

        expressionColor.setStroke()
        ovalLinePath.lineWidth = 16
        ovalLinePath.stroke()

        CGContextRestoreGState(context)


        //// Oval Line Back 2 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 100, 100)
        CGContextRotateCTM(context, -90 * CGFloat(M_PI) / 180)

        let ovalLineBack2Path = UIBezierPath(ovalInRect: CGRectMake(-78, -78, 156, 156))
        colorRingBack.setFill()
        ovalLineBack2Path.fill()

        CGContextRestoreGState(context)
    }

    public class func drawDataItem(frame frame: CGRect = CGRectMake(0, 0, 240, 320), name: String = "PM 2.5", data: String = "35", unit: String = "μg/m3", value: CGFloat = 0.14, station: String = "臺東 1.4KM", time: String = "2016/01/23 14:31") {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Symbol Time Drawing
        let symbolTimeRect = CGRectMake(frame.minX + floor(frame.width * 0.08333 + 0.5), frame.minY + floor(frame.height * 0.90625 + 0.5), floor(frame.width * 0.91667 + 0.5) - floor(frame.width * 0.08333 + 0.5), floor(frame.height * 0.96875 + 0.5) - floor(frame.height * 0.90625 + 0.5))
        CGContextSaveGState(context)
        UIRectClip(symbolTimeRect)
        CGContextTranslateCTM(context, symbolTimeRect.origin.x, symbolTimeRect.origin.y)
        CGContextScaleCTM(context, symbolTimeRect.size.width / 200, symbolTimeRect.size.height / 20)

        StyleKitDial.drawCenterText(value: value, label: time)
        CGContextRestoreGState(context)


        //// Symbol Station Drawing
        let symbolStationRect = CGRectMake(frame.minX + floor(frame.width * -0.12500 + 0.5), frame.minY + floor(frame.height * 0.79688 + 0.5), floor(frame.width * 1.12500 + 0.5) - floor(frame.width * -0.12500 + 0.5), floor(frame.height * 0.89062 + 0.5) - floor(frame.height * 0.79688 + 0.5))
        CGContextSaveGState(context)
        UIRectClip(symbolStationRect)
        CGContextTranslateCTM(context, symbolStationRect.origin.x, symbolStationRect.origin.y)
        CGContextScaleCTM(context, symbolStationRect.size.width / 200, symbolStationRect.size.height / 20)

        StyleKitDial.drawCenterText(value: value, label: station)
        CGContextRestoreGState(context)


        //// Symbol Name Drawing
        let symbolNameRect = CGRectMake(frame.minX + floor(frame.width * -0.33333 + 0.5), frame.minY + floor(frame.height * 0.03125 + 0.5), floor(frame.width * 1.33333 + 0.5) - floor(frame.width * -0.33333 + 0.5), floor(frame.height * 0.15625 + 0.5) - floor(frame.height * 0.03125 + 0.5))
        CGContextSaveGState(context)
        UIRectClip(symbolNameRect)
        CGContextTranslateCTM(context, symbolNameRect.origin.x, symbolNameRect.origin.y)
        CGContextScaleCTM(context, symbolNameRect.size.width / 200, symbolNameRect.size.height / 20)

        StyleKitDial.drawCenterText(value: value, label: name)
        CGContextRestoreGState(context)


        //// Symbol Ring Drawing
        let symbolRingRect = CGRectMake(frame.minX + floor(frame.width * 0.08333 + 0.5), frame.minY + floor(frame.height * 0.15625 + 0.5), floor(frame.width * 0.91667 + 0.5) - floor(frame.width * 0.08333 + 0.5), floor(frame.height * 0.78125 + 0.5) - floor(frame.height * 0.15625 + 0.5))
        CGContextSaveGState(context)
        UIRectClip(symbolRingRect)
        CGContextTranslateCTM(context, symbolRingRect.origin.x, symbolRingRect.origin.y)

        StyleKitDial.drawDataRing(frame: CGRectMake(0, 0, symbolRingRect.size.width, symbolRingRect.size.height), data: data, unit: unit, value: value)
        CGContextRestoreGState(context)
    }

    public class func drawCenterText(value value: CGFloat = 0.14, label: String = "PM 2.5") {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Color Declarations
        let color4 = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000)
        let color3 = UIColor(red: 1.000, green: 1.000, blue: 0.000, alpha: 1.000)
        let color2 = UIColor(red: 0.000, green: 1.000, blue: 0.000, alpha: 1.000)
        let color1 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

        //// Variable Declarations
        let expressionColor = value > 0.75 ? color4 : (value > 0.5 ? color3 : (value > 0.25 ? color2 : color1))

        //// Text Drawing
        let textRect = CGRectMake(0, 0, 200, 20)
        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = .Center

        let textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(19), NSForegroundColorAttributeName: expressionColor, NSParagraphStyleAttributeName: textStyle]

        let textTextHeight: CGFloat = NSString(string: label).boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, textRect);
        NSString(string: label).drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context)
    }

    public class func drawDataRing(frame frame: CGRect = CGRectMake(0, 0, 200, 200), data: String = "35", unit: String = "μg/m3", value: CGFloat = 0.14) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Symbol Data Drawing
        let symbolDataRect = CGRectMake(frame.minX + floor(frame.width * -1.42500 + 0.5), frame.minY + floor(frame.height * 0.30500 + 0.5), floor(frame.width * 2.42500 + 0.5) - floor(frame.width * -1.42500 + 0.5), floor(frame.height * 0.69000 + 0.5) - floor(frame.height * 0.30500 + 0.5))
        CGContextSaveGState(context)
        UIRectClip(symbolDataRect)
        CGContextTranslateCTM(context, symbolDataRect.origin.x, symbolDataRect.origin.y)
        CGContextScaleCTM(context, symbolDataRect.size.width / 200, symbolDataRect.size.height / 20)

        StyleKitDial.drawCenterText(value: value, label: data)
        CGContextRestoreGState(context)


        //// Symbol Unit Drawing
        let symbolUnitRect = CGRectMake(frame.minX + floor(frame.width * 0.00000 + 0.5), frame.minY + floor(frame.height * 0.69000 + 0.5), floor(frame.width * 1.00000 + 0.5) - floor(frame.width * 0.00000 + 0.5), floor(frame.height * 0.79000 + 0.5) - floor(frame.height * 0.69000 + 0.5))
        CGContextSaveGState(context)
        UIRectClip(symbolUnitRect)
        CGContextTranslateCTM(context, symbolUnitRect.origin.x, symbolUnitRect.origin.y)
        CGContextScaleCTM(context, symbolUnitRect.size.width / 200, symbolUnitRect.size.height / 20)

        StyleKitDial.drawCenterText(value: value, label: unit)
        CGContextRestoreGState(context)


        //// Symbol Ring Drawing
        let symbolRingRect = CGRectMake(frame.minX + floor(frame.width * 0.00000 + 0.5), frame.minY + floor(frame.height * 0.00000 + 0.5), floor(frame.width * 1.00000 + 0.5) - floor(frame.width * 0.00000 + 0.5), floor(frame.height * 1.00000 + 0.5) - floor(frame.height * 0.00000 + 0.5))
        CGContextSaveGState(context)
        UIRectClip(symbolRingRect)
        CGContextTranslateCTM(context, symbolRingRect.origin.x, symbolRingRect.origin.y)
        CGContextScaleCTM(context, symbolRingRect.size.width / 200, symbolRingRect.size.height / 200)

        StyleKitDial.drawRing(value: value)
        CGContextRestoreGState(context)
    }

    //// Generated Images

    public class func imageOfRing(value value: CGFloat = 0.14) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 200), false, 0)
            StyleKitDial.drawRing(value: value)

        let imageOfRing = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return imageOfRing
    }

    public class func imageOfDataRing(frame frame: CGRect = CGRectMake(0, 0, 200, 200), data: String = "35", unit: String = "μg/m3", value: CGFloat = 0.14) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
            StyleKitDial.drawDataRing(frame: CGRectMake(0, 0, frame.size.width, frame.size.height), data: data, unit: unit, value: value)

        let imageOfDataRing = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return imageOfDataRing
    }

}
