//
//  DonutChartCell.swift
//  MobileAppPortfolio
//
//  Created by Evita Sihombing on 30/03/24.
//

import UIKit
import Charts

class DonutChartCell: UITableViewCell, ChartViewDelegate {
    
    @IBOutlet weak var donutView: UIView!
    var donutChartView: PieChartView!
    
    func configure(with data: [Datum]) {
        var dataEntries: [PieChartDataEntry] = []
        for datum in data {
            let entry = PieChartDataEntry(value: Double(datum.percentage)!, label: datum.label)
            dataEntries.append(entry)
        }
        
        donutChartView = PieChartView(frame: CGRect(x: 0, y: 0,
                                                    width: self.donutView.frame.size.width, height: self.donutView.frame.size.width))
        self.donutView.addSubview(donutChartView)
        donutChartView.center = donutView.center
        let dataSet = PieChartDataSet(entries: dataEntries, label: "")
        dataSet.colors = [UIColor.red, UIColor.green, UIColor.brown, UIColor.magenta]
        dataSet.drawValuesEnabled = false
        
        donutChartView.data = PieChartData(dataSet: dataSet)
        donutChartView.holeRadiusPercent = 0.5
        donutChartView.transparentCircleRadiusPercent = 0.52
        donutChartView.legend.enabled = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


