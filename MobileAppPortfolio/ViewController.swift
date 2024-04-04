//
//  ViewController.swift
//  MobileAppPortfolio
//
//  Created by Evita Sihombing on 29/03/24.
//
import Charts
import UIKit

class ViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var chartData: [ChartData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = parseChartData(from: "FileChart") {
            chartData = data
            tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "LineChartCell", bundle: nil), forCellReuseIdentifier: "lineChartCell")
        tableView.register(UINib(nibName: "DonutChartCell", bundle: nil), forCellReuseIdentifier: "donutChartCell")
    }
    
    func parseChartData(from file: String) -> [ChartData]? {
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else {
            print("JSON file not found.")
            return nil
        }
        
        do {
            let jsonData = try Data(contentsOf: url)
            let chartData = try JSONDecoder().decode([ChartData].self, from: jsonData)
            tableView.reloadData()
            return chartData
            
        } catch {
            print("Error parsing JSON: \(error)")
            return nil
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return chartData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = chartData[indexPath.section].data
        let model = chartData[indexPath.row].data
        
        if chartData[indexPath.section].type == "donutChart" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "donutChartCell", for: indexPath) as! DonutChartCell
            
            if case let .datumArray(datumArray) = data {
                cell.configure(with: datumArray)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "lineChartCell", for: indexPath) as! LineChartCell
            if case let .dataClass(dataClass) = chartData[indexPath.section].data {
                cell.configure(with: dataClass)
            }
            return cell
        }
    }
}

