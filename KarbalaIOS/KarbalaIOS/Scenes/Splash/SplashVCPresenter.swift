//
//  SplashVcPresenter.swift
//  Amanaksa
//
//  Created by mac on 3/11/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation


protocol SplashPresenterDelegate:ErrorDelegate {
    func navigateToHome()
    func navigateToLogin()
    func hideLanguageSegmented()
    func showLanguageSegmented()
}

class SplashVCPresenter{
    
    private let metaDataInteractor = NetworkService<MetaDataModel>()
    private let UserInteractor = NetworkService<UserModel>()
    weak var delegate:SplashPresenterDelegate?
    
    init(delegate:SplashPresenterDelegate) {
        self.delegate = delegate
    }
    
    func viewDidLoad(){
        ShowSegmentedIfFirstTime()
    }
    
    func didSelectLanguage(){
        getAppMetaData()
    }
    
    private func getUserProfileIfHasToken(){
        if AppUser.shared.checkUserLogin(){
            self.getProfile()
        }else{
            self.delegate?.navigateToLogin()
        }
    }
    
    // 1- Check if user choose a langauge
    // 2- call network request if language is choosen before
    private func ShowSegmentedIfFirstTime(){
        if AppConstants.shared.isLanguageSelected(){
            delegate?.hideLanguageSegmented()
            getAppMetaData()
        }else{
            delegate?.showLanguageSegmented()
        }
    }
    
    
}

//MARK:- Network
extension SplashVCPresenter{
    private func getAppMetaData(){
        let request = MetaDataRoutes.metaData
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 2) {
            self.metaDataInteractor.request(request: request, successCompletion: { [weak self](response) in
                guard let self = self else { return }
                guard let metaData = response as? MetaDataModel else{return}
                AppConstants.shared.appMetaData = metaData
                self.getUserProfileIfHasToken()
            }) { [weak self](apiError) in
                guard let self = self else { return }
                self.delegate?.showError(message: apiError.localizedDescription)
            }
        }
    }
    
    private func getProfile(){
        let request = UserRoutes.getCitizenProfile
        UserInteractor.request(request: request, successCompletion: { [weak self](response) in
            guard let self = self else { return }
            guard var user = response as? UserModel else{return}
            user.token = AppUser.shared.user.token
            AppUser.shared.saveUserData(userObj: user, setToken: false)
            self.delegate?.navigateToHome()
        }) { [weak self](apiError) in
            guard let self = self else { return }
            self.delegate?.showError(message: apiError.localizedDescription)
        }
    }
}
