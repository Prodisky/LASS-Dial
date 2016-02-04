//
//  ComplicationController.swift
//  Watch Extension
//
//  Created by Paul Wu on 2016/1/26.
//  Copyright © 2016年 Prodisky Inc. All rights reserved.
//

import ClockKit
import WatchKit
class ComplicationController: NSObject, CLKComplicationDataSource {
	private var nextRenewTime = NSDate(timeIntervalSinceNow: 0)
	private var name = ""
	private var data = ""
	private var time = ""
	
	var modularImage = StyleKitDial.imageOfDataRing(frame: WKInterfaceDevice.currentDevice().preferredContentSizeCategory == "UICTContentSizeCategoryL" ? CGRectMake(0, 0, 58, 58) : CGRectMake(0, 0, 52, 52), data: "", unit: "", value: 0)
	var circularImage = StyleKitDial.imageOfDataRing(frame: WKInterfaceDevice.currentDevice().preferredContentSizeCategory == "UICTContentSizeCategoryL" ? CGRectMake(0, 0, 44, 44) : CGRectMake(0, 0, 40, 40), data: "", unit: "", value: 0)
	
    private func renew() {
		if NSDate(timeIntervalSinceNow: 0).timeIntervalSinceDate(nextRenewTime) < 0 { return }
		nextRenewTime = NSDate(timeIntervalSinceNow: 120)
		Data.shared.locationManager.requestLocation()
		
		Data.shared.getItems({(items:[String]) in
			guard let item = items.first else { return }
			Data.shared.getItem(item, got: {(dataItem:Data.Item) in
				self.name = dataItem.dataName
				self.modularImage = StyleKitDial.imageOfDataRing(frame: WKInterfaceDevice.currentDevice().preferredContentSizeCategory == "UICTContentSizeCategoryL" ? CGRectMake(0, 0, 58, 58) : CGRectMake(0, 0, 52, 52), data: dataItem.dataString, unit: dataItem.dataUnit, value: dataItem.dataFraction, colorR: dataItem.colorR, colorG: dataItem.colorG, colorB: dataItem.colorB, colorA: dataItem.colorA)
				self.circularImage = StyleKitDial.imageOfDataRing(frame: WKInterfaceDevice.currentDevice().preferredContentSizeCategory == "UICTContentSizeCategoryL" ? CGRectMake(0, 0, 44, 44) : CGRectMake(0, 0, 40, 40), data: dataItem.dataString, unit: dataItem.dataUnit, value: dataItem.dataFraction, colorR: dataItem.colorR, colorG: dataItem.colorG, colorB: dataItem.colorB, colorA: dataItem.colorA)
				
				self.data = dataItem.dataString + " " + dataItem.dataUnit
				self.time = dataItem.publishTime
			})
		})
	}
	private func getComplicationTemplate(complication: CLKComplication)->CLKComplicationTemplate? {
		renew()
		switch complication.family {
		case .CircularSmall:
			let template = CLKComplicationTemplateCircularSmallRingImage()
			template.imageProvider = CLKImageProvider(onePieceImage: circularImage)
			return template
		case .ModularSmall:
			let template = CLKComplicationTemplateModularSmallSimpleImage()
			template.imageProvider = CLKImageProvider(onePieceImage: modularImage)
			return template
		case .ModularLarge:
			let template = CLKComplicationTemplateModularLargeStandardBody()
			template.headerTextProvider = CLKSimpleTextProvider(text: name)
			template.body1TextProvider = CLKSimpleTextProvider(text: data)
			template.body2TextProvider = CLKSimpleTextProvider(text: time)
			return template
		case .UtilitarianSmall:
			let template = CLKComplicationTemplateUtilitarianSmallFlat()
			template.textProvider = CLKSimpleTextProvider(text: data)
			return template
		case .UtilitarianLarge:
			let template = CLKComplicationTemplateUtilitarianLargeFlat()
			template.textProvider = CLKSimpleTextProvider(text: name + ":" + data)
			return template
		}
	}
	
	// MARK: - Timeline Configuration
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.None])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void)) {
		if let complication = self.getComplicationTemplate(complication) {
			handler(CLKComplicationTimelineEntry(date: NSDate(), complicationTemplate: complication))
		} else {
			handler(nil)
		}
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void)) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        handler(nil);
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
		handler(self.getComplicationTemplate(complication))
    }
	func requestedUpdateDidBegin() {
		if NSDate(timeIntervalSinceNow: 0).timeIntervalSinceDate(nextRenewTime) > 0 {
			renew()
		}
		for complication in CLKComplicationServer.sharedInstance().activeComplications {
			//Data.shared.Log("ComplicationController requestedUpdateDidBegin extend reload TimelineForComplication")
			CLKComplicationServer.sharedInstance().extendTimelineForComplication(complication)
			CLKComplicationServer.sharedInstance().reloadTimelineForComplication(complication)
		}
	}
}
