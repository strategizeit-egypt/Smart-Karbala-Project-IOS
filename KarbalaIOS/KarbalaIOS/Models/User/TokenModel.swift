//
//  TokenModel.swift
//  Amanaksa
//
//  Created by mac on 3/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct TokenModel: Codable {
    var accessToken, tokenType: String?
    var expiresIn: Int?
    var userName, issued, expires: String?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case userName
        case issued = ".issued"
        case expires = ".expires"
    }
}
