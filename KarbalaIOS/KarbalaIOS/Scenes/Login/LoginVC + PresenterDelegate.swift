//
//  LoginVC + Presenter Delegate.swift
//  Amanaksa
//
//  Created by mac on 3/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

typealias PhoneTuple = (code:String,phone:String?)

extension LoginVC:LoginVCPresenterDelegate{
    
    func showError(error: ApiError) {
        
    }
    
    func showLoader() {
        self.showLoaderIndictor()
    }
    
    func hideLoader() {
        self.dismissLoaderIndictor()
    }
    
    func showError(message: String) {
        self.showCustomAlert(bodyMessage: message)
    }
    
    func navigateToVerficationScreen(phoneWithCode: String, userName: String) {
        self.navigateToVerfication(phone: phoneWithCode, name: userName)
    }
    
    func navigateToTermsScreen() {
        self.navigateToTerms()
    }
    
    func navigateToSignupScreen(phoneWithoutCode: String?) {
        let phoneWithCode:PhoneTuple = (countryPicker.selectedCountry.phoneCode,phoneWithoutCode)
        self.performSegue(withIdentifier: AppConstants.AppSegues.fromLoginToSignup.rawValue, sender: phoneWithCode)
    }
    
}
