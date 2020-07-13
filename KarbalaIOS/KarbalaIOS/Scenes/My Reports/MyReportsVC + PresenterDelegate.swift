//
//  MyReportsVC + PresenterDelegate.swift
//  Amanaksa
//
//  Created by MacBOOK on 3/16/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

extension MyReportsVC:MyReportsVCPresenterDelegate{
    func navigateToDetailsScreen(with id: Int) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Report details".localized, style: .plain, target: nil, action: nil)
        self.performSegue(withIdentifier: AppConstants.AppSegues.fromReportsToDetails.rawValue, sender: id)
    }
    
    func showLoader() {
        DispatchQueue.main.async {
            self.reportsCollectionView.showAnimatedGradientSkeleton()
        }
    }
    
    func hideLoader() {
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        //            self.reportsCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        //            self.reportsCollectionView.stopSkeletonAnimation()
        //        }
        //self.dismissLoaderIndictor()
    }
    
    func fetchingDataSuccess() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.reportsCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            if self.presenter.getReportsCount() == 0{
                self.reportsCollectionView.setEmptyView(errorType: .notFound, message: "no_Reports".localized)
            }else{
                self.reportsCollectionView.restore()
            }
            self.reportsCollectionView.reloadData()
        }
        
        
    }
    
    func showError(message: String) {
        self.reportsCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        self.showCustomAlert(bodyMessage: message)
    }
    
    func showError(error: ApiError) {
        self.reportsCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        if error == .notFound{
            reportsCollectionView.setEmptyView(errorType: error, message: "no_Reports".localized)
        }else{
            reportsCollectionView.setEmptyView(errorType: error, message: nil)
        }
    }
    
}
