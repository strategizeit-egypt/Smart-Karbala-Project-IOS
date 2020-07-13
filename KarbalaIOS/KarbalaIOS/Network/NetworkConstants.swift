//
//  NetworkConstants.swift
//  Amanaksa
//
//  Created by mac on 3/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkConstants{
    static let baseUrl = "https://mobile.smartkarbala.com/ws"//"http://52.165.182.91/ws"
    static let apiPath = "api"
    static let filePath =  "Uploads/ReportFiles"
    static let categoryPath =  "Uploads/CategoryImages"
   
    enum urls{
        case api
        case file(reportID:Int,fileName:String)
        case categoryImage(imageName:String)
        var value:String{
            switch self {
            case .api:
                return UrlConstant.createStringUrl(baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.apiPath)
            case .file(let reportID, let fileName):
                var path =  UrlConstant.createStringUrl(baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.filePath)
                path = UrlConstant.createStringUrl(baseUrl: path, path: "\(reportID)")
                path = UrlConstant.createStringUrl(baseUrl: path, path: fileName)
                return path
            case .categoryImage(let imageName):
                var path =  UrlConstant.createStringUrl(baseUrl: NetworkConstants.baseUrl, path: NetworkConstants.categoryPath)
                path = UrlConstant.createStringUrl(baseUrl: path, path: imageName)
                return path
            }
        }
    }
    
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    enum ContentType{
        case json
        case bearerToken
        
        var value:String{
            switch self {
            case .json:
                return "application/json"
            case .bearerToken:
                return "Bearer \(AppUser.shared.getUserToken() ?? "")"
            }
        }
    }

}

class UrlConstant: NSObject {
    
    static func appendParamsInUrl(baseUrl:String,params:Parameters,path:String)->URL{
        var url = UrlConstant.createUrl(baseUrl: baseUrl, path: path)
        for (key,value) in params{
            url = UrlConstant.appendUrl(url: url, key: key, value: "\(value)")
        }
        return url
    }
    
    static func createUrl(baseUrl:String, path: String) -> URL {
        print("\(baseUrl)/\(path)")
        return URL(string: "\(baseUrl)/\(path)")!
    }
    
    static func createStringUrl(baseUrl:String, path: String) -> String {
        return "\(baseUrl)/\(path)"
    }
    
    static func appendUrl(url: URL, key: String, value: String) -> URL {
        let urlString = url.absoluteString
        if urlString.lowercased().range(of:"?") != nil {
            let newUrlString = "\(urlString)&\(key)=\(value)"
            let urlwithPercentEscapes = newUrlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
            return URL(string: urlwithPercentEscapes!)!
        }else{
            let newUrlString = "\(urlString)?\(key)=\(value)"
            let urlwithPercentEscapes = newUrlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
            return URL(string: urlwithPercentEscapes!)!
        }
    }
    
}


