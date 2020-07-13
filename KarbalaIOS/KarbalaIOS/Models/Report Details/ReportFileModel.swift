//
//  FileModel.swift
//  Amanaksa
//
//  Created by mac on 3/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct ReportFileModel: Codable {
    var id, reportID, fileTypeID: Int?
    var filePath: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case reportID = "ReportId"
        case fileTypeID = "FileTypeId"
        case filePath = "FilePath"
    }
}
