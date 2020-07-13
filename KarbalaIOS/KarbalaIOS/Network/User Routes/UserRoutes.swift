//
//  UserRoutes.swift
//  Amanaksa
//
//  Created by mac on 3/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Alamofire
import Foundation

enum UserRoutes:URLRequestBuilder {
    
    case register(params:[String:Any])
    case verify(phoneNumber:String,verficationCode:String)
    
    case getCitizenProfile
    case editFullName(fullName:String)
    case AddContactUs(title:String,body:String)
    case logout
    
    private struct PathsConstants{
        static let register             = "Register"
        static let verify               = "Verify"
        static let getCitizenProfile    = "GetCitizenProfile"
        static let editFullName         = "EditFullName"
        static let addContactUs         = "AddContactUs"
        static let logout               = "Logout"
    }
    
    private struct ParamterConstant{
        static let phoneNumber = "PhoneNumber"
        static let fullName = "FullName"
        
        static let vcode = "vcode"
        
        static let title = "Titlle"
        static let message = "Message"
    }
    
    
    // MARK: - Headers
    var headers:HTTPHeaders{
        var header = HTTPHeaders()
        header[NetworkConstants.HttpHeaderField.contentType.rawValue] = NetworkConstants.ContentType.json.value
        switch self {
        case .getCitizenProfile,.editFullName,.AddContactUs,.logout:
            header[NetworkConstants.HttpHeaderField.authentication.rawValue] = NetworkConstants.ContentType.bearerToken.value
        default: break
        }
        return header
    }
    
    var method: HTTPMethod{
        switch self {
        case .register,.AddContactUs,.editFullName: return .post
        default: return .get
        }
    }
    
    // MARK: - Path
    var path:String{
        switch self {
        case .register:
            return PathsConstants.register
        case .verify:
            return PathsConstants.verify
        case .getCitizenProfile:
            return PathsConstants.getCitizenProfile
        case .editFullName:
            return PathsConstants.editFullName
        case .AddContactUs:
            return PathsConstants.addContactUs
        case .logout:
            return PathsConstants.logout
        }
    }
    
    var parameters: Parameters?{
        var params:Parameters = [:]
        
        switch self {
        case .verify(let phoneNumber,let verficationCode):
            params[ParamterConstant.phoneNumber] = phoneNumber
            params[ParamterConstant.vcode] = verficationCode
        case .register(let paramters):
            params = paramters
        case .AddContactUs(let messageTitle,let messageBody):
            params[ParamterConstant.title] = messageTitle
            params[ParamterConstant.message] = messageBody
        case .editFullName(let fullName):
            params[ParamterConstant.fullName] = fullName
        default: return nil
        }
        
        return  params
    }
    
    
}

//
