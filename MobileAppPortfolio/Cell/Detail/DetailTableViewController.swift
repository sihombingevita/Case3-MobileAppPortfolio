//
//  DetailTableViewController.swift
//  MobileAppPortfolio
//
//  Created by Evita Sihombing on 05/04/24.
//

import UIKit
import Charts

class DetailTableViewController: UITableViewController {
    var selectedDatum: Datum? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: "detailCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDatum?.details.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailCell
        
        if let detail = selectedDatum?.details[indexPath.row] {
            cell.configure(with: detail)
        }
        return cell
    }
}
