//
//  Date + Extensions.swift
//  Amanaksa
//
//  Created by MacBOOK on 3/16/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
//MARK:- Date
extension Date{
    
    static func formateDateToString(firstFormat:String,secondFormat:String,dateString:String,splitChar:Character=".",toServer:Bool=true,isUTC:Bool=false)->String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = firstFormat
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = secondFormat
        
        let dateAfterSplit = Date.spliteDate(date: dateString, splitChar: splitChar)
        
        if toServer == true{
            newDateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.timeZone = TimeZone.current
            newDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        }else{
            if UIApplication.isRTL(){
                newDateFormatter.locale = Locale(identifier: "ar_EG")
            }else{
                newDateFormatter.locale = Locale(identifier: "en_US")
            }
            
            if isUTC{
                dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                newDateFormatter.timeZone = TimeZone.current
            }
        }
        if UIApplication.isRTL(){
            dateFormatter.locale = Locale(identifier: "ar_EG")
        }else{
            dateFormatter.locale = Locale(identifier: "en_US")
        }
        
        if let date = dateFormatter.date(from: dateAfterSplit){
            return newDateFormatter.string(from: date)
        }else{
            return dateAfterSplit
        }
    }
    
    static func spliteDate(date:String , splitChar:Character)->String{
        let splitData = date.split(separator: splitChar)
        if splitData.count > 1{
            return String(splitData[0])
        }else{
            return date
        }
    }
    
    static func convertDateToString(date:Date , dateFormateString:String = "yyyy-MMM-dd")->String{
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormateString
        formatter.locale = Locale(identifier: "en_US")
        let dateString = formatter.string(from: date)
        return dateString
    }
    
}
