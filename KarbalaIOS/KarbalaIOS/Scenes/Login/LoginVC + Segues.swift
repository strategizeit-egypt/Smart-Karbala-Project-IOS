//
//  LoginVC + Segues.swift
//  Amanaksa
//
//  Created by mac on 3/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

extension LoginVC{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == AppConstants.AppSegues.fromLoginToTerms.rawValue{
             let termsVC = segue.destination as? TermsVC
             termsVC?.delegate = self
         }else if segue.identifier == AppConstants.AppSegues.fromLoginToVerfication.rawValue{
            let verfiyVC = segue.destination as! VerificationVC
            if let sender = sender as? [String]{
                verfiyVC.phoneNumerWithCode = sender[0]
                verfiyVC.name = sender[1] 
            }
         }else if segue.identifier == AppConstants.AppSegues.fromLoginToSignup.rawValue{
            let signupVC = segue.destination as! SignUpVC
            if let tuple = sender as? PhoneTuple{
                signupVC.phoneNumber = tuple.phone
                signupVC.countryCode = tuple.code
            }
        }
    }
    
    @objc func navigateToTerms(){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Terms_screen_title".localized, style: .plain, target: nil, action: nil)
        self.performSegue(withIdentifier: AppConstants.AppSegues.fromLoginToTerms.rawValue, sender: nil)
    }
    
    func navigateToVerfication(phone:String,name:String){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "back".localized, style: .plain, target: nil, action: nil)
        self.performSegue(withIdentifier: AppConstants.AppSegues.fromLoginToVerfication.rawValue, sender: [phone,name])
    }
    
}
