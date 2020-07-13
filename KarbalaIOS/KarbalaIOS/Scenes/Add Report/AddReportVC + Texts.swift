//
//  AddReportVC + Texts.swift
//  Amanaksa
//
//  Created by mac on 3/15/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Setup
extension AddReportVC{
    func setupTextView(){
        reportDescTextView.backgroundColor = .white
        reportDescTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        addActionToChooseReportTypeLabel()
    }
    
    func addActionToChooseReportTypeLabel(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapReportType))
        tapGesture.numberOfTapsRequired = 1
        reportTypeLabel.isUserInteractionEnabled = true
        reportTypeLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapReportType(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Choose_report_type".localized, style: .plain, target: nil, action: nil)
        self.performSegue(withIdentifier: AppConstants.AppSegues.fromAddReportToReportCategory.rawValue, sender: nil)
    }
    
//    func setupTextFields(){
//        [reportTypeTextField].forEach {
//            $0?.delegate = self
//            if UIApplication.isRTL(){
//                $0?.leftPadding = 20
//                $0?.setLeftPaddingPoints(0)
//            }else{
//                $0?.rightPadding = 20
//                $0?.setLeftPaddingPoints(20)
//            }
//        }
//    }
}

//MARK:-Text Fields Delegate
extension AddReportVC:UITextFieldDelegate{
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//         if textField == reportTypeTextField{
//            self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Choose_report_type".localized, style: .plain, target: nil, action: nil)
//            self.performSegue(withIdentifier: AppConstants.AppSegues.fromAddReportToReportCategory.rawValue, sender: nil)
//        }
//        return false
//    }
}
