//
//  AppDelegate.swift
//  KarbalaIOS
//
//  Created by mac on 3/24/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        L102Localizer.DoTheMagic()
        IQKeyboardManager.shared.enable = true
        googleMapsConfiguration()
        FirebaseApp.configure()
        NavigationBarConfiguration()
        AppConstants.shared.readPointsFromFile()
        if AppConstants.shared.isLanguageSelected() == false{
            L102Language.setAppleLAnguageTo(lang: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        
        if #available(iOS 13.0, *) {
            window!.overrideUserInterfaceStyle = .light
        }
        
        return true
    }
    
    func googleMapsConfiguration(){
        GMSServices.provideAPIKey(AppConstants.googleMapsKey)
        GMSPlacesClient.provideAPIKey(AppConstants.googlePlacesKey)
    }
    
    func NavigationBarConfiguration(){
        let navApperance = UINavigationBar.appearance()
        navApperance.backIndicatorImage = UIImage(named: "back")
        navApperance.backIndicatorTransitionMaskImage = UIImage(named: "back")
        navApperance.backgroundColor = UIColor.clear
        navApperance.setBackgroundImage(UIImage(), for: .default)
        navApperance.isTranslucent = true
        navApperance.tintColor = .black
        navApperance.setBackgroundImage(UIImage(), for: .default)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font:UIFont().regularFont(with: 20)], for: .normal)
        
        KarbalaButton.appearance().backgroundColor = UIColor.buttonBackgroundColor

    }

}

