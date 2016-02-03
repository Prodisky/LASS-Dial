//
//  TodayViewController.swift
//  Today
//
//  Created by Paul Wu on 2016/1/26.
//  Copyright © 2016年 Prodisky Inc. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    override func viewDidLoad() {
        super.viewDidLoad()
		Data.shared.locationManager.requestAlwaysAuthorization()
    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		//Data.shared.Log("TodayViewController viewWillAppear")
		preferredContentSize = CGSize(width: 0, height: 150)
		Data.shared.locationManager.requestLocation()
	}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
		preferredContentSize = CGSize(width: 0, height: 150)
		//Data.shared.Log("TodayViewController viewWillTransitionToSize")
	}
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
	func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
		//Data.shared.Log("TodayViewController widgetMarginInsetsForProposedMarginInsets")
		return UIEdgeInsetsZero
	}
}
