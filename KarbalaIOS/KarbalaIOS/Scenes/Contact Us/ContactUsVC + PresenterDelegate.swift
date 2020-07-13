//
//  ContactUsVC + Presenter.swift
//  Amanaksa
//
//  Created by MacBOOK on 3/16/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

extension ContactUsVC:ContactusVCPresenterDelegate{
    func didTapWebsiteAppIcon(websiteAppLink: String) {
        Helper.openURL(urlString: websiteAppLink)
    }
    
    func didtapHotLine(hotLineNumber: String) {
        Helper.call(phoneNumber: hotLineNumber, viewController: self)
    }
    
    func displayHotLine(hotLine: String) {
        phoneNumberLabel.text = hotLine
    }
    
    func showError(error: ApiError) {
        
    }
    
    func didSendSuccessfully() {
        self.showCustomAlert(messageTheme: .success, titleMessage: "", bodyMessage: "contact_us_message_sent_successfuly".localized, position: .center)
        self.navigationController?.popViewController(animated: true)
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
    
    func didtapWhatsAppIcon(whatsAppLink: String) {
        Helper.openWhatsApp(phone: whatsAppLink, viewController: self)
    }
    
    func didtapEmailAppIcon(emailAppLink: String) {
        Helper.openURL(urlString: "mailto:\(emailAppLink)")
    }
    
    func didtapTwitterAppIcon(twitterAppLink: String) {
        Helper.openURL(urlString: twitterAppLink)
    }
    
}
