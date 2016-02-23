# LASS Dial
- LASS Dial 依照目前地理位置與資料項目名稱查詢距離最近測站的最新資料，並加以呈現。
- 支援 iOS 9.0 以上之 iPhone, iPad, iPod touch
- 支援 Today Widget
- 支援 Apple Watch


## 設計說明
- 一致性元素
- 無操作機能
- 通用性設計，不限資料項目

### 最小資訊顯示元素
最小資訊顯示元素用於智慧型手錶等小螢幕，甚至只是用於手錶表面上的單一圖示，如下圖：

![小型資訊顯示圖例](http://www.prodisky.com/LASS/small.png "小型資訊顯示")

- 根據數值上下限，一個環來表示數值大小，數值可超出上下限，唯超出下限時顯示空的環，超出上限時顯示圓滿的環。
- 中間的地方顯示精確的數值，數值底下顯示可選的單位。
- 單位為可選是因為太小的元素還顯示的話，會小到看不清楚，不如別顯示。
- 最小資訊顯示元素在 Apple Watch 上會以單色且有透明度的方式顯示。

完整資訊顯示元素
完整顯示圖用於比較大的畫面上，可以顯示較為詳細的資訊，但是主要的元素也包含最小資訊顯示元素，保持資訊顯示機能的一致性，如下圖：

![完整資訊顯示圖例](http://www.prodisky.com/LASS/full.png "完整資訊顯示")

- 最上方顯示資料名稱。
- 中間圖示與最小資訊顯示元素相同。
- 圖示下方是資料來源測站名稱與測站距離現在位置距離。
- 最底下則為資料更新時間。
- 根據比例顯示成白、綠、黃、紅四種顏色。

### 使用案例
App
![App 使用案例](http://www.prodisky.com/LASS/App.png "LASS Dial App")

Today Widget

![Today Widget 使用案例](http://www.prodisky.com/LASS/widget.png "LASS Dial in Today Widget")

- 在 Today Widget 的使用時，顯示最多三個資料。

Apple Watch
![Apple Watch 使用案例](http://www.prodisky.com/LASS/watch.png "LASS Dial in Apple Watch")


## 使用自己的資料來源

### 資料來源查詢設計需求
- 無參數時列出所有可用資料項目，例如：
http://www.prodisky.com/LASS/  
回傳：  
["PM2.5","PM10","O3","PSI"]
排列順序與 App 的資料顯示順序有關，而 Today Widget 只會顯示前三個，Apple Watch 只會顯示第一個。
- 依照地理位置與資料項目名稱查詢 JSON 格式資料，例如：
http://www.prodisky.com/LASS/?lat=24.169699&lng=120.658836&data=PM2.5  
回傳：
{"DataName":"PM2.5","DataValue":24,"DataMin":0,"Color":"49,207,0,1","DataMax":70,"DataUnit":"μg\/m³","SiteName":"忠明","SiteLat":24.151958,"SiteLng":120.641092,"PublishTime":"2016-02-04 10:00"}
回傳資料說明請參考最後面的資料需求
- 不是所有的測站具備相同的資訊，好比說有的站沒有臭氧(O3)的資料，那上述的查詢，就需要傳回具有 O3 資料的測站中，距離指定坐標最近的測站資料。

### 資料需求
以完整資訊顯示元素來考慮，需要以下資料：
- 資料名稱，例如：PM 2.5
- 目前數值，例如：75
- 數值上限，例如：500
- 數值下限，例如：0
- 單位，例如：μg/m3
- 測站名稱，例如：臺東
- 測站位置經度，例如：121.1504500000
- 測站位置緯度，例如：22.7553580000
- 更新時間，例如：2016/01/23 14:31
- 顯示顏色：以逗點依序分隔為 RGBA 四個部分，其中 RGB 為 0~255 整數，A 為 0~1 浮點數。

### 修改程式
- Data.swift  
將第 15 行程式的 dataURL 改成自己的主機 URL 字串。
private let dataURL	= "http://www.prodisky.com/LASS/"
