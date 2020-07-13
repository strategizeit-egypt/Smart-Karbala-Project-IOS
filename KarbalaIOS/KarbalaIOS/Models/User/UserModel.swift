//
//  UserModel.swift
//  Amanaksa
//
//  Created by mac on 3/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

// MARK: - Model
struct UserModel: Codable {
    var id: Int
    var fullName, phoneNumber: String
    var vcode: Int
    var expirationVCodeDate: String?
    var verified, enabled: Bool
    var identityID, creationDate: String
    var token: [TokenModel]?
    var email:String?
    var neighborhood:String?
    var dateOfBirth, city, area:String?
    var citizenTypeId,municipalityId,genderId:Int?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case fullName = "FullName"
        case phoneNumber = "PhoneNumber"
        case vcode = "Vcode"
        case expirationVCodeDate = "ExpirationVCodeDate"
        case verified = "Verified"
        case enabled = "Enabled"
        case identityID = "IdentityId"
        case creationDate = "CreationDate"
        case token = "Token"
        case email = "Email"
        case neighborhood = "Neighborhood"
        case dateOfBirth = "DateOfBirth"
        case citizenTypeId = "CitizenTypeId"
        case municipalityId = "MunicipalityId"
        case genderId = "GenderId"
        case city = "City"
        case area = "Area"
    }
}
