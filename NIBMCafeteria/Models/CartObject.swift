//
//  CartObject.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-05.
//

import Foundation

struct CartObject: Codable {
    var cart:[Cart]?
    var time:String?
    var userID:String?
    var totalAmt:String?
    
    public init(cart:[Cart]?,time:String?,userID:String?,totalAmt:String?) {
        self.cart = cart
        self.time = time
        self.userID = userID
        self.totalAmt = totalAmt
    }
    
    public enum CodingKeys: String, CodingKey {
        case cart = "cart"
        case time = "time"
        case userID = "userID"
        case totalAmt = "totalAmt"

    }
    
    
}

