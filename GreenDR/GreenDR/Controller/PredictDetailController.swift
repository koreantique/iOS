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


class PredictDetailController: UIViewController, UITextFieldDelegate, ChartViewDelegate {
    

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var elecDataField: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination
        guard let rvc = dest as? PredictReservationController else{ return}
        
        rvc.paramElec = self.elecDataField.text!
    }
    
    func todayDate(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let current_date_string = formatter.string(from: Date()+86400)
        
        timeLabel.text = "\(current_date_string) 전력 생산 예측"
    }

    @IBAction func tapReservationButton(_ sender: Any) {
        self.performSegue(withIdentifier: "PredictReservationSegue", sender: self)
    }
    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .lightGray
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
        todayDate()
        
        lineChartView.legend.textColor = .white
        
        self.elecDataField.text = "46520(KW)"
        
    }
    
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func colorPicker(value : Double) -> NSUIColor {
        if value >= 30{
            return NSUIColor.red
        }
        else{
            return NSUIColor.white
        }
    }
    
    func setData(){
        let set1 = LineChartDataSet(entries: yValues, label: "예측발전량")
        set1.mode = .cubicBezier
        set1.circleRadius = 5
        set1.valueFont = .systemFont(ofSize: 12)
        set1.lineWidth = 5
        set1.setColor(.lightGray)
        set1.fillAlpha = 0.8
        set1.fillColor = .init(red: 180/255.0, green: 204/255.0, blue: 70/255.0, alpha: 1)
        set1.drawFilledEnabled = true
        
        
        let data = LineChartData(dataSet: set1)
        data.setValueTextColor(.white)
        
        lineChartView.data = data
        
        set1.circleHoleRadius = 0
        
        set1.circleColors = set1.entries.map({ (entry: ChartDataEntry) -> NSUIColor in
            return colorPicker(value: entry.y)
        })

    }
    
    let yValues: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 18),
        ChartDataEntry(x: 1.0, y: 19),
        ChartDataEntry(x: 2.0, y: 20),
        ChartDataEntry(x: 3.0, y: 20.3),
        ChartDataEntry(x: 4.0, y: 21),
        ChartDataEntry(x: 5.0, y: 20),
        ChartDataEntry(x: 6.0, y: 19),
        ChartDataEntry(x: 7.0, y: 20.5),
        ChartDataEntry(x: 8.0, y: 22),
        ChartDataEntry(x: 9.0, y: 23),
        ChartDataEntry(x: 10.0, y: 25),
        ChartDataEntry(x: 11.0, y: 27),
        ChartDataEntry(x: 12.0, y: 29),
        ChartDataEntry(x: 13.0, y: 28),
        ChartDataEntry(x: 14.0, y: 30),
        ChartDataEntry(x: 15.0, y: 31),
        ChartDataEntry(x: 16.0, y: 32),
        ChartDataEntry(x: 17.0, y: 35),
        ChartDataEntry(x: 18.0, y: 34),
        ChartDataEntry(x: 19.0, y: 33),
        ChartDataEntry(x: 20.0, y: 34),
        ChartDataEntry(x: 21.0, y: 31),
        ChartDataEntry(x: 22.0, y: 29),
        ChartDataEntry(x: 23.0, y: 27),
        ChartDataEntry(x: 24.0, y: 28),
    ]
    
}
