//
//  LoginVCPresenter.swift
//  Amanaksa
//
//  Created by mac on 3/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

protocol LoginVCPresenterDelegate:LoaderDelegate {
    func navigateToVerficationScreen(phoneWithCode:String,userName:String)
    func navigateToTermsScreen()
    func navigateToSignupScreen(phoneWithoutCode:String?)
}

class LoginVCPresenter{
    private let UserInteractor = NetworkService<UserModel>()
    weak var delegate:LoginVCPresenterDelegate?
    
    init(delegate:LoginVCPresenterDelegate) {
        self.delegate = delegate
    }
    
    func registerWithNameAndPhone(countryRegion:String,phoneNumber:String?,isAcceptTerms:Bool){
        
//        guard let fullName = fullName , !fullName.isStringEmpty() else{
//            delegate?.showError(message: "name_is_empty".localized)
//            return
//        }
//
        guard let phoneNumber = phoneNumber , !phoneNumber.isStringEmpty() else{
            delegate?.showError(message: "phone_is_empty".localized)
            return
        }
        
        
        let validationTuple = Helper.validatePhone(region: countryRegion, phoneNumber: phoneNumber)
        
        guard validationTuple.isValid == true else{
            delegate?.showError(message: "phone_is_not_valid".localized)
            return
        }
        
        if isAcceptTerms == false{
            delegate?.navigateToTermsScreen()
            return
        }else{
            self.registerBy(paramters: ["PhoneNumber":validationTuple.phoneWithCode], phoneWithCountryCode: validationTuple.phoneWithoutCountryCode)
        }
        
    }
    
}

//MARK:-Network
extension LoginVCPresenter{
    private func registerBy(paramters:[String:Any],phoneWithCountryCode:String){
        delegate?.showLoader()
        let request = UserRoutes.register(params: paramters)
        UserInteractor.request(request: request, successCompletion: { [weak self](response) in
            self?.delegate?.hideLoader()
            guard let self = self else { return }
            guard let user = response as? UserModel else{return}
            self.delegate?.navigateToVerficationScreen(phoneWithCode: user.phoneNumber, userName: user.fullName)
        }) { [weak self](apiError) in
            self?.delegate?.hideLoader()
            guard let self = self else { return }
            if apiError == .userNotRegisteredBeforeError {
                self.delegate?.navigateToSignupScreen(phoneWithoutCode: phoneWithCountryCode)
            }else{
                self.delegate?.showError(message: apiError.localizedDescription)
            }
        }
    }
}
       
