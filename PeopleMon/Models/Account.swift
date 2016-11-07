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
    var FullName : String?
    var AvatarBase64 : String?
    var LastCheckInLongitude : Int?
    var LastCheckInLatitude : Int?
    var LastCheckInDateTime : String?
    
    var OldPassword : String?
    var NewPassword : String?
    var ConfirmPassword : String?
    
    var ApiKey : String?
    
    enum RequestType {
        case userinfo
        case changePassword
        case setPassword
        case register
    }
    var requestType = RequestType.userinfo
    
    required init() {}
    
    required init(json: JSON) throws {
        Id = try? json.getString(at: Constants.Account.Id)
        Email = try? json.getString(at: Constants.Account.Email)
        HasRegistered = try? json.getBool(at: Constants.Account.HasRegistered)
        LoginProvider = try? json.getString(at: Constants.Account.LoginProvider)
        FullName = try? json.getString(at: Constants.Account.FullName)
        AvatarBase64 = try? json.getString(at: Constants.Account.AvatarBase64)
        LastCheckInLongitude = try? json.getInt(at: Constants.Account.LastCheckInLongitude)
        LastCheckInLatitude = try? json.getInt(at: Constants.Account.LastCheckInLatitude)
        LastCheckInDateTime = try? json.getString(at: Constants.Account.LastCheckInDateTime)
    }
    
    init(FullName: String, AvatarBase64: String) {
        self.FullName = FullName
        self.AvatarBase64 = AvatarBase64
        requestType = .userinfo
    }
    
    init(OldPassword: String, NewPassword: String, ConfirmPassword: String) {
        self.OldPassword = OldPassword
        self.NewPassword = NewPassword
        self.ConfirmPassword = ConfirmPassword
        requestType = .changePassword
    }
    init(NewPassword: String){
        self.NewPassword = NewPassword
        requestType = .setPassword
}
    init(Email: String, Fullname: String, AvatarBase64:String, ApiKey: String, Password: String) {
        self.ApiKey = ApiKey
        requestType = .register
    }
    init(id: String) {
        self.Id = id
    }
    
    func method() -> Alamofire.HTTPMethod {
        switch requestType {
        case .userinfo:
            return .get
        default:
            return .post
        }
    }
    
    func path() -> String {
        switch requestType {
        case .userinfo:
            return "/UserInfo"
        case .changePassword:
            return "/ChangePassword"
        case .setPassword:
            return "/SetPassword"
        case .register:
            return "/Register"
            
        }
    }
    
    // Demo object isn't being posted to a server, so just return nil
    func toDictionary() -> [String: AnyObject]? {
        
        var params: [String: AnyObject] = [:]
        params[Constants.Account.FullName] = FullName as AnyObject?
        params[Constants.Account.AvatarBase64] = AvatarBase64 as AnyObject?
        
        
        switch requestType {
        case .register:
            params[Constants.Account.NewPassword] = NewPassword as AnyObject?
        default:
            break
        }
        
        return params
    }

}
