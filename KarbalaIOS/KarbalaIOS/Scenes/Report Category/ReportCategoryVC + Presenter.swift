//
//  ReportCategoryVC + Presenter.swift
//  KarbalaIOS
//
//  Created by mac on 5/19/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

extension ReportCategoryVC:ChooseReportCategoryVCPresenterDelegate{
    func didPressSelectButton(selected: ReportTypeCategories) {
        let categoryName =  UIApplication.isRTL() ? selected.nameAR : selected.name
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:categoryName, style: .plain, target: nil, action: nil)
        self.performSegue(withIdentifier: AppConstants.AppSegues.fromReportCategoryToReportSubcategory.rawValue, sender: selected)
    }
    
    
    func showLoader() {
        self.showLoaderIndictor()
    }
    
    func hideLoader() {
        self.dismissLoaderIndictor()
    }
    
    func fetchingDataSuccess() {
        DispatchQueue.main.async {
            if self.presenter.getReportCategoriesCount() == 0{
                self.categoryCollectionView.setEmptyView(errorType: .notFound, message: "no_report_types".localized)
            }else{
                self.categoryCollectionView.restore()
            }
            self.categoryCollectionView.reloadData()
        }
    }
    
    func showError(message: String) {
        self.showCustomAlert(bodyMessage: message)
    }
    
    func showError(error: ApiError) {
        if error == .notFound{
            categoryCollectionView.setEmptyView(errorType: error, message: "no_report_types".localized)
        }else{
            categoryCollectionView.setEmptyView(errorType: error, message: nil)
        }
    }
    
}
