//
//  InterfaceController.swift
//  Watch Extension
//
//  Created by Paul Wu on 2016/1/26.
//  Copyright © 2016年 Prodisky Inc. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
	@IBOutlet var nameLabel: WKInterfaceLabel!
	@IBOutlet var ringsImage: WKInterfaceImage!
	@IBOutlet var stationLabel: WKInterfaceLabel!
	@IBOutlet var timeLabel: WKInterfaceLabel!
	
	private func renewDataItems() {
		Data.shared.getItems({(items:[String]) in
			guard let item = items.first else { return }
			Data.shared.getData(item, got: {(dataItem:Dictionary<String, AnyObject>) in
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
				
				self.nameLabel.setText(name)
				self.ringsImage.setImage(StyleKitDial.imageOfDataRing(frame: CGRectMake(0, 0, 88, 88), data: String(dataValue), unit: unit, value: value))
				self.stationLabel.setText(siteName + String(format: "%.1fKM",siteLocation.distanceFromLocation(Data.shared.location) / 1000))
				self.timeLabel.setText(time)
			})
		})
	}
	
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
		Data.shared.locationManager.requestLocation()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
	override init() {
		super.init()
		Data.shared.locationUpdate = {
			self.renewDataItems()
		}
		Data.shared.locationManager.requestAlwaysAuthorization()
		renewDataItems()
	}
}
