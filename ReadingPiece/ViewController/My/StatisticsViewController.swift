//
//  StatisticsViewController.swift
//  ReadingPiece
//
//  Created by SYEON on 2021/03/20.
//

import UIKit
import Charts

class StatisticsViewController: UIViewController {
    
    
    @IBOutlet weak var bookQuantityLabel: UILabel!
    @IBOutlet weak var readingTimeLabel: UILabel!
    @IBOutlet weak var readingDayLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var previousYearButton: UIButton!
    @IBOutlet weak var nextYearButton: UIButton!
    
    var months: [String]!
    var monthTotal: [Int]!
    
    var currentYear: Int = 2021
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentYear()
        
        drawYearCharts(year: currentYear)
    }
    
    func getCurrentYear(){
        let formatter_year = DateFormatter()
        formatter_year.dateFormat = "yyyy"
        let current_year_string = formatter_year.string(from: Date())
        currentYear = Int(current_year_string)!
        print("현재 연도 : \(currentYear)")
    }
    
    
    func drawYearCharts(year: Int) {
        yearLabel.text = "\(year)"
        months = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
        monthTotal = [10, 4, 6, 3, 12, 16, 0, 18, 2, 4, 5, 4]
        
        barChartView.noDataText = "데이터가 없습니다."
        barChartView.noDataFont = .systemFont(ofSize: 20)
        barChartView.noDataTextColor = .lightGray
        
        setChart(dataPoints: months, values: monthTotal)
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

