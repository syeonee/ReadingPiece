//
//  StatisticsViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/20.
//
import UIKit
import Charts
import KeychainSwift

class StatisticsViewController: UIViewController {
    
    
    @IBOutlet weak var bookQuantityLabel: UILabel!
    @IBOutlet weak var readingTimeLabel: UILabel!
    @IBOutlet weak var readingDayLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var previousYearButton: UIButton!
    @IBOutlet weak var nextYearButton: UIButton!
    
    var myReadingInfo: ReadingInfo?
    var myContinuityDay: ContinuityDay?
    
    var months: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    var monthTotal: [Int] = []
    
    var currentYear: Int = 2021
    
    let keychain = KeychainSwift(keyPrefix: Keys.keyPrefix)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartEmptyView()
        setStatisticsInfo()
        getCurrentYear()
        drawYearCharts(year: currentYear)
    }
    
    func chartEmptyView(){
        barChartView.noDataText = "데이터를 불러올 수 없습니다."
        barChartView.noDataFont = .NotoSans(.regular, size: 12)
        barChartView.noDataTextColor = .lightGray
    }
    
    func convertToHourMinute(totalString: String) -> String {
        let total = Int(totalString)
        let hour = (total ?? 0) / 60
        let minute = (total ?? 0) % 60
        if hour == 0 {
            return "\(minute)분"
        }else if minute == 0{
            return "\(hour)시간"
        }
        return "\(hour)시간 \(minute)분"
    }
    
    func setStatisticsInfo(){
        self.showIndicator()
        guard let token = keychain.get(Keys.token) else { return }
        Network.request(req: UserStatisticsRequest(token: token)) { [self] result in
            self.dismissIndicator()
            switch result {
            case .success(let response):
                self.dismissIndicator()
                let result = response.code
                if result == 1000 {
                    DispatchQueue.main.async {
                        if let continuityDay = response.continuityDay, continuityDay.count != 0{
                            myContinuityDay = continuityDay[0]
                        }
                        myReadingInfo = response.readingInfo[0]
                        setStatisticsLabel()
                        setStatisticsAttributedLabel()
                    }
                }
            case .cancel(let cancelError):
                self.dismissIndicator()
                print(cancelError as Any)
            case .failure(let error):
                self.dismissIndicator()
//                print(error as Any)
//                self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.", isCancelActionIncluded: false) {_ in
//                }
            }
        }
    }
    
    func setStatisticsLabel(){
        if let readingInfo = myReadingInfo {
            bookQuantityLabel.text = "\(readingInfo.totalBookQuantity)권"
            readingTimeLabel.text = convertToHourMinute(totalString: readingInfo.totalReadingTime)
        }
        
        if let continuityDay = myContinuityDay {
            readingDayLabel.text = "\(continuityDay.totalReadingDay)일"
        }
    }
    
    func setStatisticsAttributedLabel(){
        let fontSize = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        let attrBookQuantity = NSMutableAttributedString(string: bookQuantityLabel.text!)
        attrBookQuantity.addAttribute(.font, value: fontSize, range: (bookQuantityLabel.text as! NSString).range(of: "권"))
        bookQuantityLabel.attributedText = attrBookQuantity
        
        let attrReadingTime = NSMutableAttributedString(string: readingTimeLabel.text!)
        attrReadingTime.addAttribute(.font, value: fontSize, range: (readingTimeLabel.text as! NSString).range(of: "시간"))
        attrReadingTime.addAttribute(.font, value: fontSize, range: (readingTimeLabel.text as! NSString).range(of: "분"))
        readingTimeLabel.attributedText = attrReadingTime
        
        let attrReadingDay = NSMutableAttributedString(string: readingDayLabel.text!)
        attrReadingDay.addAttribute(.font, value: fontSize, range: (readingDayLabel.text as! NSString).range(of: "일"))
        readingDayLabel.attributedText = attrReadingDay

    }
    
    func getCurrentYear(){
        let formatter_year = DateFormatter()
        formatter_year.dateFormat = "yyyy"
        let current_year_string = formatter_year.string(from: Date())
        currentYear = Int(current_year_string)!
    }
    
    
    func drawYearCharts(year: Int) {
        monthTotal = Array<Int>(repeating: 0, count: 12)
        
        guard let token = keychain.get(Keys.token) else { return }
        Network.request(req: UserGraphRequest(token: token, year: year)) { [self] result in
            switch result {
            case .success(let response):
                self.dismissIndicator()
                let result = response.code
                if result == 1000 {
                    if let monthData = response.monthReadingInfos{
                        DispatchQueue.main.async {
                            for data in monthData {
                                monthTotal[data.date-1] = Int(data.sum)!
                            }
                            yearLabel.text = "\(year)"
                            setChart(dataPoints: months, values: monthTotal)
                        }
                    }
                }
                
            case .cancel(let cancelError):
                self.dismissIndicator()
                print(cancelError as Any)
            case .failure(let error):
                self.dismissIndicator()
//                print(error as Any)
//                self.presentAlert(title: "서버와의 연결이 원활하지 않습니다.", isCancelActionIncluded: false) {_ in
//                }
            }
        }

    }
    
    func setChart(dataPoints: [String], values: [Int]) {
        // 데이터 생성
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "월")
        
        // 차트 컬러
        chartDataSet.colors = [#colorLiteral(red: 1, green: 0.4235294118, blue: 0.3725490196, alpha: 1)]
        
        // 데이터 삽입
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.barWidth = 0.55
        barChartView.data = chartData
        
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        
        chartDataSet.drawValuesEnabled = false
        // 줌 안되게
        barChartView.doubleTapToZoomEnabled = false
        
        // X축 레이블 위치 조정
        barChartView.xAxis.labelPosition = .bottom
        // X축 레이블 포맷 지정
        barChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        
        
        // X축 레이블 갯수 최대로 설정 (이 코드 안쓸 시 Jan Mar May 이런식으로 띄엄띄엄 조금만 나옴)
        barChartView.xAxis.setLabelCount(dataPoints.count, force: false)
        
        // 오른쪽 레이블 제거
        barChartView.rightAxis.enabled = false
        barChartView.leftAxis.enabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.xAxis.drawGridLinesEnabled = false
        //barChartView.setExtraOffsets(left: 0, top: 0, right: 0, bottom: 5)
        barChartView.legend.drawInside = false
        barChartView.legend.xOffset = -5
        barChartView.legend.yOffset = 10
        barChartView.legend.verticalAlignment = .top
        
        // 기본 애니메이션
        barChartView.animate(xAxisDuration: 1.8, yAxisDuration: 1.8)
        
    }
    @IBAction func previousYearButtonTapped(_ sender: Any) {
        currentYear -= 1
        drawYearCharts(year: currentYear)
    }
    @IBAction func nextYearButtonTapped(_ sender: Any) {
        currentYear += 1
        drawYearCharts(year: currentYear)
    }
    
}
