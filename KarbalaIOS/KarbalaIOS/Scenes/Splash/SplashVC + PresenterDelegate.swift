//
//  SplashVC + PresenterDelegate.swift
//  Amanaksa
//
//  Created by mac on 3/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

extension SplashVC:SplashPresenterDelegate{
    
    func navigateToHome() {
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeStart") as? UITabBarController
        UIApplication.shared.windows.first?.rootViewController = homeVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func navigateToLogin() {
        let loginNav = self.storyboard?.instantiateViewController(withIdentifier: "splashNav") as! UINavigationController
        UIApplication.shared.windows.first?.rootViewController = loginNav
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func hideLanguageSegmented() {
        self.isFirstTimeForUserInApp(isFirstTime: false)
    }
    
    func showLanguageSegmented() {
        self.isFirstTimeForUserInApp(isFirstTime: true)
    }
    
    func showError(message: String) {
        self.showDefaultAlert(firstButtonTitle: "retry", secondButtonTitle: "exit", title: "", message: message) { [weak self](retry) in
            guard let self = self else{return}
            if retry{
                self.presenter.viewDidLoad()
            }else{
                exit(0)
            }
        }
    }
    
    func showError(error: ApiError) {
        
    }
    
}

