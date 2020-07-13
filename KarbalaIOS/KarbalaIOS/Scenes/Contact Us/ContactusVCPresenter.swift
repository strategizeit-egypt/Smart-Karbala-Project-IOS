//
//  ContactusVCPresenter.swift
//  Amanaksa
//
//  Created by MacBOOK on 3/16/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

protocol ContactusVCPresenterDelegate:LoaderDelegate {
    func didSendSuccessfully()
    func displayHotLine(hotLine:String)
    func didtapWhatsAppIcon(whatsAppLink:String)
    func didtapEmailAppIcon(emailAppLink:String)
    func didtapTwitterAppIcon(twitterAppLink:String)
    func didTapWebsiteAppIcon(websiteAppLink:String)
    func didtapHotLine(hotLineNumber:String)
}

class ContactusVCPresenter{
    private let userInteractor = NetworkService<ContactusModel>()
    weak var delegate:ContactusVCPresenterDelegate?
    private var whatsAppNumber:String = ""
    private var hotLineNumber:String = ""
    private var email:String = ""
    private var twitter:String = ""
    private var website:String = ""

    init(delegate:ContactusVCPresenterDelegate) {
        self.delegate = delegate
        whatsAppNumber = Helper.getValue(by: "whatsapp")
        hotLineNumber = Helper.getValue(by: "hotline")
        email = Helper.getValue(by: "email")
        twitter = Helper.getValue(by: "twitter")
        delegate.displayHotLine(hotLine: hotLineNumber)
        website = Helper.getValue(by: "website")
    }
    
    func validateContactusParamters(title:String?,body:String?){
        
        guard let title = title , !title.isStringEmpty() else{
            delegate?.showError(message: "message_title_is_empty".localized)
            return
        }
        
        guard let body = body , !body.isStringEmpty() else{
            delegate?.showError(message: "message_body_is_empty".localized)
            return
        }
        
        self.contactUs(title:title,body:body)
    }
    
    func tapWhatsAppIcon(){
        delegate?.didtapWhatsAppIcon(whatsAppLink: whatsAppNumber)
    }
    
    func tapEmailIcon(){
        delegate?.didtapEmailAppIcon(emailAppLink: email)
    }
    
    func tapTwitterIcon(){
        delegate?.didtapTwitterAppIcon(twitterAppLink: twitter)
    }
    
    func tapHotLine(){
        delegate?.didtapHotLine(hotLineNumber: hotLineNumber)
    }
    
    func tapWebsite(){
        delegate?.didTapWebsiteAppIcon(websiteAppLink: website)
    }
    
}

extension ContactusVCPresenter{
    private func contactUs(title:String,body:String){
        delegate?.showLoader()
        let request = UserRoutes.AddContactUs(title:title,body:body)
        userInteractor.request(request: request, successCompletion: { [weak self](response) in
            self?.delegate?.hideLoader()
            guard let self = self else{return}
            guard let result = response as? ContactusModel else{return}
            self.delegate?.didSendSuccessfully()
        }) { [weak self](error) in
            self?.delegate?.hideLoader()
            guard let self = self else{return}
            self.delegate?.showError(message:error.localizedDescription)
        }
    }
}
