//
//  LineChartCell.swift
//  MobileAppPortfolio
//
//  Created by Evita Sihombing on 30/03/24.
//

import UIKit
import Charts

class LineChartCell: UITableViewCell, ChartViewDelegate {
    
    static let identifier = String(describing: LineChartCell.self)
    @IBOutlet weak var lineView: UIView!
    
    var lineChartView: LineChartView!
    
    func configure(with data: DataClass) {
        let months = data.month.map { Double($0) }
        var dataEntries: [ChartDataEntry] = []
        for (index, month) in months.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(index), y: month)
            dataEntries.append(dataEntry)
        }
        
        lineChartView = LineChartView(frame: CGRect(x: 0, y: 0,
                                                    width: self.lineView.frame.size.width,
                                                    height: self.lineView.frame.size.width))
        self.lineView.addSubview(lineChartView)
        
        let dataSet = LineChartDataSet(entries: dataEntries, label: "Line Chart")
        dataSet.colors = [UIColor.blue]
        dataSet.circleColors = [UIColor.blue]
        dataSet.circleHoleColor = UIColor.blue
        dataSet.mode = .cubicBezier
        dataSet.cubicIntensity = 0.2
        dataSet.fillAlpha = 1
        dataSet.fillColor = UIColor.white
        dataSet.drawFilledEnabled = true
        dataSet.drawValuesEnabled = true
        
        dataSet.highlightEnabled = true
        dataSet.highlightColor = UIColor.systemGray
        dataSet.highlightLineWidth = 1.0
        dataSet.drawVerticalHighlightIndicatorEnabled = true
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.circleColors = [UIColor.blue]
        dataSet.circleHoleColor = UIColor.blue
        dataSet.colors = [UIColor.blue]
        dataSet.mode = .cubicBezier
        
        lineChartView.data = LineChartData(dataSet: dataSet)
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Jan", "" ,"Mar", "","Mei", "","Agu", "", "Okt", "", "Des"])
        lineChartView.xAxis.labelCount = 11
        lineChartView.xAxis.forceLabelsEnabled = true
        lineChartView.xAxis.granularity = 1
        lineChartView.center = lineView.center
        
        
        lineChartView.rightAxis.enabled = false
        lineChartView.rightAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.drawAxisLineEnabled = true
        lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.drawBordersEnabled = false
        lineChartView.setScaleEnabled(false)
        lineChartView.legend.enabled = false
        lineChartView.animate(yAxisDuration: 0.5)
        lineChartView.frame = lineView.bounds
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
