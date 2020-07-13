//
//  MoreVC+ PresenterDelegate.swift
//  Amanaksa
//
//  Created by mac on 3/16/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
extension MoreVC:MoreVCPresenterDelegate{
    func didLogout() {
        let loginNav = self.storyboard?.instantiateViewController(withIdentifier: "splashNav") as! UINavigationController
        UIApplication.shared.windows.first?.rootViewController = loginNav
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func displayUserName(name: String) {
        nameTextField.text = name
    }
    
    func didUpdatedSuccessfully(message:String) {
        self.showCustomAlert(messageTheme: .success, titleMessage: "", bodyMessage: message, position: .center)
        isNameEditable(isEditable: false)
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

    func showError(error: ApiError) {
        
    }
    
}
