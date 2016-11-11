//
//  Account.swift
//  PeopleMon
//
//  Created by Robert White on 11/7/16.
//  Copyright © 2016 Teky. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

class Account : NetworkModel {
   /*
    {
    "Id": "string",
    "Email": "string",
    "HasRegistered": true,
    "LoginProvider": "string",
    "FullName": "string",
    "AvatarBase64": "string",
    "LastCheckInLongitude": 0,
    "LastCheckInLatitude": 0,
    "LastCheckInDateTime": "2016-11-04T18:21:36.262Z"
    }
 */
    
    var Id : String?
    var Email : String?
    var HasRegistered : Bool?
    var LoginProvider : String?
    var fullname : String?
    var AvatarBase64 : String?
    var LastCheckInLongitude : Double?
    var LastCheckInLatitude : Double?
    var LastCheckInDateTime : String?
    var token: String?
    var OldPassword : String?
    var NewPassword : String?
    var ConfirmPassword : String?
    var authTokenExpireDate: String?
    var ApiKey : String?
    var password : String?
    var username : String?
    var expiration : String?
    
    enum RequestType {
   
        case register
        case login
        case updateProfile
        case userInfo
        case logout
    }
    
    
    var requestType = RequestType.userInfo
    
    required init() {
    requestType = .userInfo
    }
    
    required init(json: JSON) throws {
        Id = try? json.getString(at: Constants.Account.Id)
        Email = try? json.getString(at: Constants.Account.Email)
        HasRegistered = try? json.getBool(at: Constants.Account.HasRegistered)
        LoginProvider = try? json.getString(at: Constants.Account.LoginProvider)
        fullname = try? json.getString(at: Constants.Account.fullname)
        AvatarBase64 = try? json.getString(at: Constants.Account.AvatarBase64)
        LastCheckInLongitude = try? json.getDouble(at: Constants.Account.LastCheckInLongitude)
        LastCheckInLatitude = try? json.getDouble(at: Constants.Account.LastCheckInLatitude)
        LastCheckInDateTime = try? json.getString(at: Constants.Account.LastCheckInDateTime)
        username = try? json.getString(at: Constants.Account.username)
        expiration = try? json.getString(at: Constants.Account.expiration)
       
      
    }
        init(Email: String, password: String){
        self.Email = Email
        self.password = password
        requestType = .login
    }
    
 

    init(Email: String, fullname: String, password: String) {
        self.Email = Email
        self.fullname = fullname
        self.password = password
        self.ApiKey = Constants.apiKey
        requestType = .register
    }
    
    init(fullName: String, AvatarBase64: String) {
        self.fullname = fullName
        self.AvatarBase64 = AvatarBase64
        requestType = .updateProfile
    }
    
    init(id: String) {
        self.Id = id
    }
    
    func method() -> Alamofire.HTTPMethod {
        switch requestType {
        case .userInfo:
            return .get
        default:
            return .post
        }
    }
    
    func path() -> String {
        switch requestType {
      
        case .login:
            return "/token"
        case .logout:
            return "/api/Account/Logout"
        case .register:
            return "/api/Account/Register"
        case .userInfo, .updateProfile:
            return "/api/Account/UserInfo"
            
        }
    }
    
    func toDictionary() -> [String: AnyObject]? {
        var params: [String: AnyObject] = [:]
        
        switch requestType {
        case .register:
            params[Constants.Account.Email] = Email as AnyObject?
            params[Constants.Account.fullname] = fullname as AnyObject?
            params[Constants.Account.ApiKey] = self.ApiKey as AnyObject?
            params[Constants.Account.password] = password as AnyObject?
        case .login:
            params[Constants.Account.grantType] = Constants.Account.password as AnyObject?
            params[Constants.Account.username] = Email as AnyObject?
            params[Constants.Account.password] = password as AnyObject?
           
        case .updateProfile:
            params[Constants.Account.fullname] = fullname as AnyObject?
            params[Constants.Account.AvatarBase64] = AvatarBase64 as AnyObject?
        default:
            break
        }
        
        return params
    }

}
