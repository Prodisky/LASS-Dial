//
//  GlanceController.swift
//  Watch Extension
//
//  Created by Paul Wu on 2016/1/26.
//  Copyright © 2016年 Prodisky Inc. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {
	@IBOutlet var nameLabel: WKInterfaceLabel!
	@IBOutlet var ringsImage: WKInterfaceImage!
	@IBOutlet var timeLabel: WKInterfaceLabel!
	
	private func renewDataItems() {
		Data.shared.getItems({(items:[String]) in
			guard let item = items.first else { return }
			Data.shared.getItem(item, got: {(dataItem:Data.Item) in
				self.nameLabel.setText(dataItem.dataName)
				self.ringsImage.setImage(StyleKitDial.imageOfDataRing(frame: CGRectMake(0, 0, 88, 88), data: dataItem.dataString, unit: dataItem.dataUnit, value: dataItem.dataFraction, colorR: dataItem.colorR, colorG: dataItem.colorG, colorB: dataItem.colorB, colorA: dataItem.colorA))
				self.timeLabel.setText(dataItem.publishTime)
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
