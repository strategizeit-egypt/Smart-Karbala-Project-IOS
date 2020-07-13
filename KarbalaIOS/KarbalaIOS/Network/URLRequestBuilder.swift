//
//  URLRequestBuilder.swift
//  Amanaksa
//
//  Created by mac on 3/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import Alamofire

protocol URLRequestBuilder:URLRequestConvertible {
    
    var mainURL:String {get}
    var requestURL:URL {get}
       
    // MARK: - path
    var path:String {get}
    
    var headers:HTTPHeaders {get}
    
    // MARK: - Parameters
    var parameters:Parameters? {get}
    
    // MARK: - Method
    var method:HTTPMethod {get}
    
    var encoding:ParameterEncoding {get}
    
    var urlRquest:URLRequest {get}
    
}

extension URLRequestBuilder{
    var mainURL:String{
        return NetworkConstants.urls.api.value
    }
    
    var requestURL:URL{
        if method == .get{
            guard let params = parameters,params.count > 0 else{
                return UrlConstant.createUrl(baseUrl: mainURL, path: path)
            }
            return UrlConstant.appendParamsInUrl(baseUrl: mainURL, params: params, path: path)
        }else{
            return UrlConstant.createUrl(baseUrl: mainURL, path: path)
        }
    }

    
    var encoding:ParameterEncoding{
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var urlRquest:URLRequest{
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        headers.forEach { (key,value) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }
    
    func asURLRequest() throws -> URLRequest {
        if method == .get{
            return try encoding.encode(urlRquest, with: nil)
        }else{
            return try encoding.encode(urlRquest, with: parameters)
        }
    }
    
    
}
