//
//  TownshipModel.swift
//  Amanaksa
//
//  Created by mac on 3/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
struct SubDistrictModel : Codable {
    let id : Int?
    let name : String?
    let nameAR : String?
    let descriptionEn : String?
    let descriptionAR : String?
    let municipalityId : Int?

    enum CodingKeys: String, CodingKey {

        case id = "Id"
        case name = "Name"
        case nameAR = "NameAR"
        case descriptionEn = "Description"
        case descriptionAR = "DescriptionAR"
        case municipalityId = "MunicipalityId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        nameAR = try values.decodeIfPresent(String.self, forKey: .nameAR)
        descriptionEn = try values.decodeIfPresent(String.self, forKey: .descriptionEn)
        descriptionAR = try values.decodeIfPresent(String.self, forKey: .descriptionAR)
        municipalityId = try values.decodeIfPresent(Int.self, forKey: .municipalityId)
    }

}
