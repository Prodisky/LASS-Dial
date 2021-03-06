//
//  StyleKitDial.swift
//  LASS Dial
//
//  Created by Paul Wu on 2016/2/4.
//  Copyright (c) 2016 Prodisky Inc. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//



import UIKit

public class StyleKitDial : NSObject {

    //// Drawing Methods

    public class func drawRing(value value: CGFloat = 0.14, colorR: CGFloat = 1, colorG: CGFloat = 1, colorB: CGFloat = 1, colorA: CGFloat = 1) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Color Declarations
        let colorRingBack = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.200)

        //// Variable Declarations
        let expressionAngle: CGFloat = -value * 360
        let expressionColor = UIColor(red: colorR, green: colorG, blue: colorB, alpha: colorA)

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

    public class func drawDataItem(frame frame: CGRect = CGRectMake(0, 0, 240, 320), name: String = "PM 2.5", data: String = "35", unit: String = "μg/m3", value: CGFloat = 0.14, station: String = "臺東 1.4KM", time: String = "2016/01/23 14:31", colorR: CGFloat = 1, colorG: CGFloat = 1, colorB: CGFloat = 1, colorA: CGFloat = 1) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Symbol Time Drawing
        let symbolTimeRect = CGRectMake(frame.minX + floor(frame.width * 0.08333 + 0.5), frame.minY + floor(frame.height * 0.90000 + 0.5), floor(frame.width * 0.91667 + 0.5) - floor(frame.width * 0.08333 + 0.5), floor(frame.height * 0.97500 + 0.5) - floor(frame.height * 0.90000 + 0.5))
        CGContextSaveGState(context)
        UIRectClip(symbolTimeRect)
        CGContextTranslateCTM(context, symbolTimeRect.origin.x, symbolTimeRect.origin.y)
        CGContextScaleCTM(context, symbolTimeRect.size.width / 200, symbolTimeRect.size.height / 24)

        StyleKitDial.drawCenterText(label: time, colorR: colorR, colorG: colorG, colorB: colorB, colorA: colorA)
        CGContextRestoreGState(context)


        //// Symbol Station Drawing
        let symbolStationRect = CGRectMake(frame.minX + floor(frame.width * -0.12500 + 0.5), frame.minY + floor(frame.height * 0.78750 + 0.5), floor(frame.width * 1.12500 + 0.5) - floor(frame.width * -0.12500 + 0.5), floor(frame.height * 0.90000 + 0.5) - floor(frame.height * 0.78750 + 0.5))
        CGContextSaveGState(context)
        UIRectClip(symbolStationRect)
        CGContextTranslateCTM(context, symbolStationRect.origin.x, symbolStationRect.origin.y)
        CGContextScaleCTM(context, symbolStationRect.size.width / 200, symbolStationRect.size.height / 24)

        StyleKitDial.drawCenterText(label: station, colorR: colorR, colorG: colorG, colorB: colorB, colorA: colorA)
        CGContextRestoreGState(context)


        //// Symbol Name Drawing
        let symbolNameRect = CGRectMake(frame.minX + floor(frame.width * -0.33333 + 0.5), frame.minY + floor(frame.height * 0.01875 + 0.5), floor(frame.width * 1.33333 + 0.5) - floor(frame.width * -0.33333 + 0.5), floor(frame.height * 0.16875 + 0.5) - floor(frame.height * 0.01875 + 0.5))
        CGContextSaveGState(context)
        UIRectClip(symbolNameRect)
        CGContextTranslateCTM(context, symbolNameRect.origin.x, symbolNameRect.origin.y)
        CGContextScaleCTM(context, symbolNameRect.size.width / 200, symbolNameRect.size.height / 24)

        StyleKitDial.drawCenterText(label: name, colorR: colorR, colorG: colorG, colorB: colorB, colorA: colorA)
        CGContextRestoreGState(context)


        //// Symbol Ring Drawing
        let symbolRingRect = CGRectMake(frame.minX + floor(frame.width * 0.08333 + 0.5), frame.minY + floor(frame.height * 0.15625 + 0.5), floor(frame.width * 0.91667 + 0.5) - floor(frame.width * 0.08333 + 0.5), floor(frame.height * 0.78125 + 0.5) - floor(frame.height * 0.15625 + 0.5))
        CGContextSaveGState(context)
        UIRectClip(symbolRingRect)
        CGContextTranslateCTM(context, symbolRingRect.origin.x, symbolRingRect.origin.y)

        StyleKitDial.drawDataRing(frame: CGRectMake(0, 0, symbolRingRect.size.width, symbolRingRect.size.height), data: data, unit: unit, value: value, colorR: colorR, colorG: colorG, colorB: colorB, colorA: colorA)
        CGContextRestoreGState(context)
    }

    public class func drawCenterText(label label: String = "PM 2.5", colorR: CGFloat = 1, colorG: CGFloat = 1, colorB: CGFloat = 1, colorA: CGFloat = 1) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()


        //// Variable Declarations
        let expressionColor = UIColor(red: colorR, green: colorG, blue: colorB, alpha: colorA)

        //// Text Drawing
        let textRect = CGRectMake(0, 0, 200, 24)
        let textStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = .Center

        let textFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(19), NSForegroundColorAttributeName: expressionColor, NSParagraphStyleAttributeName: textStyle]

        let textTextHeight: CGFloat = NSString(string: label).boundingRectWithSize(CGSizeMake(textRect.width, CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, textRect);
        NSString(string: label).drawInRect(CGRectMake(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context)
    }

    public class func drawDataRing(frame frame: CGRect = CGRectMake(0, 0, 200, 200), data: String = "35", unit: String = "μg/m3", value: CGFloat = 0.14, colorR: CGFloat = 1, colorG: CGFloat = 1, colorB: CGFloat = 1, colorA: CGFloat = 1) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Symbol Ring Drawing
        let symbolRingRect = CGRectMake(frame.minX + floor(frame.width * 0.00000 + 0.5), frame.minY + floor(frame.height * 0.00000 + 0.5), floor(frame.width * 1.00000 + 0.5) - floor(frame.width * 0.00000 + 0.5), floor(frame.height * 1.00000 + 0.5) - floor(frame.height * 0.00000 + 0.5))
        CGContextSaveGState(context)
        UIRectClip(symbolRingRect)
        CGContextTranslateCTM(context, symbolRingRect.origin.x, symbolRingRect.origin.y)
        CGContextScaleCTM(context, symbolRingRect.size.width / 200, symbolRingRect.size.height / 200)

        StyleKitDial.drawRing(value: value, colorR: colorR, colorG: colorG, colorB: colorB, colorA: colorA)
        CGContextRestoreGState(context)


        //// Symbol Data Drawing
        let symbolDataRect = CGRectMake(frame.minX + floor(frame.width * -1.50000 + 0.5), frame.minY + floor(frame.height * 0.26000 + 0.5), floor(frame.width * 2.50000 + 0.5) - floor(frame.width * -1.50000 + 0.5), floor(frame.height * 0.74000 + 0.5) - floor(frame.height * 0.26000 + 0.5))
        CGContextSaveGState(context)
        UIRectClip(symbolDataRect)
        CGContextTranslateCTM(context, symbolDataRect.origin.x, symbolDataRect.origin.y)
        CGContextScaleCTM(context, symbolDataRect.size.width / 200, symbolDataRect.size.height / 24)

        StyleKitDial.drawCenterText(label: data, colorR: colorR, colorG: colorG, colorB: colorB, colorA: colorA)
        CGContextRestoreGState(context)


        //// Symbol Unit Drawing
        let symbolUnitRect = CGRectMake(frame.minX + floor(frame.width * 0.00000 + 0.5), frame.minY + floor(frame.height * 0.68000 + 0.5), floor(frame.width * 1.00000 + 0.5) - floor(frame.width * 0.00000 + 0.5), floor(frame.height * 0.80000 + 0.5) - floor(frame.height * 0.68000 + 0.5))
        CGContextSaveGState(context)
        UIRectClip(symbolUnitRect)
        CGContextTranslateCTM(context, symbolUnitRect.origin.x, symbolUnitRect.origin.y)
        CGContextScaleCTM(context, symbolUnitRect.size.width / 200, symbolUnitRect.size.height / 24)

        StyleKitDial.drawCenterText(label: unit, colorR: colorR, colorG: colorG, colorB: colorB, colorA: colorA)
        CGContextRestoreGState(context)
    }

    //// Generated Images

    public class func imageOfRing(value value: CGFloat = 0.14, colorR: CGFloat = 1, colorG: CGFloat = 1, colorB: CGFloat = 1, colorA: CGFloat = 1) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 200), false, 0)
            StyleKitDial.drawRing(value: value, colorR: colorR, colorG: colorG, colorB: colorB, colorA: colorA)

        let imageOfRing = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return imageOfRing
    }

    public class func imageOfDataRing(frame frame: CGRect = CGRectMake(0, 0, 200, 200), data: String = "35", unit: String = "μg/m3", value: CGFloat = 0.14, colorR: CGFloat = 1, colorG: CGFloat = 1, colorB: CGFloat = 1, colorA: CGFloat = 1) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
            StyleKitDial.drawDataRing(frame: CGRectMake(0, 0, frame.size.width, frame.size.height), data: data, unit: unit, value: value, colorR: colorR, colorG: colorG, colorB: colorB, colorA: colorA)

        let imageOfDataRing = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return imageOfDataRing
    }

}
