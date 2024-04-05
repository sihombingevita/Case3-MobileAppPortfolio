//
//  DonutChartCell.swift
//  MobileAppPortfolio
//
//  Created by Evita Sihombing on 30/03/24.
//

import UIKit
import Charts

protocol DonutChartCellDelegate: AnyObject {
    func didSelectData(idx: Int)
}

class DonutChartCell: UITableViewCell, ChartViewDelegate {
    
    @IBOutlet weak var donutView: UIView!
    var donutChartView: PieChartView!
    
    var indexPath: IndexPath?
    
    weak var delegate: DonutChartCellDelegate?
    
    func configure(with data: [Datum], indexPath: IndexPath) {
        self.indexPath = indexPath
        
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
        dataSet.drawValuesEnabled = true
        
        donutChartView.data = PieChartData(dataSet: dataSet)
        donutChartView.holeRadiusPercent = 0.5
        donutChartView.transparentCircleRadiusPercent = 0.52
        
        donutChartView.isUserInteractionEnabled = true
        donutChartView.delegate = self
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupChartView() {
        donutChartView = PieChartView(frame: CGRect(x: 0, y: 0, width: donutView.bounds.width, height: donutView.bounds.height))
        donutView.addSubview(donutChartView)
        donutChartView.center = CGPoint(x: donutView.bounds.midX, y: donutView.bounds.midY)
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let dataSet = chartView.data?.dataSets[highlight.dataSetIndex] else {
            return
        }
        delegate?.didSelectData(idx: Int(highlight.x))
    }
    
}


