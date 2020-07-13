//
//  ChooseSubDistrictVC + PresenterDelegate.swift
//  KarbalaIOS
//
//  Created by mac on 5/20/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

extension ChooseSubDistrictVC:ChooseSubDistrictVCPresenterDelegate{
    func didPressSelectButton(selected: SubDistrictModel) {
        self.performSegue(withIdentifier: AppConstants.AppSegues.fromSubdistrictsToAddReport.rawValue, sender: selected)
    }
    
    func showLoader() {
        self.showLoaderIndictor()
    }
    
    func hideLoader() {
        self.dismissLoaderIndictor()
    }
    
    func fetchingDataSuccess() {
        subDistrictsTableView.restore(isHasSeperator: false)
        subDistrictsTableView.reloadData()
    }
    
    func showError(message: String) {
        self.showCustomAlert(bodyMessage: message)
    }
    
    func showError(error: ApiError) {
        
        if error == .notFound{
            subDistrictsTableView.setEmptyView(errorType: error, message: "no_districts".localized)
        }else{
            subDistrictsTableView.setEmptyView(errorType: error, message: nil)
        }
    }
    
}
