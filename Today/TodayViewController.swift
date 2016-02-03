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
	@IBOutlet weak var centerView: UIView!
	private var dataItemViews:[DataItemView] = []
	private func renewDataItems() {
		Data.shared.getItems({(items:[String]) in
			let count = items.count > 3 ? 3 : items.count
			var itemX = count == 1 ? CGFloat(109) : count == 2 ? CGFloat(55) : CGFloat(0)
			for var i = 0; i < count; i++ {
				if i >= self.dataItemViews.count {
					let newDataItemView = DataItemView()
					self.dataItemViews.append(newDataItemView)
					self.centerView.addSubview(newDataItemView)
				}
				let dataItemView = self.dataItemViews[i]
				dataItemView.frame = CGRectMake(itemX, 0, 102, 136)
				itemX += 109
			}
			for var i = 0; i < count; i++ {
				let dataItemView = self.dataItemViews[i]
				Data.shared.getData(items[i], got: {(dataItem:Dictionary<String, AnyObject>) in
					dataItemView.dataItem = dataItem
				})
			}
			while self.dataItemViews.count > count {
				let dataItemView = self.dataItemViews[count]
				dataItemView.removeFromSuperview()
				self.dataItemViews.removeAtIndex(count)
			}
		})
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		Data.shared.locationUpdate = {
			self.renewDataItems()
		}
		Data.shared.locationManager.requestAlwaysAuthorization()
		renewDataItems()
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
