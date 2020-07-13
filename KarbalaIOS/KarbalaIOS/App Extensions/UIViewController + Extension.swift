//
//  UIViewController + Extension.swift
//  Amanaksa
//
//  Created by mac on 2/19/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import SwiftMessages
import NVActivityIndicatorView
//MARK:- UIView Controller
extension UIViewController {
   
    
    func showCustomAlert(messageTheme:Theme = .error,titleMessage:String = "Error".localized,bodyMessage:String,position:SwiftMessages.PresentationStyle = .top){
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(messageTheme)
        view.configureDropShadow()
        view.button?.isHidden = true
        view.bodyLabel?.font = UIFont(name: "Cairo-Regular", size: 15)
        view.configureContent(title: titleMessage, body: bodyMessage)
        view.backgroundView.cornerRadius = 10
        
        var config = SwiftMessages.Config()
        config.presentationStyle = position
        config.presentationContext = .window(windowLevel: .alert)
        config.duration = .seconds(seconds: 1)
        config.dimMode = .gray(interactive: true)
        config.interactiveHide = false
        
        SwiftMessages.show(config: config, view: view)
    }
    
    func showDefaultAlert(title:String,message:String){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "ok".localized, style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showDefaultAlertWithOneButton(title:String,message:String,completion:@escaping (Bool)->()){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "ok".localized, style: .default) { (action) in
            completion(true)
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showDefaultAlert(firstButtonTitle:String = "ok",secondButtonTitle:String = "cancel", title:String,message:String,completion:@escaping (Bool)->()){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: firstButtonTitle.localized, style: .default) { (action) in
            completion(true)
        }
        let cancelAction = UIAlertAction.init(title: secondButtonTitle.localized, style: .destructive) { (action) in
            completion(false)
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func topMostViewController() -> UIViewController {
        
        if let presented = self.presentedViewController {
            return presented.topMostViewController()
        }
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }
        
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }
        
        return self
    }
    
    func showLoaderIndictor(backgroundColor:UIColor?=nil){
        let activity = ActivityData.init(size: CGSize.init(width: 60, height: 60), message: nil, messageFont: nil, messageSpacing: nil, type: .ballSpinFadeLoader, color: UIColor.buttonBackgroundColor, padding: 10, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: backgroundColor, textColor: nil)
        DispatchQueue.main.async {
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activity, nil)
        }
    }
    
    func dismissLoaderIndictor(){
        DispatchQueue.main.async {
            if NVActivityIndicatorPresenter.sharedInstance.isAnimating{
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            }
        }
    }
    
    func addBlankView(errorType:ApiError,parentView:UIView,viewColor:UIColor = UIColor.white){
        self.deleteBlankView(parentView: parentView)
        let blankView = UIView.init(frame: self.view.frame)
        blankView.tag = AppConstants.emptyViewTag
        blankView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(blankView)
        
        blankView.backgroundColor = viewColor
        blankView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        blankView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        blankView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        blankView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        
        let errorImageView = UIImageView()
        let messageLabel = UILabel()
        
        errorImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        messageLabel.textColor = UIColor.black
        messageLabel.font = UIFont().regularFont(with: 17)
        
        blankView.addSubview(errorImageView)
        blankView.addSubview(messageLabel)
        
        errorImageView.centerXAnchor.constraint(equalTo: blankView.centerXAnchor).isActive = true
        errorImageView.centerYAnchor.constraint(equalTo: blankView.centerYAnchor).isActive = true
        errorImageView.widthAnchor.constraint(equalToConstant: blankView.frame.width * 0.25).isActive = true
        errorImageView.heightAnchor.constraint(equalToConstant: blankView.frame.width * 0.25).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 16).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: blankView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: blankView.rightAnchor, constant: -20).isActive = true
        
        errorImageView.image = UIImage(named: errorType.errorImage)
        errorImageView.contentMode = .scaleAspectFit
        
        messageLabel.text = errorType.localizedDescription
        messageLabel.numberOfLines = 2
        messageLabel.textAlignment = .center
        
        
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    func deleteBlankView(parentView:UIView){
           if let emptyView = parentView.viewWithTag(AppConstants.emptyViewTag){
               emptyView.removeFromSuperview()
           }
       }
}
