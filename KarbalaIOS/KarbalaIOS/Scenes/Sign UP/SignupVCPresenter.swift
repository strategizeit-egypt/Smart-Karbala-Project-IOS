//
//  SignupVCPresenter.swift
//  KarbalaIOS
//
//  Created by mac on 5/3/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

protocol SignupVCPresenterDelegate:LoaderDelegate {
    func navigateToDonePopUp(user:UserModel)
    func requiredField()
}

class SignupVCPresenter{
    private let UserInteractor = NetworkService<UserModel>()
    weak var delegate:SignupVCPresenterDelegate?
    private var userTypeId:Int = 2
    private var userGenderId:Int = 1
    
    init(delegate:SignupVCPresenterDelegate) {
        self.delegate = delegate
    }
    
    func setUserType(id:Int){
        userTypeId = id
    }
    
    func setGenderType(id:Int){
        userGenderId = id
    }
    
    func getUserTypeId()->Int{
        return userTypeId
    }
    
    func getUserGenderId()->Int{
        return userGenderId
    }
    
    func register(params:[String:Any],countryRegion:String){
        
        if let fullName = params["FullName"] as? String , fullName.isStringEmpty() {
            delegate?.requiredField()
            return
        }

        guard let phoneNumber = params["PhoneNumber"] as? String , !phoneNumber.isStringEmpty() else{
            delegate?.requiredField()
            return
        }
        
        guard let email = params["Email"] as? String , !email.isStringEmpty() else{
            delegate?.requiredField()
            return
        }
        
        if let dateOfBirth = params["DateOfBirth"] as? String , dateOfBirth.isStringEmpty(){
            delegate?.requiredField()
            return
        }
        
        
        if userTypeId == 1{
            // visitor
            guard let countryId = params["CountryId"] as? Int else{
                delegate?.requiredField()
                return
            }
            
            if countryId == 1{
                guard let _ = params["GovernorateId"] as? Int else{
                    delegate?.requiredField()
                    return
                }
            }
            
        }else{
            // citizen
            guard let _ = params["MunicipalityId"] as? Int else{
                delegate?.requiredField()
                return
            }
            
            if let city = params["City"] as? String , city.isStringEmpty(){
                delegate?.requiredField()
                return
            }
            
            if let neighborhood = params["Neighborhood"] as? String, neighborhood.isStringEmpty(){
                delegate?.requiredField()
                return
            }
        }
        
        
        guard email.validateEmail() else{
            delegate?.showError(message: "Result_Invalid_Email".localized)
            return
        }
        
        let validationTuple = Helper.validatePhone(region: countryRegion, phoneNumber: phoneNumber)
        
        if validationTuple.isValid == false {
            delegate?.showError(message: "phone_is_not_valid".localized)
            return
        }else{
            var paramters = params
            paramters["PhoneNumber"] = validationTuple.phoneWithCode
            paramters["GenderId"] = userGenderId
            registerBy(paramters: paramters)
        }
        
    }
    
}

//MARK:-Network
extension SignupVCPresenter{
    private func registerBy(paramters:[String:Any]){
        delegate?.showLoader()
        let request = UserRoutes.register(params: paramters)
        UserInteractor.request(request: request, successCompletion: { [weak self](response) in
            self?.delegate?.hideLoader()
            guard let self = self else { return }
            guard let user = response as? UserModel else{return}
            self.delegate?.navigateToDonePopUp(user: user)
        }) { [weak self](apiError) in
            self?.delegate?.hideLoader()
            guard let self = self else { return }
            self.delegate?.showError(message: apiError.localizedDescription)
        }
    }
}
 
