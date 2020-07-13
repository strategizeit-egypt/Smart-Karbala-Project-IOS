//
//  ChooseTownShipVC + PresenterDelegate.swift
//  Amanaksa
//
//  Created by mac on 3/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

extension ChooseDistrictVC:ChooseDistrictVCPresenterDelegate{
    func didPressSelectButton(selected: Municipalities) {
        guard let subDistricts = selected.townships else{return}
        if subDistricts.count > 1{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"area".localized, style: .plain, target: nil, action: nil)
            self.performSegue(withIdentifier: AppConstants.AppSegues.fromTownshipsToSubdistricts.rawValue, sender: subDistricts)
        }else if subDistricts.count == 1{
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back".localized, style: .plain, target: nil, action: nil)
            self.performSegue(withIdentifier: AppConstants.AppSegues.fromTownshipsToAddReport.rawValue, sender: subDistricts.first!)
        }
    }
    
    func showLoader() {
        self.showLoaderIndictor()
    }
    
    func hideLoader() {
        self.dismissLoaderIndictor()
    }
    
    func fetchingDataSuccess() {
        DispatchQueue.main.async {
            if self.presenter.getDistrictsCount() == 0{
                self.districtsTableView.setEmptyView(errorType: .notFound, message: "no_districts".localized)
            }else{
                self.districtsTableView.restore(isHasSeperator: false)
            }
            self.districtsTableView.reloadData()
        }
    }
    
    func showError(message: String) {
        self.showCustomAlert(bodyMessage: message)
    }
    
    func showError(error: ApiError) {
        
        if error == .notFound{
            districtsTableView.setEmptyView(errorType: error, message: "no_districts".localized)
        }else{
            districtsTableView.setEmptyView(errorType: error, message: nil)
        }
    }
    
}
