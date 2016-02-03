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
	var dataItem = Dictionary<String, AnyObject>() { didSet { setNeedsDisplay() } }
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
		
		guard let name = dataItem["DataName"] as? String else { return }
		
		guard let dataMin = dataItem["DataMin"] as? CGFloat else { return }
		guard let dataMax = dataItem["DataMax"] as? CGFloat else { return }
		guard let dataValue = dataItem["DataValue"] as? Int else { return }
		let value = (dataMax-dataMin) > 0 ? (CGFloat(dataValue) - dataMin) / (dataMax-dataMin) : 0
		
		guard let unit = dataItem["DataUnit"] as? String else { return }
		
		guard let siteName = dataItem["SiteName"] as? String else { return }
		guard let siteLat = dataItem["SiteLat"] as? Double else { return }
		guard let siteLng = dataItem["SiteLng"] as? Double else { return }
		
		guard let time = dataItem["PublishTime"] as? String else { return }
		
		let siteLocation:CLLocation = CLLocation(latitude: siteLat, longitude: siteLng)
		let station = siteName + String(format: "%.1fKM",siteLocation.distanceFromLocation(Data.shared.location) / 1000)
		
		StyleKitDial.drawDataItem(frame: rect, name: name, data: String(dataValue), unit: unit, value: value, station: station, time: time)
    }
}
