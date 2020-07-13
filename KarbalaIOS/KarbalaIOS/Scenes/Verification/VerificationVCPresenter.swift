//
//  VerificationVCPresenter.swift
//  Amanaksa
//
//  Created by mac on 3/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

protocol VerificationVCPresenterDelegate:LoaderDelegate {
    func navigateToHomeScreen()
    func didStopTimer(seconds:Int)
    func didUpdateTimer(seconds:Int)
}

class VerificationVCPresenter{
    private let UserInteractor = NetworkService<UserModel>()
    weak var delegate:VerificationVCPresenterDelegate?
    private let TimerSecondsConstant = 60
    lazy private var seconds:Int = TimerSecondsConstant
    weak private var timer:Timer?
    
    init(delegate:VerificationVCPresenterDelegate) {
        self.delegate = delegate
    }
    
    func sendCodeAgain(phoneNumberWithCode:String,fullName:String){
        self.sendCodeAgainFromServer(phone: phoneNumberWithCode, name: fullName)
    }
    
    func verifyCode(phoneNumberWithCode:String,fieldsText:[String]){
        
        if isVerficationCodeValid(strings: fieldsText){
            self.verifyCodeFromServer(phoneWithKey: phoneNumberWithCode, vcode: convertArrayToString(strings: fieldsText))
        }else{
            delegate?.showError(message: "verfication_code_empty".localized)
        }
        
    }
    
    //MARK:- Validation & Conversion
    private func convertArrayToString(strings:[String])->String{
        return strings.reduce("") { (code, string) -> String in
            return code + string
        }
    }
    
    private func isVerficationCodeValid(strings:[String])->Bool{
        for string in strings{
            if string.isStringEmpty() {return false}
        }
        return true
    }
}

//MARK:- Timer
extension VerificationVCPresenter{
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (time) in
            self.updateTimer()
        })
    }
    
    private func updateTimer(){
        seconds -= 1
        if seconds == 0{
            resetTimer()
            delegate?.didStopTimer(seconds:seconds)
        }else{
            delegate?.didUpdateTimer(seconds: seconds)
        }
    }
    
    private func resetTimer(){
        invalidateTimer()
        seconds = TimerSecondsConstant
    }
    
    func invalidateTimer(){
        if let timer = timer{
            timer.invalidate()
        }
    }
}

//MARK:-Network
extension VerificationVCPresenter{
    private func sendCodeAgainFromServer(phone:String,name:String){
        delegate?.showLoader()
        let request = UserRoutes.register(params: ["PhoneNumber":phone])
        UserInteractor.request(request: request, successCompletion: { [weak self](response) in
            self?.delegate?.hideLoader()
            guard let self = self else { return }
            guard let _ = response as? UserModel else{return}
            self.startTimer()
        }) { [weak self](apiError) in
            self?.delegate?.hideLoader()
            guard let self = self else { return }
            self.delegate?.showError(message: apiError.localizedDescription)
        }
    }
    
    private func verifyCodeFromServer(phoneWithKey:String,vcode:String){
        delegate?.showLoader()
        let request = UserRoutes.verify(phoneNumber: phoneWithKey, verficationCode: vcode)
        UserInteractor.request(request: request, successCompletion: { [weak self](response) in
            self?.delegate?.hideLoader()
            guard let self = self else { return }
            guard let user = response as? UserModel else{return}
            AppUser.shared.saveUserData(userObj: user, setToken: true)
            self.delegate?.navigateToHomeScreen()
        }) { [weak self](apiError) in
            self?.delegate?.hideLoader()
            guard let self = self else { return }
            self.delegate?.showError(message: apiError.localizedDescription)
        }
    }
}

