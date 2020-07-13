//
//  ReportDetailsModel.swift
//  Amanaksa
//
//  Created by mac on 3/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct ReportDetailsModel: Codable {
    var id: Int?
    var title, details: String?
    var reportTypeID, reportStatusID: Int?
    var creationDate: String?
    var citizenID, townshipID: Int?
    var longitude, latitude, duration: Double?
    var reportStatusName, reportStatusNameAR, reportTypeName, reportTypeNameAR: String?
    var color: String?
    var reportFiles: [ReportFileModel]?
    let reportLogs : [ReportLogs]?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case title = "Title"
        case details = "Details"
        case reportTypeID = "ReportTypeId"
        case reportStatusID = "ReportStatusId"
        case creationDate = "CreationDate"
        case citizenID = "CitizenId"
        case townshipID = "TownshipId"
        case longitude = "Longitude"
        case latitude = "Latitude"
        case duration = "Duration"
        case reportStatusName = "ReportStatusName"
        case reportStatusNameAR = "ReportStatusNameAR"
        case reportTypeName = "ReportTypeName"
        case reportTypeNameAR = "ReportTypeNameAR"
        case color = "Color"
        case reportFiles = "ReportFiles"
        case reportLogs = "ReportLogs"
    }
}
