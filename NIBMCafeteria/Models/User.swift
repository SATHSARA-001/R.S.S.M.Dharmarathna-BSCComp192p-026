//
//  User.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-04.
//

import Foundation



struct User: Codable {
    
    var userID: String?
    //var userName: String?
    var contactNo : String?
    var avarterImage: String?
    var email : String?
    
    
    public init(userID: String?,contactNo : String?,email:String?,avarterImage: String?) {
        self.userID = userID
        //  self.userName = userName
        self.contactNo = contactNo
        self.avarterImage = avarterImage
        self.email = email
    }
    
    public enum CodingKeys: String, CodingKey {
        case userID = "userID"
        // case userName = ""
        case contactNo = "phone"
        case avarterImage = "avarter"
        case email = "email"
        
    }
    
    
}
