//
//  DataItemView.swift
//  LASS Dial
//
//  Created by Paul Wu on 2016/2/3.
//  Copyright © 2016年 Prodisky Inc. All rights reserved.
//

import UIKit
import CoreLocation

class DataItemView: UIView {
	var dataItem = Data.Item() { didSet { setNeedsDisplay() } }
	override init (frame : CGRect) {
		super.init(frame : frame)
		backgroundColor = UIColor.clearColor()
	}
	convenience init () {
		self.init(frame:CGRect.zero)
	}
	required init(coder aDecoder: NSCoder) {
		fatalError("This class does not support NSCoding")
	}
    override func drawRect(rect: CGRect) {
		super.drawRect(rect)
		let station = dataItem.siteName + String(format: "%.1fKM",dataItem.siteDistance / 1000)
		
		StyleKitDial.drawDataItem(frame: rect, name: dataItem.dataName, data: dataItem.dataString, unit: dataItem.dataUnit, value: dataItem.dataFraction, station: station, time: dataItem.publishTime, colorR: dataItem.colorR, colorG: dataItem.colorG, colorB: dataItem.colorB, colorA: dataItem.colorA)
    }
}
