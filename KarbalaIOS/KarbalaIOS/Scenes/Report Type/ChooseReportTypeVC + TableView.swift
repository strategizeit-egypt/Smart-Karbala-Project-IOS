//
//  ChooseReportTypeVC + TableView.swift
//  Amanaksa
//
//  Created by mac on 3/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Table View Data source & Delegate
extension ChooseReportTypeVC:UITableViewDataSource,UITableViewDelegate{
    
    //MARK:- Setup
    func setupTableView(){
        reportTypeypeTableView.backgroundColor = UIColor.clear
        reportTypeypeTableView.delegate = self
        reportTypeypeTableView.dataSource = self
        reportTypeypeTableView.rowHeight = UITableView.automaticDimension
        reportTypeypeTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        reportTypeypeTableView.estimatedRowHeight = 100
        reportTypeypeTableView.rowHeight = UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.getReportTypesCount()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RadioCell
        cell.delegate = self
        presenter.configure(cell: cell, for: indexPath.section, isArabic: UIApplication.isRTL())
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
    }
    
}
