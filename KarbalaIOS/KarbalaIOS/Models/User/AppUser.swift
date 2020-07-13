//
//  AppUser.swift
//  Amanaksa
//
//  Created by mac on 3/10/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

class AppUser:NSObject{
    static let shared = AppUser.init()
    private let userDefaults = UserDefaults.standard
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    var user:UserModel!
    
    private struct ConstantKeys{
        static let userKey = "user"
        static let userTokenKey = "token"
        static let isUserLoginKey = "isLogin"
    }
    
    private override init(){
        super.init()
        self.getUserData()
    }
    
    func checkUserLogin()->Bool{
        if let isLogin = userDefaults.value(forKey: ConstantKeys.isUserLoginKey) as? Bool{
            return isLogin
        }
        return false
    }
    
    func saveUserData(userObj:UserModel?,setToken:Bool = false){
        userDefaults.set(true, forKey: ConstantKeys.isUserLoginKey)
        
        if let decodedObject = userObj{
            do{
                let data = try encoder.encode(decodedObject)
                userDefaults.set(data, forKey: ConstantKeys.userKey)
                self.getUserData()
                if setToken{ self.setUserToken() }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func getUserData(){
        if let encodedData =  userDefaults.value(forKey: ConstantKeys.userKey) as? Data{
            do{
                user = try decoder.decode(UserModel.self, from: encodedData)
            }catch{
                print(error.localizedDescription)
                user = nil
            }
        }else{
            user = nil
        }
    }
    
    
    func getUserToken()->String?{
        if let token = userDefaults.value(forKey: ConstantKeys.userTokenKey) as? String {
            return token
        }
        return nil
    }
    
    func setUserToken(){
        if user != nil , let tokenObj = user.token , tokenObj.count > 0 , let token = tokenObj.first , let accessToken = token.accessToken{
            userDefaults.setValue(accessToken, forKey: ConstantKeys.userTokenKey)
        }
    }
    
    func removeUserData(){
        userDefaults.removeObject(forKey: ConstantKeys.userKey)
        userDefaults.removeObject(forKey: ConstantKeys.userTokenKey)
        userDefaults.set(false, forKey: ConstantKeys.isUserLoginKey)
    }
    
}
