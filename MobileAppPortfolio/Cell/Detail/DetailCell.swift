//
//  DetailCell.swift
//  MobileAppPortfolio
//
//  Created by Evita Sihombing on 04/04/24.
//

import UIKit
import Charts

class DetailCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    func configure(with detail: Detail) {
          leftLabel.text = detail.trxDate.rawValue
          rightLabel.text = "\(detail.nominal)"
      }
    
}
