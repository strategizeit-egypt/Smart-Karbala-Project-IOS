//
//  UserRoutes.swift
//  Amanaksa
//
//  Created by mac on 3/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Alamofire
import Foundation

enum MetaDataRoutes:URLRequestBuilder {
    
    case metaData
    case getTownships
    
    
    private struct PathsConstants{
        static let getMeta              = "GetMeta"
        static let getTownships         = "GetTownships"
    }
    
    
    // MARK: - Headers
    var headers:HTTPHeaders{
        var header = HTTPHeaders()
        header[NetworkConstants.HttpHeaderField.contentType.rawValue] = NetworkConstants.ContentType.json.value
        switch self {
        case .getTownships:
            header[NetworkConstants.HttpHeaderField.authentication.rawValue] = NetworkConstants.ContentType.bearerToken.value
        default: break
        }
        return header
    }
    
    var method: HTTPMethod{
        switch self {
        default:
            return .get
        }
    }
    
    // MARK: - Path
    var path:String{
        switch self {
        case .metaData:
            return PathsConstants.getMeta
        case .getTownships:
            return PathsConstants.getTownships
        }
    }
    
    var parameters: Parameters?{
        var params:Parameters = [:]
        
        switch self {
        default: return nil
        }
        
        return  params
    }
    
    
}

//             header[NetworkConstants.HttpHeaderField.contentType.rawValue] = NetworkConstants.ContentType.json.value
