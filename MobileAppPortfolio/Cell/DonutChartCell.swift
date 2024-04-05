//
//  DonutChartCell.swift
//  MobileAppPortfolio
//
//  Created by Evita Sihombing on 30/03/24.
//

import UIKit
import Charts

protocol DonutChartCellDelegate: AnyObject {
    func didSelectData(datum: PieChartDataEntry, at indexPath: IndexPath)
}

class DonutChartCell: UITableViewCell, ChartViewDelegate {
    
    @IBOutlet weak var donutView: UIView!
    var donutChartView: PieChartView!
    
    var indexPath: IndexPath?
    
    weak var delegate: DonutChartCellDelegate?
    
    func configure(with data: [Datum]) {
        if donutChartView == nil {
            setupChartView()
        }
        
        donutChartView.legend.enabled = true
        donutChartView.highlightPerTapEnabled = true
        donutChartView.animate(xAxisDuration: 1, easingOption: .easeOutBack)
        
        var dataEntries: [PieChartDataEntry] = []
        for datum in data {
            let entry = PieChartDataEntry(value: Double(datum.percentage)!, label: datum.label)
            dataEntries.append(entry)
        }
        
        let dataSet = PieChartDataSet(entries: dataEntries, label: "")
        dataSet.colors = [UIColor.red, UIColor.green, UIColor.brown, UIColor.magenta]
        dataSet.drawValuesEnabled = false
        
        donutChartView.data = PieChartData(dataSet: dataSet)
        donutChartView.holeRadiusPercent = 0.5
        donutChartView.transparentCircleRadiusPercent = 0.52
        
        donutChartView.isUserInteractionEnabled = true
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupChartView() {
        donutChartView = PieChartView(frame: CGRect(x: 0, y: 0, width: donutView.bounds.width, height: donutView.bounds.height))
        donutView.addSubview(donutChartView)
        donutChartView.center = CGPoint(x: donutView.bounds.midX, y: donutView.bounds.midY)
        donutChartView.delegate = self
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("Selected")
        guard let dataSet = chartView.data?.dataSets[highlight.dataSetIndex] else {
            return
        }
        
        let selectedEntry = dataSet.entryForIndex(Int(highlight.x))
        guard let dataSet = chartView.data?.dataSets[highlight.dataSetIndex], let indexPath = indexPath else {
            return
        }
        
        if let pieEntry = selectedEntry as? PieChartDataEntry {
            delegate?.didSelectData(datum: pieEntry, at: indexPath)
        }
    }
    
}


