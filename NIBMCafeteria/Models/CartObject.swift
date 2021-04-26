//
//  CartObject.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-05.
//

import Foundation

struct CartObject: Codable {
    var cart:[Cart]?
    var orderID:String?
    var time:String?
    var userID:String?
    var userName:String?
    var totalAmt:String?
    var orderStatus : Int?   //1:NEW, 2:PREPARATION, 3:READY, 4:ARRVING, 5:DONE, 6:CANCEL
    
    public init(cart:[Cart]?,time:String?,userID:String?,userName:String?,totalAmt:String?,orderStatus:Int?,orderID:String?) {
        self.cart = cart
        self.time = time
        self.userID = userID
        self.userName = userName
        self.totalAmt = totalAmt
        self.orderStatus = orderStatus
        self.orderID = orderID
    }
    
    public enum CodingKeys: String, CodingKey {
        case cart = "cart"
        case time = "time"
        case userID = "userID"
        case userName = "userName"
        case totalAmt = "totalAmt"
        case orderStatus = "orderStatus"
        case orderID = "orderID"



    }
    
    
}

