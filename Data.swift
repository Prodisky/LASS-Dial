//
//  Data.swift
//  LASS Dial
//
//  Created by Paul Wu on 2016/2/1.
//  Copyright © 2016年 Prodisky Inc. All rights reserved.
//

import UIKit
import CoreLocation

class Data: NSObject {
	static let shared	= Data()
	
	struct Item {
		var dataName = ""
		var dataMin:CGFloat = 0
		var dataMax:CGFloat = 0
		var dataValue:CGFloat = 0
		var dataString = ""
		var dataFraction:CGFloat = 0
		var dataUnit = ""
		var siteName = ""
		var siteLocation = CLLocation()
		var siteDistance:Double = 0
		var publishTime = ""
		var colorR:CGFloat = 0
		var colorG:CGFloat = 0
		var colorB:CGFloat = 0
		var colorA:CGFloat = 0
	}
	// MARK: -
	private let dataURL	= "http://www.prodisky.com/LASS/"
	//預設位置座標 - 地圖的台灣預設中間點 - 信義鄉
	private(set) var location:CLLocation = CLLocation(latitude: 23.597651, longitude: 120.997932)
	private let defaults = NSUserDefaults()
	
	var locationUpdate:(()->())?
	let locationManager = CLLocationManager()
	
	// MARK: -
	func getItems(got:(([String])->Void)) {
		guard let URL = NSURL(string: dataURL) else { return }
		let request = NSURLRequest(URL: URL)
		let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
		configuration.requestCachePolicy = .ReloadIgnoringLocalAndRemoteCacheData
		let session = NSURLSession(configuration: configuration, delegate:nil, delegateQueue:NSOperationQueue.mainQueue())
		let task = session.dataTaskWithRequest(request, completionHandler: {
			(data, response, error) -> Void in
			guard let gotData = data else { return }
			do {
				let gotObject = try NSJSONSerialization.JSONObjectWithData(gotData, options: .MutableContainers)
				if let items = gotObject as? [String] {
					got(items)
					return
				}
			} catch { }
		})
		task.resume()
	}
	func getItem(data:String, got:((Item)->Void)) {
		guard let URL = NSURL(string:"\(dataURL)?lat=\(self.location.coordinate.latitude)&lng=\(self.location.coordinate.longitude)&data=\(data)") else { return }
		let request = NSURLRequest(URL: URL)
		let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
		configuration.requestCachePolicy = .ReloadIgnoringLocalAndRemoteCacheData
		let session = NSURLSession(configuration: configuration, delegate:nil, delegateQueue:NSOperationQueue.mainQueue())
		let task = session.dataTaskWithRequest(request, completionHandler: {
			(data, response, error) -> Void in
			guard let gotData = data else { return }
			do {
				let gotObject = try NSJSONSerialization.JSONObjectWithData(gotData, options: .MutableContainers)
				if let item = gotObject as? Dictionary<String, AnyObject> {
					guard let dataName = item["DataName"] as? String else { return }
					guard let dataMin = item["DataMin"] as? CGFloat else { return }
					guard let dataMax = item["DataMax"] as? CGFloat else { return }
					guard let dataValue = item["DataValue"] as? CGFloat else { return }
					guard let dataUnit = item["DataUnit"] as? String else { return }
					
					guard let siteName = item["SiteName"] as? String else { return }
					guard let siteLat = item["SiteLat"] as? Double else { return }
					guard let siteLng = item["SiteLng"] as? Double else { return }
					
					guard let publishTime = item["PublishTime"] as? String else { return }
					guard let color = item["Color"] as? String else { return }

					let colorRGBA = color.stringByReplacingOccurrencesOfString(" ", withString: "").componentsSeparatedByString(",")
					
					if colorRGBA.count != 4 { return }
					
					let dataString = dataValue == CGFloat(Int(dataValue)) ? String(Int(dataValue)) : String(dataValue)
					let dataFraction = (dataMax-dataMin) > 0 ? (CGFloat(dataValue) - dataMin) / (dataMax-dataMin) : 0
					let siteLocation:CLLocation = CLLocation(latitude: siteLat, longitude: siteLng)
					let siteDistance = siteLocation.distanceFromLocation(Data.shared.location)
					
					let colorR = CGFloat(Float(colorRGBA[0])!/Float(255))
					let colorG = CGFloat(Float(colorRGBA[1])!/Float(255))
					let colorB = CGFloat(Float(colorRGBA[2])!/Float(255))
					let colorA = CGFloat(Float(colorRGBA[3])!)
					
					got(Item(dataName: dataName, dataMin: dataMin, dataMax: dataMax, dataValue: dataValue, dataString: dataString, dataFraction: dataFraction, dataUnit: dataUnit, siteName: siteName, siteLocation: siteLocation, siteDistance: siteDistance, publishTime: publishTime, colorR: colorR, colorG: colorG, colorB: colorB, colorA: colorA))
					return
				}
			} catch { }
		})
		task.resume()
	}
	// MARK: -
	override init() {
		super.init()
		//若存在上次位置，就不使用預設值
		if let lastLatitude = defaults.objectForKey("lastLatitude") as? String ,
			let lastLongitude = defaults.objectForKey("lastLongitude") as? String {
			location = CLLocation(latitude: Double(lastLatitude)!, longitude: Double(lastLongitude)!)
		}
		
		locationManager.delegate = self
		locationManager.distanceFilter = 10
		locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters	//kCLLocationAccuracyBest
	}
	deinit {
		defaults.synchronize()
	}
}
// MARK: CLLocationManagerDelegate
extension Data : CLLocationManagerDelegate {
	func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let firstLocation = locations.first else { return }
		location = firstLocation

		defaults.setObject("\(location.coordinate.latitude)", forKey: "lastLatitude")
		defaults.setObject("\(location.coordinate.longitude)", forKey: "lastLongitude")
		
		defaults.synchronize()
		if let locationUpdate = self.locationUpdate { locationUpdate() }
	}
	func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
		locationManager.requestLocation()
	}
	func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
		NSLog("  CLLocationManager didFailWithError Error \(error)")
	}
}
