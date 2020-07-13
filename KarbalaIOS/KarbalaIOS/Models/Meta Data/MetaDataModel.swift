//
//  MetaDataModel.swift
//  Amanaksa
//
//  Created by mac on 3/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct MetaDataModel: Codable {
   let reportStatuses : [ReportStatuses]?
    let reportTypes : [ReportTypes]?
    let settings : [SettingModel]?
    let fileTypes : [FileTypeModel]?
    let citizenTypes : [CitizenTypes]?
    let reportTypeCategories : [ReportTypeCategories]?
    let genders : [Genders]?
    let municipalities : [Municipalities]?
    let countries : [Countries]?
    let governorates : [Countries]?

    enum CodingKeys: String, CodingKey {

        case reportStatuses = "ReportStatuses"
        case reportTypes = "ReportTypes"
        case settings = "Settings"
        case fileTypes = "FileTypes"
        case citizenTypes = "CitizenTypes"
        case reportTypeCategories = "ReportTypeCategories"
        case genders = "Genders"
        case municipalities = "Municipalities"
        case countries = "Countries"
        case governorates = "Governorates"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        reportStatuses = try values.decodeIfPresent([ReportStatuses].self, forKey: .reportStatuses)
        reportTypes = try values.decodeIfPresent([ReportTypes].self, forKey: .reportTypes)
        settings = try values.decodeIfPresent([SettingModel].self, forKey: .settings)
        fileTypes = try values.decodeIfPresent([FileTypeModel].self, forKey: .fileTypes)
        citizenTypes = try values.decodeIfPresent([CitizenTypes].self, forKey: .citizenTypes)
        reportTypeCategories = try values.decodeIfPresent([ReportTypeCategories].self, forKey: .reportTypeCategories)
        genders = try values.decodeIfPresent([Genders].self, forKey: .genders)
        municipalities = try values.decodeIfPresent([Municipalities].self, forKey: .municipalities)
        countries = try values.decodeIfPresent([Countries].self, forKey: .countries)
        governorates = try values.decodeIfPresent([Countries].self, forKey: .governorates)
    }

}
