//
//  Food.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-03.
//

import Foundation

struct Food: Codable {
    
    var categoryID: String?
    var foodDescription: String?
    var foodname : String?
    var foodprice: String?
    var offer: String?
    
    
    public init(categoryID: String?,foodDescription: String?,foodname : String?,foodprice: String?,offer: String?) {
        self.categoryID = categoryID
        self.foodDescription = foodDescription
        self.foodname = foodname
        self.foodprice = foodprice
        self.offer = offer
        
    }
    
    public enum CodingKeys: String, CodingKey {
        case categoryID = "categoryID"
        case foodDescription = "foodD"
        case foodname = "foodname"
        case foodprice = "foodprice"
        case offer = "offer"
    }
    
    
}
