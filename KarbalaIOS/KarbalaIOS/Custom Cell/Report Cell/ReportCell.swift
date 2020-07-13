//
//  ReportCell.swift
//  Amanaksa
//
//  Created by mac on 2/24/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ReportCell: UICollectionViewCell {
    
    
    @IBOutlet weak var reportTypeLabel: UILabel!
    @IBOutlet weak var reportTitleLabel: UILabel!
    @IBOutlet weak var reportDateLabel: UILabel!
    @IBOutlet weak var reportStatusLabel: UILabel!
    @IBOutlet weak var reportStatusView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if UIApplication.isRTL(){
            reportStatusLabel.textAlignment = .left
        }else{
            reportStatusLabel.textAlignment = .right
        }
    }
    
}

extension ReportCell:ReportCellView{
    
    func displayReportType(reportType: String) {
        reportTypeLabel.text = reportType
    }
    
    func displayDesc(desc: String) {
        reportTitleLabel.text = desc
    }
    
    func displayDate(date: String) {
        reportDateLabel.text = date
    }
    
   func reportViewColor(colorHex: String?) {
        if let color = colorHex{
            reportStatusView.backgroundColor = UIColor.colorFromHexString(color)
            reportStatusView.alpha = 1
        }else{
            reportStatusView.alpha = 0
        }
    }
    
    func displayReportStatus(status: String, colorHex: String) {
        reportStatusLabel.text = status
        reportStatusLabel.textColor = UIColor.colorFromHexString(colorHex)
        
    }
    
}
