//
//  ServiceProvider.swift
//  Amanaksa
//
//  Created by mac on 3/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import Alamofire

typealias SuccessCompletion = (_ result:Codable)->()
typealias ErrorCompletion = (_ error:ApiError)->()
typealias CustomErrorCompletion = (_ result:Codable)->()

struct NetworkService<T:Codable> {
    
    
    func request(request:URLRequestConvertible,successCompletion: @escaping SuccessCompletion,errorCompletion: @escaping ErrorCompletion)  {
        
        
        Alamofire.request(request).validate(statusCode: 200...500)
            .responseJSON { (response) in
                guard let responseStatusCode = response.response?.statusCode else{
                    errorCompletion(ApiError.NetworkError)
                    return
                }
                if responseStatusCode == 200{
                    guard let decodedData:T = self.decodeResultToModel(encodedData: response.data) else{
                        errorCompletion(ApiError.decodingError)
                        return
                    }
                    successCompletion(decodedData)
                }else{
                    if responseStatusCode == 401{
                        Helper.handle401Error()
                        errorCompletion(ApiError.unauthorized)
                    }else{
                        let error = self.decodeResultToError(encodedData: response.data)
                        errorCompletion(error)
                    }
                }
        }
        
    }
    
    func UploadFile(request:URLRequestConvertible,requestParameters:[String:String],audioFile:Data?,imagesFiles:[Data]?,successCompletion: @escaping SuccessCompletion,errorCompletion: @escaping ErrorCompletion)  {
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in requestParameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key as String)
            }
            if audioFile != nil{
                multipartFormData.append(audioFile!, withName: "Files", fileName: "recording.mp3", mimeType: "file")
            }
            
            if imagesFiles != nil{
                for value in imagesFiles!{
                    multipartFormData.append(value, withName: "Files", fileName: "image.png", mimeType: "file")
                }
            }
            
            
            
        }, usingThreshold: UInt64.init(), with: request) { (encodingResult) in
            switch encodingResult {
            case .success(request:let upload , streamingFromDisk: _, streamFileURL: _):
                upload.uploadProgress(closure: { (progress) in
                    print("Progress: \(progress.fractionCompleted)")
                })
                upload.responseJSON(completionHandler: { (response) in
                    guard let responseStatusCode = response.response?.statusCode else{
                        errorCompletion(ApiError.NetworkError)
                        return
                    }
                    if responseStatusCode == 200{
                        guard let decodedData:T = self.decodeResultToModel(encodedData: response.data) else{
                            errorCompletion(ApiError.decodingError)
                            return
                        }
                        successCompletion(decodedData)
                    }else{
                        let error = self.decodeResultToError(encodedData: response.data)
                        errorCompletion(error)
                    }
                })
            case .failure(let error):
                errorCompletion(ApiError.NetworkError)
            }
            
        }
    }
    
    private func decodeResultToModel(encodedData:Data?)-> T?{
        if let data = encodedData, let decodedData = try? JSONDecoder().decode(GenericModel<T>.self, from: data){
            return decodedData.model
        }
        return nil
    }
    
    private func decodeResultToModel(encodedData:Data?)-> [T]?{
        if let data = encodedData, let decodedData = try? JSONDecoder().decode(GenericModels<T>.self, from: data){
            return decodedData.model
        }
        return nil
    }
    
    private func decodeResultToError(encodedData:Data?)-> ApiError{
        if let data = encodedData, let decodedData = try? JSONDecoder().decode(GenericModels<T>.self, from: data){
            return decodedData.errors?.mapCodeToApiError() ?? .internalServerError
        }
        return .internalServerError
    }
    
}
