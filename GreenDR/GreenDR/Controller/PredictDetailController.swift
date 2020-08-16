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


class PredictDetailController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, ChartViewDelegate {
    
    let ad = UIApplication.shared.delegate as? AppDelegate
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var elecField: UITextField!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var elecDataField: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination
        guard let rvc = dest as? PredictReservationController else{ return}
        
        rvc.paramElec = self.elecDataField.text!
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priorityTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priorityTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPriority = priorityTypes[row]
        textField.text = selectedPriority
    }
    
    
    func todayDate(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let current_date_string = formatter.string(from: Date()+86400)
        
        timeLabel.text = "\(current_date_string) 전력 생산 예측"
    }

    
    var selectedPriority: String?
    
    var priorityTypes = ["00:00", "01:00", "02:00", "03:00", "04:00", "05:00", "06:00", "07:00", "08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00"]
    
    func createPickerView(){
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        //textField.inputView = pickerView
    }
    
    func dismissPickerView(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        toolBar.setItems([doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        //textField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
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
        
        createPickerView()
        dismissPickerView()
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
        
        self.elecDataField.text = "462(KW)"
        
    }
    
    
    
    @IBAction func tapReservationButton(_ sender: Any) {
//        if (textField.text == "" || elecField.text == ""){
//            showAlert(title: "알림", message: "모두 입력하세요")
//        }
//        else {
//            ad?.paramTime = textField.text
//            ad?.paramElec = textField.text
//            showAlert(title: "알림", message: "예약이 완료되었습니다.")
//        }
    }
    
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: {action in
            print("tapped Dismiss")
        }))
        
        present(alert, animated: true)
    }
    
    

    
    
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
    
    func colorPicker(value : Double) -> NSUIColor {
        if value > 20{
            return NSUIColor.red
        }
        else{
            return NSUIColor.white
        }
    }
    
    func sizePicker(value : Double) -> Int {
        if value > 35{
            return 5
        } else{
            return 3
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
        ChartDataEntry(x: 0.0, y: 3),
        ChartDataEntry(x: 1.0, y: 3.5),
        ChartDataEntry(x: 2.0, y: 3.7),
        ChartDataEntry(x: 3.0, y: 4),
        ChartDataEntry(x: 4.0, y: 4.5),
        ChartDataEntry(x: 5.0, y: 5),
        ChartDataEntry(x: 6.0, y: 6.0),
        ChartDataEntry(x: 7.0, y: 10),
        ChartDataEntry(x: 8.0, y: 15),
        ChartDataEntry(x: 9.0, y: 21),
        ChartDataEntry(x: 10.0, y: 23),
        ChartDataEntry(x: 11.0, y: 26),
        ChartDataEntry(x: 12.0, y: 29),
        ChartDataEntry(x: 13.0, y: 36),
        ChartDataEntry(x: 14.0, y: 39),
        ChartDataEntry(x: 15.0, y: 37),
        ChartDataEntry(x: 16.0, y: 43),
        ChartDataEntry(x: 17.0, y: 40),
        ChartDataEntry(x: 18.0, y: 29),
        ChartDataEntry(x: 19.0, y: 27),
        ChartDataEntry(x: 20.0, y: 22),
        ChartDataEntry(x: 21.0, y: 16),
        ChartDataEntry(x: 22.0, y: 11),
        ChartDataEntry(x: 23.0, y: 13),
        ChartDataEntry(x: 24.0, y: 15),
    ]
    
}
