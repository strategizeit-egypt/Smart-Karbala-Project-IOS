//
//  ReportRoutes.swift
//  Amanaksa
//
//  Created by mac on 3/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Alamofire
import Foundation

enum ReportRoutes:URLRequestBuilder {
    
    case addReport(title:String,details:String?,reportTypeId:String
        ,townshipId:String,latitude:String
                    ,longitude:String,duration:String)
    
    case getAllReports(page:Int,sorting:Bool)
    
    case getReportDetails(reportId:Int)
    
    case searchInReports(word:String,page:Int,sorting:Bool)
    
    private struct PathsConstants{
        static let addReport                = "AddReport"
        static let getAllReports            = "GetAllReports"
        static let getReportDetails         = "GetReportDetails"
        static let searchInReports          = "SearchInReports"
    }
    
    private struct ParamterConstant{
        static let page = "Page"
        static let sorting = "Sorting"
        
        static let reportId = "ReportId"
        
        static let word = "Word"
        
        static let title = "Title"
        static let details = "Details"
        static let reportTypeId = "ReportTypeId"
        static let townshipId = "TownshipId"
        static let files = "Files"
        static let latitude = "Latitude"
        static let longitude = "Longitude"
        static let duration = "Duration"
    }
    
    
    // MARK: - Headers
    var headers:HTTPHeaders{
        var header = HTTPHeaders()
        header[NetworkConstants.HttpHeaderField.authentication.rawValue] = NetworkConstants.ContentType.bearerToken.value
        switch self {
        case .searchInReports:
            header[NetworkConstants.HttpHeaderField.contentType.rawValue] = "application/json; charset=utf-8"
        default:
           header[NetworkConstants.HttpHeaderField.contentType.rawValue] = NetworkConstants.ContentType.json.value
        }
        return header
    }
    
    var method: HTTPMethod{
        switch self {
        case .addReport: return .post
        default: return .get
        }
    }
    
    // MARK: - Path
    var path:String{
        switch self {
        case .addReport:
            return PathsConstants.addReport
        case .getAllReports:
            return PathsConstants.getAllReports
        case .getReportDetails:
            return PathsConstants.getReportDetails
        case .searchInReports:
            return PathsConstants.searchInReports
        }
    }
    
    var parameters: Parameters?{
        var params:Parameters = [:]
        
        switch self {
        case .addReport(let title,let details,let reportTypeId,let townshipId,let latitude,let longitude,let duration):
            params[ParamterConstant.title] = title
            params[ParamterConstant.details] = details
            params[ParamterConstant.reportTypeId] = reportTypeId
            params[ParamterConstant.townshipId] = townshipId
            params[ParamterConstant.latitude] = latitude
            params[ParamterConstant.longitude] = longitude
            params[ParamterConstant.duration] = duration
        case .getAllReports(let page,let sorting):
            params[ParamterConstant.page] = page
            params[ParamterConstant.sorting] = sorting
        case .searchInReports(let word,let page,let sorting):
            params[ParamterConstant.word] = word
            params[ParamterConstant.page] = page
            params[ParamterConstant.sorting] = sorting
        case .getReportDetails(let reportId):
            params[ParamterConstant.reportId] = reportId
        default: return nil
        }
        
        return  params
    }
    
    
}

//
