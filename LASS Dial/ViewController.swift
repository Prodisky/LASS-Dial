//
//  ViewController.swift
//  LASS Dial
//
//  Created by Paul Wu on 2016/1/23.
//  Copyright © 2016年 Prodisky Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	private var dataItemViews:[DataItemView] = []
	private func renewDataItems() {
		Data.shared.getItems({(items:[String]) in
			guard let view = self.view as? UIScrollView else { return }
			let itemX = view.bounds.width * 10 / 320
			let itemWidth = view.bounds.width * 300 / 320
			let itemHeight = view.bounds.width * 400 / 320
			let itemSpace = view.bounds.width * 30 / 320
			var itemY = itemSpace
			
			view.contentSize = CGSizeMake(view.bounds.width , CGFloat(items.count) * (itemHeight + itemSpace) + itemSpace)
			
			for var i = 0; i < items.count; i++ {
				if i >= self.dataItemViews.count {
					let newDataItemView = DataItemView()
					self.dataItemViews.append(newDataItemView)
					view.addSubview(newDataItemView)
				}
				let dataItemView = self.dataItemViews[i]
				dataItemView.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight)
				itemY += (itemHeight + itemSpace)
			}
			for var i = 0; i < items.count; i++ {
				let dataItemView = self.dataItemViews[i]
				Data.shared.getItem(items[i], got: {(dataItem:Data.Item) in
					dataItemView.dataItem = dataItem
				})
			}
			while self.dataItemViews.count > items.count {
				let dataItemView = self.dataItemViews[items.count]
				dataItemView.removeFromSuperview()
				self.dataItemViews.removeAtIndex(items.count)
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
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		Data.shared.locationManager.requestLocation()
	}
}

