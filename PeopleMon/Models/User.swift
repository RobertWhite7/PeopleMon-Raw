//
//  User.swift
//  PeopleMon
//
//  Created by Robert White on 11/7/16.
//  Copyright © 2016 Teky. All rights reserved.
//

import Foundation
import Alamofire
import Freddy

class User : NetworkModel {
    /*
     {
     "UserId": "string",
     "UserName": "string",
     "AvatarBase64": "string",
     "Longitude": 0,
     "Latitude": 0,
     "Created": "2016-11-07T19:17:22.528Z"
     }     */
    
    var UserId: String?
    var UserName: String?
    var AvatarBase64: String?
    var Latitude: Int?
    var Longitude: Int?
    var Created: String?
    
    var CaughtUserId: String?
    var RadiusInMeters: Int?
    
    var RecipientId: String?
    var Message: String?
    
    var ConversationId: Int?
    var RecipientName: String?
    var LastMessage: String?
    var MessageCount: Int?
    var SenderId: String?
    var SenderName: String?
    
    enum RequestType {
        case Nearby
        case CheckIn
        case Catch
        case Caught
       
    }
    var requestType = RequestType.Nearby
    
    required init() {}
    
    required init(json: JSON) throws {
        UserId = try? json.getString(at: Constants.User.UserId)
        UserName = try? json.getString(at: Constants.User.UserName)
        AvatarBase64 = try? json.getString(at: Constants.User.AvatarBase64)
        Latitude = try? json.getInt(at: Constants.User.Latitude)
        Longitude = try? json.getInt(at: Constants.User.Longitude)
        Created = try? json.getString(at: Constants.User.Created)
        CaughtUserId = try? json.getString(at: Constants.User.CaughtUserId)
        RadiusInMeters = try? json.getInt(at: Constants.User.RadiusInMeters)
        RecipientId = try? json.getString(at: Constants.User.RecipientId)
        Message = try? json.getString(at: Constants.User.Message)
   
    }
        init(UserId: String, UserName: String, AvatarBase64: String, Longitude: Int, Latitude: Int, Created: String) {
            self.UserId = UserId
            self.UserName = UserName
            self.AvatarBase64 = AvatarBase64
            self.Longitude = Longitude
            self.Latitude = Latitude
            self.Created = Created
            requestType = .Nearby
        
    }
    
    init(Longitude: Int, Latitude: Int){
        self.Longitude = Longitude
        self.Latitude = Latitude
        requestType = .CheckIn
    }
    
    init(CaughtUserId: String, RadiusInMeters: Int){
       self.CaughtUserId = CaughtUserId
       self.RadiusInMeters = RadiusInMeters
       requestType = .Catch
    }
    

    init(UserId: String, UserName: String, Created: String, AvatarBase64: String){
       self.UserId = UserId
        self.UserName = UserName
        self.Created = Created
        self.AvatarBase64 = AvatarBase64
        requestType = .Caught
    }
    
 /*   init(ConversationId: Int, RecipientId: String, RecipientName: String, LastMessage: String, Created: String, MessageCount: Int, AvatarBase64: String, SenderId: String, SenderName: String, RecipientAvatarBase64: String){
        self.ConversationId = ConversationId
        self.RecipientId = RecipientId
        self.RecipientName = RecipientName
        self.LastMessage = LastMessage
        self.Created = Created
        self.MessageCount = MessageCount
        self.AvatarBase64 = AvatarBase64
        self.SenderId = SenderId
        self.SenderName = SenderName
    } */
  
    
    func method() -> Alamofire.HTTPMethod {
        return .post
    }
  //  case Nearby
  //  case CheckIn
  //  case Catch
  //  case Caught
  //  case Conversations
  //  case Conversation
    
    func path() -> String {
        switch requestType {
        case .Nearby:
            return "/api/User/Nearby"
        case .CheckIn:
            return "/api/User/CheckIn"
        case .Catch:
            return "/api/User/Catch"
        case .Caught:
            return "/api/User/Caught"
   /*     case .Conversations:
            return "/User/Conversations"
        case .Conversation:
            return "/User/Conversation" */
        }
    }
    
    // Demo object isn't being posted to a server, so just return nil
    func toDictionary() -> [String: AnyObject]? {
        var params: [String: AnyObject] = [:]
        
        switch requestType {
        case .Nearby:
            params[Constants.User.RadiusInMeters] = RadiusInMeters as AnyObject?
        case .CheckIn:
            params[Constants.User.Longitude] = Longitude as AnyObject?
            params[Constants.User.Latitude] = Latitude as AnyObject?
        case .Catch:
            params[Constants.User.CaughtUserId] = UserId as AnyObject?
            params[Constants.User.RadiusInMeters] = RadiusInMeters as AnyObject?
        case .Caught:
            break
        }
        return params
    }
        
   

}

