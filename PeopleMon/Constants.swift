//
//  Constants.swift
//  PeopleMon
//
//  Created by Robert White on 11/7/16.
//  Copyright © 2016 Teky. All rights reserved.
//

import UIKit

struct Constants {
    public static let keychainIdentifier = "PeoplemonKeychain"
    public static let authTokenExpireDate = "authTokenExpireDate"
    public static let authToken = "authToken"
    static let apiKey = "iOSandroid301november2016"
    static let radius = 100.0
    static let serverImageSize: CGFloat = 80
    static let pinImageSize: CGFloat = 16
    
    static let nearbyRadius = 500.0
    
    static let userRadius = "User Radius"
    
    struct JSON {
        static let unknownError = "An Unknown Error Has Occurred"
        static let processingError = "There was an error processing the response"
    }
    
    struct User {
        static let id = "Id"
        static let email = "Email"
        static let fullName = "FullName"
        static let password = "password"
        static let apiKey = "ApiKey"
        static let profileImage = "ProfileBase64Image"
        static let username = "username"
        static let grantType = "grant_type"
        static let token = "access_token"
        static let expirationDate = ".expires"
        static let hasRegistered = "HasRegistered"
        static let loginProvider = "LoginProvider"
        static let avatarBase64 = "AvatarBase64"
        static let latitude = "LastCheckInLatitude"
        static let longitude = "LastCheckInLongitude"
    }
    
    struct Account {
        static let userId = "UserId"
        static let userName = "UserName"
        static let latitude = "Latitude"
        static let longitude = "Longitude"
        static let created = "Created"
        static let radius = "radiusInMeters"
        static let caughtUserId = "CaughtUserId"
        static let avatar = "AvatarBase64"
    }
}

enum Images : String {
    case Avatar
    
    func image() -> UIImage {
        return #imageLiteral(resourceName: "Defaultimage")
    }
}
/*
// MARK: - Colors
// Step 14: UIColor extension and
extension UIColor {
    public class func rgba(red: NSInteger, green: NSInteger, blue: NSInteger, alpha: Float = 1.0) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha))
    }
}

struct ColorPalette {
    static let PositiveColor = UIColor.rgba(red: 15, green: 181, blue: 46)
    static let NegativeColor = UIColor.rgba(red: 219, green: 31, blue: 31)
    static let BlueColor = UIColor.rgba(red: 12, green: 35, blue: 64)
    static let GoldColor = UIColor.rgba(red: 201, green: 151, blue: 0)
    static let calendarCellColor = UIColor.rgba(red: 0, green: 0, blue: 0, alpha: 0.1)
    static let calendarTodayColor = UIColor.rgba(red: 12, green: 35, blue: 64, alpha: 0.3)
    static let calendarBorderColor = UIColor.rgba(red: 12, green: 35, blue: 64, alpha: 0.8)
}
*/
