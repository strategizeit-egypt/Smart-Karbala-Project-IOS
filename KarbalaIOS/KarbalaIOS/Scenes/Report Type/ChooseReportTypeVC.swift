//
//  ChooseReportTypeVC.swift
//  Amanaksa
//
//  Created by mac on 3/8/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol ChooseReportTypeVcDelegate:NSObjectProtocol {
    func didSelectReportType(type:ReportTypes)
}

class ChooseReportTypeVC: BaseVC {
    
    @IBOutlet weak var reportTypeypeTableView: UITableView!
    @IBOutlet weak var selectButton: UIButton!
    
    internal let cellIdentifier = "RadioCell"
    internal let sectionIdentifier = "MarginSectionCell"
    weak var delegate:ChooseReportTypeVcDelegate?
    var presenter:ChooseReportTypeVCPresenter!
    var reportCategory:ReportTypeCategories?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let reports = reportCategory?.reportTypes{
            presenter = ChooseReportTypeVCPresenter(delegate: self, reportTypes: reports)
        }
        self.changeImageTint()
        setupUI()
    }
    
    
    @IBAction func selectReportType(_ sender:UIButton){
        presenter.selectButtonPressed(selectedIndex: reportTypeypeTableView?.indexPathForSelectedRow?.section)
    }
    
}

//MARK:- Setup UI
extension ChooseReportTypeVC{
    func setupUI(){
        setupTableView()
        selectButton.setTitle("Select".localized, for: .normal)
    }
}


//MARK:- Radio Cell Delegate
extension ChooseReportTypeVC:RadioCellDelegate{
    func didTapRadioButton(cell: RadioCell) {
        if let deselectedIndexPath = reportTypeypeTableView.indexPathForSelectedRow{
            reportTypeypeTableView.deselectRow(at: deselectedIndexPath, animated: true)
            reportTypeypeTableView.cellForRow(at: deselectedIndexPath)?.isSelected = false
        }
        
        guard let indexPath = reportTypeypeTableView.indexPath(for: cell) else{ return }
        reportTypeypeTableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        cell.isSelected = true
    }
}
