//
//  UserStore.swift
//  PeopleMon
//
//  Created by Robert White on 11/7/16.
//  Copyright © 2016 Teky. All rights reserved.
//

import Foundation

class UserStore {
    // singleton
    static let shared = UserStore()
    private init() {}
    
    func login(_ loginUser: User, completion:@escaping (_ success:Bool, _ error: String?) -> Void){
        
        // Call web service to login
        WebServices.shared.authUser(loginUser) { (user, error) in
            if user != nil {
 //               WebServices.shared.setAuthToken(user.token, expiration: user.expiration)
                completion(true, nil)
            }else {
                completion(false, error)
            }
            
        }
        
    }
    
    func register(_ registerUser: User, completion:@escaping(_ success:Bool, _ error: String?) -> Void){
        
        // Call web service to register
        WebServices.shared.authUser(registerUser) { (user, error) in
            if user != nil {
    //            WebServices.shared.setAuthToken(user.token, expiration: user.expiration)
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
