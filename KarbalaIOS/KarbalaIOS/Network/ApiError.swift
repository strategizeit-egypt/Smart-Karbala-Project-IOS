//
//  ApiError.swift
//  Amanaksa
//
//  Created by mac on 3/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case NetworkError           //Status code 0
    case BadRequest             //Status code 400
    case unauthorized           //Status code 401
    case forbidden              //Status code 403
    case notFound               //Status code 404
    case internalServerError    //Status code 500
    
    case decodingError
    
    
    case Phone_Registerd_Before_error
    case invalidCodeError
    case invalidPhoneNumberError
    case invalidPhoneOrEmail
    case userNotFoundError
    case invalidAccessTokenError
    case completeRegisterError
    case invalidParamtersError
    case userNotRegisteredBeforeError
    case userIsDisabledError
    
    
    var localizedDescription: String{
        switch self {
        case .internalServerError:
            return "Server Error".localized
        case .NetworkError:
            return "Network Error".localized
        case .notFound:
            return "No Data Found".localized
        case .Phone_Registerd_Before_error:
            return "This_Phone_Registerd_Before".localized
        case .invalidAccessTokenError:
            return "Result_invalid_access_token_relogin".localized
        case .completeRegisterError:
            return "Plese_complete_registeration".localized
        case .invalidPhoneNumberError:
            return "Invalide_PhoneNumber".localized
        case .invalidParamtersError:
            return "Result_Invalid_Parametrs".localized
        case .userNotRegisteredBeforeError:
            return "User_not_Register_Yet".localized
        case .invalidPhoneOrEmail:
            return "Invalide_PhoneNumber_Or_Email".localized
        case .userIsDisabledError:
            return "Employee_Is_Disabled_From_Admin".localized
        case .userNotFoundError:
            return "Student_Not_Found".localized
        case .invalidCodeError:
            return "Result_Invalide_code".localized
        default:
            return "".localized
        }
    }
    
    static func mapStatusCodeToError(statusCode:Int)->ApiError{
        switch statusCode {
        case 0: return .NetworkError
        case 400: return .BadRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return .notFound
        default:return .internalServerError
        }
    }
    
    var errorImage:String{
        switch self {
        case .NetworkError:
            return "No Wifi"
        case .internalServerError:
            return "Server Error"
        case .notFound:
            return "Sad Face"
        default:
            return "Server Error".localized
        }
    }
    
    
}
