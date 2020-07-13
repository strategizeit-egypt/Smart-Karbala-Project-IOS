//
//  SignupVC + PresenterDelegate.swift
//  KarbalaIOS
//
//  Created by mac on 5/3/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

extension SignUpVC:SignupVCPresenterDelegate{
    func navigateToDonePopUp(user: UserModel) {
        self.navigateToRegisterationDonePopUp(with: user)
    }
    
    func requiredField() {
        checkEmptyTextFields()
    }
    
    func showError(error: ApiError) {
        self.showCustomAlert(bodyMessage: error.localizedDescription)
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
    
    
}
