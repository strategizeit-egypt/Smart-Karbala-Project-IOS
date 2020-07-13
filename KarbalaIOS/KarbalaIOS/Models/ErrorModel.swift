//
//  ErrorModel.swift
//  Amanaksa
//
//  Created by mac on 3/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct ErrorModel: Codable {
    var message: String?
    var code: Int?
    
    enum CodingKeys: String, CodingKey {
        case message
        case code = "Code"
    }
    
    func mapCodeToApiError()->ApiError{
        switch code {
        case 1:
            return .Phone_Registerd_Before_error
        case 2:
            return .notFound
        case 3:
            return .internalServerError
        case 6:
            return .invalidCodeError
        case 8:
            return .invalidAccessTokenError
        case 9:
            return .completeRegisterError
        case 10:
            return .invalidPhoneNumberError
        case 17:
            return .invalidParamtersError
        case 19,31:
            return .userNotRegisteredBeforeError
        case 20:
            return .invalidPhoneOrEmail
        case 22,42:
            return .userIsDisabledError
        case 23,25:
            return .userNotFoundError
        default: return .internalServerError
        }
    }
}

