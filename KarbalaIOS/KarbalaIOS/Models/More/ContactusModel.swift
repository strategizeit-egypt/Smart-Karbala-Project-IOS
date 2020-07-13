//
//  ContactusModel.swift
//  Amanaksa
//
//  Created by mac on 3/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct ContactusModel: Codable {
    var id: Int?
    var titlle, message: String?
    var citizenID: Int?
    var creationDate: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case titlle = "Titlle"
        case message = "Message"
        case citizenID = "CitizenId"
        case creationDate = "CreationDate"
    }
}
