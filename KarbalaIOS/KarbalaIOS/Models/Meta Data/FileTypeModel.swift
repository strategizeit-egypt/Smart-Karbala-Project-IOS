//
//  FileTypeModel.swift
//  Amanaksa
//
//  Created by mac on 3/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct FileTypeModel: Codable {
   let id : Int?
    let name : String?
    let nameAR : String?

    enum CodingKeys: String, CodingKey {

        case id = "Id"
        case name = "Name"
        case nameAR = "NameAR"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        nameAR = try values.decodeIfPresent(String.self, forKey: .nameAR)
    }
}
