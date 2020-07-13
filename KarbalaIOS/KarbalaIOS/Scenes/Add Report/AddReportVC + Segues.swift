//
//  AddReportVC + Segues.swift
//  Amanaksa
//
//  Created by mac on 3/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

extension AddReportVC{
    //MARK:- Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.stopPlayerAndRecorder()
        if segue.identifier == AppConstants.AppSegues.fromAddReportToTerms.rawValue{
            let termsVC = segue.destination as? TermsVC
            termsVC?.delegate = self
        }else if segue.identifier == AppConstants.AppSegues.fromAddReportToReportCategory.rawValue{
            let reportTypeVC = segue.destination as? ReportCategoryVC
            reportTypeVC?.delegate = self
        }
    }
    
    @objc func navigateToTerms(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Terms_screen_title".localized, style: .plain, target: nil, action: nil)
        self.performSegue(withIdentifier: AppConstants.AppSegues.fromAddReportToTerms.rawValue, sender: nil)
    }
}
