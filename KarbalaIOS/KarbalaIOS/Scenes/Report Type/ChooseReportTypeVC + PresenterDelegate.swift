//
//  ChooseReportTypeVC + PresenterDelegate.swift
//  Amanaksa
//
//  Created by mac on 3/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
//

extension ChooseReportTypeVC:ChooseReportTypeVCPresenterDelegate{
    
    func showLoader() {
        self.showLoaderIndictor()
    }
    
    func hideLoader() {
        self.dismissLoaderIndictor()
    }
    
    func fetchingDataSuccess() {
        DispatchQueue.main.async {
            if self.presenter.getReportTypesCount() == 0{
                self.reportTypeypeTableView.setEmptyView(errorType: .notFound, message: "no_report_types".localized)
            }else{
                self.reportTypeypeTableView.restore(isHasSeperator: false)
            }
            self.reportTypeypeTableView.reloadData()
        }
    }
    
    func showError(message: String) {
        self.showCustomAlert(bodyMessage: message)
    }
    
    func showError(error: ApiError) {
        if error == .notFound{
            reportTypeypeTableView.setEmptyView(errorType: error, message: "no_report_types".localized)
        }else{
            reportTypeypeTableView.setEmptyView(errorType: error, message: nil)
        }
    }
    
    func didPressSelectButton(selected: ReportTypes) {
        delegate?.didSelectReportType(type: selected)
    }
    
}
