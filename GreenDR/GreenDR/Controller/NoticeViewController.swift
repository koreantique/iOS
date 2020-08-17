//
//  NoticeViewController.swift
//  GreenDR
//
//  Created by 박용범 on 2020/07/21.
//  Copyright © 2020 박용범. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SwiftCharts

class NoticeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate var chart: Chart? // arc
    
    let sideSelectorHeight: CGFloat = 50

    fileprivate func chart(horizontal: Bool) -> Chart {
        let labelSettings = ChartLabelSettings(font: ExamplesDefaults.labelFont)
        
        let alpha: CGFloat = 0.6
    
        let color0 = UIColor.gray.withAlphaComponent(alpha)
        let color1 = UIColor.blue.withAlphaComponent(alpha)
        let color2 = UIColor.red.withAlphaComponent(alpha)
        
        let zero = ChartAxisValueDouble(0)
        let barModels = [
            ChartStackedBarModel(constant: ChartAxisValueString("13시", order: 1, labelSettings: labelSettings), start: zero, items: [
                ChartStackedBarItemModel(quantity: 100, bgColor: color0),
                ChartStackedBarItemModel(quantity: 30, bgColor: color2),
                ChartStackedBarItemModel(quantity: 20, bgColor: color1)
                ]),
            ChartStackedBarModel(constant: ChartAxisValueString("14시", order: 2, labelSettings: labelSettings), start: zero, items: [
                ChartStackedBarItemModel(quantity: 100, bgColor: color0),
                ChartStackedBarItemModel(quantity: 35, bgColor: color2),
                ChartStackedBarItemModel(quantity: 30, bgColor: color1)
                ]),
            ChartStackedBarModel(constant: ChartAxisValueString("15시", order: 3, labelSettings: labelSettings), start: zero, items: [
                ChartStackedBarItemModel(quantity: 100, bgColor: color0),
                ChartStackedBarItemModel(quantity: 34, bgColor: color2),
                ChartStackedBarItemModel(quantity: 60, bgColor: color1)
                ])
        ]
        
        let (axisValues1, axisValues2) = (
            stride(from: 0, through: 250, by: 20).map {ChartAxisValueDouble(Double($0), labelSettings: labelSettings)},
            [ChartAxisValueString("", order: 0, labelSettings: labelSettings)] + barModels.map{$0.constant} + [ChartAxisValueString("", order: 5, labelSettings: labelSettings)]
        )
        let (xValues, yValues) = horizontal ? (axisValues1, axisValues2) : (axisValues2, axisValues1)
        
        let xModel = ChartAxisModel(axisValues: xValues, axisTitleLabel: ChartAxisLabel(text: "시간", settings: labelSettings))
        let yModel = ChartAxisModel(axisValues: yValues, axisTitleLabel: ChartAxisLabel(text: "발전량(MW)", settings: labelSettings.defaultVertical()))
        
        let chartFrame = chart?.frame ?? CGRect(x: 0, y: 100, width:360, height: 270)
        
        let chartSettings = ExamplesDefaults.chartSettingsWithPanZoom

        let coordsSpace = ChartCoordsSpaceLeftBottomSingleAxis(chartSettings: chartSettings, chartFrame: chartFrame, xModel: xModel, yModel: yModel)
        let (xAxisLayer, yAxisLayer, innerFrame) = (coordsSpace.xAxisLayer, coordsSpace.yAxisLayer, coordsSpace.chartInnerFrame)
        
        let barViewSettings = ChartBarViewSettings(animDuration: 0.5)
        let chartStackedBarsLayer = ChartStackedBarsLayer(xAxis: xAxisLayer.axis, yAxis: yAxisLayer.axis, innerFrame: innerFrame, barModels: barModels, horizontal: horizontal, barWidth: 40, settings: barViewSettings, stackFrameSelectionViewUpdater: ChartViewSelectorAlpha(selectedAlpha: 1, deselectedAlpha: alpha)) {tappedBar in
            
            guard let stackFrameData = tappedBar.stackFrameData else {return}
            
            let chartViewPoint = tappedBar.layer.contentToGlobalCoordinates(CGPoint(x: tappedBar.barView.frame.midX, y: stackFrameData.stackedItemViewFrameRelativeToBarParent.minY))!
            let viewPoint = CGPoint(x: chartViewPoint.x, y: chartViewPoint.y + 70)
            let infoBubble = InfoBubble(point: viewPoint, preferredSize: CGSize(width: 50, height: 40), superview: self.view, text: "\(stackFrameData.stackedItemModel.quantity)", font: ExamplesDefaults.labelFont, textColor: UIColor.white, bgColor: UIColor.black)
            infoBubble.tapHandler = {
                infoBubble.removeFromSuperview()
            }
            self.view.addSubview(infoBubble)
        }
        
        let settings = ChartGuideLinesDottedLayerSettings(linesColor: UIColor.black, linesWidth: ExamplesDefaults.guidelinesWidth)
        let guidelinesLayer = ChartGuideLinesDottedLayer(xAxisLayer: xAxisLayer, yAxisLayer: yAxisLayer, settings: settings)
        
        return Chart(
            frame: chartFrame,
            innerFrame: innerFrame,
            settings: chartSettings,
            layers: [
                xAxisLayer,
                yAxisLayer,
                guidelinesLayer,
                chartStackedBarsLayer
            ]
        )
    }
    
    fileprivate func showChart(horizontal: Bool) {
        self.chart?.clearView()
        
        let chart = self.chart(horizontal: horizontal)
        view.addSubview(chart.view)
        self.chart = chart
    }

    class DirSelector: UIView {
        
        let horizontal: UIButton
        let vertical: UIButton
        
        weak var controller: NoticeViewController?
        
        fileprivate let buttonDirs: [UIButton : Bool]
        
        init(frame: CGRect, controller: NoticeViewController) {
            
            self.controller = controller
            
            self.horizontal = UIButton()
            self.horizontal.setTitle("수평", for: UIControl.State())
            self.vertical = UIButton()
            self.vertical.setTitle("수직", for: UIControl.State())
            
            self.buttonDirs = [horizontal: true, vertical: false]
            
            super.init(frame: frame)
            
            addSubview(horizontal)
            addSubview(vertical)
            
            for button in [horizontal, vertical] {
                button.titleLabel?.font = ExamplesDefaults.fontWithSize(14)
                button.setTitleColor(UIColor.blue, for: UIControl.State())
                button.addTarget(self, action: #selector(DirSelector.buttonTapped(_:)), for: .touchUpInside)
            }
        }
        
        @objc func buttonTapped(_ sender: UIButton) {
            let horizontal = sender == self.horizontal ? true : false
            controller?.showChart(horizontal: horizontal)
        }
        
        override func didMoveToSuperview() {
            let views = [horizontal, vertical]
            for v in views {
                v.translatesAutoresizingMaskIntoConstraints = false
            }
            
            let namedViews = views.enumerated().map{index, view in
                ("v\(index)", view)
            }
            
            var viewsDict = Dictionary<String, UIView>()
            for namedView in namedViews {
                viewsDict[namedView.0] = namedView.1
            }
            
            let buttonsSpace: CGFloat = Env.iPad ? 20 : 10
            
            let hConstraintStr = namedViews.reduce("H:|") {str, tuple in
                "\(str)-(\(buttonsSpace))-[\(tuple.0)]"
            }
            
            let vConstraits = namedViews.flatMap {NSLayoutConstraint.constraints(withVisualFormat: "V:|[\($0.0)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDict)}
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: hConstraintStr, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDict)
                + vConstraits)
        }
        
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    var ref: DatabaseReference!
    
    @IBOutlet var tableViewMain: UITableView!

    var noticeList = [NoticeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showChart(horizontal: true)
        if let chart = chart {
            let sideSelector = DirSelector(frame: CGRect(x: 270, y: 100, width: view.frame.size.width, height: sideSelectorHeight), controller: self)
            view.addSubview(sideSelector)
        }
        
        self.navigationController?.navigationBar.tintColor = UIColor.darkGray
        self.navigationItem.title = "알림 게시판"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.darkGray]
        // Do any additional setup after loading the view.
        
        tableViewMain.delegate = self
        tableViewMain.dataSource = self
        
        tableViewMain.separatorStyle = UITableViewCell.SeparatorStyle.none

        
        ref = Database.database().reference().child("Notice")
        ref.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount>0{
                self.noticeList.removeAll()
                
                for notices in snapshot.children.allObjects as![DataSnapshot]{
                    let noticeObject = notices.value as? [String: AnyObject]
                    
                    let noticeTitle = noticeObject?["title"]
                    let noticeTime = noticeObject?["time"]
                    let noticeAmount = noticeObject?["amount"]
                    let noticeContents = noticeObject?["contents"]
                    
                    
                    let notice = NoticeModel(title: noticeTitle as! String?, time: noticeTime as! String?, amount: noticeAmount as! String?, contents: noticeContents as! String?)
                    
                    self.noticeList.append(notice)
                }
                self.tableViewMain.reloadData()
            }
        }
    }

    @IBAction func tapPostButton(_ sender: Any) {
        self.performSegue(withIdentifier: "PostingSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "NoticeDetailSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoticeType
        
        let notice: NoticeModel
        
        notice = noticeList[indexPath.row]
        
        cell.titleLabel.text = notice.title
        cell.timeLabel.text = notice.time!
        cell.amountLabel.text = "추가 전력량 : " + notice.amount! + "KW"
        
        return cell
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let destination = segue.destination as? NoticeDetailViewController{
            destination.notice = noticeList[(tableViewMain.indexPathForSelectedRow?.row)!]
        }
    }
}
