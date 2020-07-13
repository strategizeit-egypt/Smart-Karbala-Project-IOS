//
//  SettingModel.swift
//  Amanaksa
//
//  Created by mac on 3/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct SettingModel: Codable {
    var id: Int
    var keyName: String?
    var valueContent: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case keyName = "KeyName"
        case valueContent = "ValueContent"
    }
}
