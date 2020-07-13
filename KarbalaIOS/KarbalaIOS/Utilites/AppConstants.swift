//
//  AppConstants.swift
//  Amanaksa
//
//  Created by mac on 2/19/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

class AppConstants{
    
    static let shared = AppConstants()
    private let userDefaults = UserDefaults.standard
    static let fontName = "DINNextLTW23"
    static let googleMapsKey   = "AIzaSyD5_091TkA9UbakB5hx1nz8NQjqh7bQVBc"
    static let googlePlacesKey = "AIzaSyD5_091TkA9UbakB5hx1nz8NQjqh7bQVBc"
    var appMetaData:MetaDataModel?
    static let emptyTableViewTag = 111
    static let emptyCollectionViewTag = 112
    static let emptyViewTag = 113
    static let serverReportCreationDate = "yyyy-MM-dd'T'HH:mm:ss"
    static let reportCreationDate = "dd MMM yyyy"
    static let birthDateFormate = "yyyy-MM-dd"
    static let commentDate = "dd MMM yyyy h:mm a"
    
    private init(){
        
    }
    
    enum AppConstantsEnum:String{
        case isLanguageSelectedKey
        case regularFont = "Regular"
        case boldFont = "Bold"
        
        var mappingValue:String{
            switch self {
            case .regularFont,.boldFont:
                return fontName.appending("-").appending(self.rawValue)
            default:return ""
            }
        }
    }
    
    enum FileTypes:Int{
        case image = 1
        case audio = 2
    }
    
    enum AppSegues:String{
        case fromLoginToTerms
        case fromLoginToVerfication
        case fromLoginToSignup
        case fromSignupToVerfication

        //More Segues
        case fromMoreToAboutUs
        case fromMoreToContactUs
        case fromMoreToTerms
        case fromMoreToLanguage
        
        //Reports
        case fromReportsToDetails
        
        //Map
        case fromMapToTownships
        
        //districts
        case fromTownshipsToAddReport
        case fromTownshipsToSubdistricts

        //subDistricts
        case fromSubdistrictsToAddReport
        
        //Add Report
        case fromAddReportToTerms
        case fromAddReportToReportCategory
        case fromAddReportToConfirmation
        
        //Report Category
        case fromReportCategoryToReportSubcategory
      
    }
    
    
    
    
}

//MARK:- language Settings
extension AppConstants{
    func isLanguageSelected()->Bool{
        return IsLanguageSelectedKeyFromUserDefaults()
    }
    
    func saveIsLanguageSelectedKeyInUserDefaults(){
        userDefaults.set(true, forKey: AppConstantsEnum.isLanguageSelectedKey.rawValue)
    }
    
    private func IsLanguageSelectedKeyFromUserDefaults()->Bool{
        guard let isSelected =  userDefaults.value(forKey: AppConstantsEnum.isLanguageSelectedKey.rawValue) as? Bool else{
            return false
        }
        return isSelected
    }
    
}
