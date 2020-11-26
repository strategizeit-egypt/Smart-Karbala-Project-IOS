//
//  AppConstants.swift
//  Amanaksa
//
//  Created by mac on 2/19/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import CoreLocation
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
    var locations:[CLLocationCoordinate2D] = []

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
    
    func readPointsFromFile(){
        let path = Bundle.main.path(forResource: "KarbalaPoints", ofType: "txt") // file path for file "data.txt"
        do{
            let string = try String(contentsOfFile: path!, encoding: .utf8)
            let locationsArrayInStrings = string.components(separatedBy: .newlines).filter {
                return $0.isStringEmpty() == false
            }
            
            var locations:[CLLocationCoordinate2D] = []
            for locationString in locationsArrayInStrings{
                let location = locationString.components(separatedBy: ",")
                let doubles = location.compactMap(Double.init)
                let coordinate = CLLocationCoordinate2D(latitude: doubles[0], longitude:  doubles[1] )
                locations.append(coordinate)
            }
            self.locations = locations
        }catch{
            print(error.localizedDescription)
        }
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
