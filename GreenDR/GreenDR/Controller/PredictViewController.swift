//
//  PromotionViewController.swift
//  GreenDR
//
//  Created by 박용범 on 2020/07/21.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit
import Charts
import TinyConstraints

class PredictViewController: UIViewController, ChartViewDelegate {
    

    @IBOutlet weak var timeLabel: UILabel!
    
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .darkGray
        chartView.rightAxis.enabled = false
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 9)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 9)
        chartView.xAxis.setLabelCount(24, force: false)
        chartView.xAxis.labelTextColor = .white

        chartView.animate(xAxisDuration: 2.5)
        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        self.navigationItem.title = "풍력발전 예측정보"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.darkGray]
        
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
        
        setData()
        
        //오늘날짜 표시
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let current_date_string = formatter.string(from: Date())
        print(current_date_string)
        
        timeLabel.text = "\(current_date_string) 전력 생산 예측"
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func setData(){
        let set1 = LineChartDataSet(entries: yValues, label: "예측발전량")
        set1.mode = .cubicBezier
        set1.circleRadius = 3
        set1.setCircleColor(.white)
        set1.valueFont = .systemFont(ofSize: 12)
        set1.lineWidth = 2
        set1.fillAlpha = 0.8
        set1.drawFilledEnabled = true
        let data = LineChartData(dataSet: set1)
        data.setValueTextColor(.white)
        
        lineChartView.data = data
    }
    
    let yValues: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 10.0),
        ChartDataEntry(x: 1.0, y: 5.0),
        ChartDataEntry(x: 2.0, y: 7.0),
        ChartDataEntry(x: 3.0, y: 18.0),
        ChartDataEntry(x: 4.0, y: 12.0),
        ChartDataEntry(x: 5.0, y: 14.0),
        ChartDataEntry(x: 6.0, y: 6.0),
        ChartDataEntry(x: 7.0, y: 3.0),
        ChartDataEntry(x: 8.0, y: 17.0),
        ChartDataEntry(x: 9.0, y: 10.0),
        ChartDataEntry(x: 10.0, y: 14.0),
        ChartDataEntry(x: 11.0, y: 11.0),
        ChartDataEntry(x: 12.0, y: 3.0),
        ChartDataEntry(x: 13.0, y: 19.0),
        ChartDataEntry(x: 14.0, y: 10.0),
        ChartDataEntry(x: 15.0, y: 16.0),
        ChartDataEntry(x: 16.0, y: 10.0),
        ChartDataEntry(x: 17.0, y: 24.0),
        ChartDataEntry(x: 18.0, y: 28.0),
        ChartDataEntry(x: 19.0, y: 41.0),
        ChartDataEntry(x: 20.0, y: 16.0),
        ChartDataEntry(x: 21.0, y: 25.0),
        ChartDataEntry(x: 22.0, y: 27.0),
        ChartDataEntry(x: 23.0, y: 28.0),
        ChartDataEntry(x: 24.0, y: 36.0),
    ]
}
