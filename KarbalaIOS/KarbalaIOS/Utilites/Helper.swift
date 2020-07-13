//
//  Helper.swift
//  Amanaksa
//
//  Created by mac on 3/8/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
import SKPhotoBrowser
import libPhoneNumber_iOS
import CoreTelephony
class Helper{
    static func showImageInFullScreen(image:UIImage,presenterViewController:UIViewController){
        var images = [SKPhoto]()
        let photo = SKPhoto.photoWithImage(image)// add some UIImage
        images.append(photo)
        
        // 2. create PhotoBrowser Instance, and present from your viewController.
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(0)
        presenterViewController.present(browser, animated: true, completion: {})
    }
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    static func validatePhone(region:String, phoneNumber:String)->(isValid:Bool,phoneWithCode:String,phoneWithoutCountryCode:String){
        let phoneUtil = NBPhoneNumberUtil()
        let phoneNumber = try? phoneUtil.parse(phoneNumber, defaultRegion: region)
        let formattedString: String = try! phoneUtil.format(phoneNumber, numberFormat: .E164)
        guard let phoneWithoutCountryCode = phoneNumber?.nationalNumber else{
            return (false,"","")
        }
        return (phoneUtil.isValidNumber(phoneNumber) , formattedString,"\(phoneWithoutCountryCode)")
    }
    
    static func getAudioUrlFromLocal(with name:String)->URL? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return nil }
        return url
    }
    
    static func getAudioUrlFromServer(with name:String)->URL? {
        guard let url = URL(string: name) else { return nil }
        return url
    }
    
    static func call(phoneNumber:String,viewController:UIViewController){
        let networkInfo = CTTelephonyNetworkInfo()
        
        if  networkInfo.subscriberCellularProvider?.isoCountryCode != nil {
            let url:NSURL = URL(string: "telprompt://\(phoneNumber)")! as NSURL
            if #available(iOS 10, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
            
        }else{
            viewController.showDefaultAlert(title: "Alert".localized, message: "No SIM Inserted".localized)
        }
    }
    
    static func openWhatsApp(phone:String,viewController:UIViewController){
        guard let appURL2 = URL(string: "https://wa.me/\(phone)") else {return}
        
        if UIApplication.shared.canOpenURL(appURL2) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL2, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(appURL2)
            }
        }else {
            
            viewController.showDefaultAlert(title: "Alert".localized, message: "install_whatsapp".localized)
        }
    }
    
    static func openURL(urlString:String){
        guard let url = URL(string: urlString) else {return}
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(url)
            }
        }
        
    }
    
    class func handle401Error(){
        let loginNavVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "splashNav") as? UINavigationController
        
        UIApplication.shared.windows.first?.rootViewController = loginNavVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    static func getValue(by key:String)->String{
        return AppConstants.shared.appMetaData?.settings?.first(where: {
            $0.keyName == key
        })?.valueContent ?? ""
    }
    
    static func showSettingsAlert(message:String,viewController:UIViewController){
        viewController.showDefaultAlert(firstButtonTitle: "Settings".localized, secondButtonTitle: "cancel".localized, title: "Alert".localized, message: message) { (openSettings) in
            if openSettings{
                Helper.openSettings()
            }
        }
    }
    
    static func openSettings(){
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                // Checking for setting is opened or not
            })
        }
    }
    
}
