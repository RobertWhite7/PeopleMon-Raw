//
//  UserStore.swift
//  PeopleMon
//
//  Created by Robert White on 11/7/16.
//  Copyright © 2016 Teky. All rights reserved.
//

import Foundation
protocol UserStoreDelegate: class {
    func userLoggedIn()
}
class UserStore {
    
    // singleton
    static let shared = UserStore()
    private init() {}
    
    var user: Account? {
        didSet{
            if let _ = user {
                delegate?.userLoggedIn()
            }
        }
    }
    
    weak var delegate: UserStoreDelegate?
    
    func login(_ loginUser: Account, completion:@escaping (_ success:Bool, _ error: String?) -> Void){
        
        // Call web service to login
        WebServices.shared.authUser(loginUser) { (user, error) in
            if let user = user {
                WebServices.shared.setAuthToken(user.token, expiration: user.expiration)
                self.getUserInfo(loginUser, completion: completion)
                completion(true, nil)
            }else {
                completion(false, error)
            }
            
        }
        
    }
    
    func register(_ registerUser: Account, completion:@escaping(_ success:Bool, _ error: String?) -> Void){
        
        // Call web service to register
        WebServices.shared.authUser(registerUser) { (user, error) in
            if let user = user {
                registerUser.requestType = Account.RequestType.login
                WebServices.shared.setAuthToken(user.token, expiration: user.expiration)
                completion(true, nil)
            }else {
                completion(false, error)
            }
            
        }
        
    }
    
    func getUserInfo(_ infoUser: Account, completion:@escaping(_ succes:Bool, _ error: String?) -> Void){
        infoUser.requestType = Account.RequestType.userInfo
        WebServices.shared.getObject(infoUser) { (user, error) in
            if let user = user {
                self.user = user
                completion(true, nil)
            }else {
                completion(false, error)
            }
            
        }
        
    
    }
    
    func logout( _ completion:() -> Void) {
        WebServices.shared.clearUserAuthToken()
        completion()
    }
}
