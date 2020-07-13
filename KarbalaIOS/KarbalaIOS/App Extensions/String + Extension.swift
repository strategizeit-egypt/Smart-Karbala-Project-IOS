//
//  String + Extension.swift
//  Amanaksa
//
//  Created by mac on 2/19/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

//MARK:- String
extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func localizeStringWithParams(params:[String])->String{
        return String(format: NSLocalizedString(self, comment: ""), arguments: params)
    }
    
    func validateEmail() -> Bool {
        let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var convertArabicNumberToEnglishNumber:String{
        var finalString: String = self
        finalString = finalString.replacingOccurrences(of: "٠", with: "0")
        finalString = finalString.replacingOccurrences(of: "١", with: "1")
        finalString = finalString.replacingOccurrences(of: "٢", with: "2")
        finalString = finalString.replacingOccurrences(of: "٣", with: "3")
        finalString = finalString.replacingOccurrences(of: "٤", with: "4")
        finalString = finalString.replacingOccurrences(of: "٥", with: "5")
        finalString = finalString.replacingOccurrences(of: "٦", with: "6")
        finalString = finalString.replacingOccurrences(of: "٧", with: "7")
        finalString = finalString.replacingOccurrences(of: "٨", with: "8")
        finalString = finalString.replacingOccurrences(of: "٩", with: "9")
        return finalString
    }
    
    static func getPercentage(newPrice:Float,oldPrice:Float)->String{
        if oldPrice > newPrice{
            let percentage = ((oldPrice - newPrice) / oldPrice) * 100
            return String(format: "%0.1f",percentage)
        }
        return String(format: "%0.1f",0)
    }
    
    static func getPercentage(newPrice:Double,oldPrice:Double)->String{
        if oldPrice > newPrice{
            let percentage = ((oldPrice - newPrice) / oldPrice) * 100
            return String("\(Int(percentage))")
        }
        return String(format: "%0.1f",0)
    }
    
    
    
    func isStringEmpty()->Bool{
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}


extension Float {
    func fromatSecondsFromTimer() -> String {
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}

extension TimeInterval{
    
    func MinutesSecondsFromTimeInterval() -> String {
        let time = NSInteger(self)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        return String(format: "%0.2d:%0.2d",minutes,seconds)
    }
}
