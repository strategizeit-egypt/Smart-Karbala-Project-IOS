//
//  SignUpVC + Segues.swift
//  KarbalaIOS
//
//  Created by mac on 5/5/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

extension SignUpVC{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstants.AppSegues.fromSignupToVerfication.rawValue{
            let verfiyVC = segue.destination as! VerificationVC
            if let sender = sender as? [String]{
                verfiyVC.phoneNumerWithCode = sender[0]
                verfiyVC.name = sender[1]
            }
         }
    }
    
    func navigateToVerfication(phone:String,name:String){
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.performSegue(withIdentifier: AppConstants.AppSegues.fromSignupToVerfication.rawValue, sender: [phone,name])
    }
    
    func navigateToRegisterationDonePopUp(with user:UserModel){
        let popupVC:RegisterDoneViewController!
        if #available(iOS 13.0, *) {
            popupVC = self.storyboard?.instantiateViewController(identifier: "RegisterDoneViewController") as! RegisterDoneViewController
        } else {
            popupVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterDoneViewController") as! RegisterDoneViewController
        }
        popupVC.delegate = self
        popupVC.user = user
        popupVC.modalPresentationStyle = .overCurrentContext
        self.present(popupVC, animated: true, completion: nil)
    }
    
}

extension SignUpVC:RegisterDoneViewControllerDelegate{
    func didTapOneDoneButton(user: UserModel) {
        self.dismiss(animated: true, completion: nil)
        self.navigateToVerfication(phone: user.phoneNumber, name: user.fullName)
    }
}
