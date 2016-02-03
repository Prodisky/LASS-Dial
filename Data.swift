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
				if let dataItems = gotObject as? [String] {
					got(dataItems)
					return
				}
			} catch { }
		})
		task.resume()
	}
	func getData(data:String, got:((Dictionary<String, AnyObject>)->Void)) {
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
				if let items = gotObject as? Dictionary<String, AnyObject> {
					got(items)
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
