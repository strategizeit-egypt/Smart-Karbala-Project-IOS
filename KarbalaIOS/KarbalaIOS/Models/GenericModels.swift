//
//  GenericModels.swift
//  Amanaksa
//
//  Created by mac on 3/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct GenericModels<T:Codable>: Codable {
    var model: [T]?
    var metas: MetaModel?
    var errors: ErrorModel?
    
}
