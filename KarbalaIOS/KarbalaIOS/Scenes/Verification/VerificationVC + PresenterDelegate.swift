//
//  VerificationVC + PresenterDelegate.swift
//  Amanaksa
//
//  Created by mac on 3/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

extension VerificationVC:VerificationVCPresenterDelegate{
    
    func showLoader() {
        self.showLoaderIndictor()
    }
    
    func hideLoader() {
        self.dismissLoaderIndictor()
    }
    
    func showError(message: String) {
        self.showCustomAlert(bodyMessage: message)
    }
    
    func navigateToHomeScreen() {
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeStart") as? UITabBarController
        UIApplication.shared.windows.first?.rootViewController = homeVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func didStopTimer(seconds: Int) {
        DispatchQueue.main.async {
            self.verficationTimerLabel.text = "verfication_timer %@".localizeStringWithParams(params: ["\(seconds)"])
            self.sendAgainLabel.isHidden = false
        }
    }
    
    func didUpdateTimer(seconds: Int) {
        DispatchQueue.main.async {
            self.verficationTimerLabel.text = "verfication_timer %@".localizeStringWithParams(params: ["\(seconds)"])
            self.sendAgainLabel.isHidden = true
        }
    }
    
    func showError(error: ApiError) {
        
    }
    
}
