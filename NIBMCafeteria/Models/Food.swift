//
//  Food.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-03.
//

import Foundation

struct Food: Codable {
    
    var categoryID: String?
    var categoryName: String?
    var foodDescription: String?
    var foodname : String?
    var foodprice: String?
    var image:String?
    var offer: String?
    
    
    public init(categoryName:String?,categoryID: String?,foodDescription: String?,foodname : String?,foodprice: String?,offer: String?,image:String?) {
        self.categoryID = categoryID
        self.categoryName = categoryName
        self.foodDescription = foodDescription
        self.foodname = foodname
        self.foodprice = foodprice
        self.offer = offer
        self.image = image
        
    }
    
    public enum CodingKeys: String, CodingKey {
        case categoryName = "categoryName"
        case categoryID = "categoryID"
        case foodDescription = "foodD"
        case foodname = "foodname"
        case foodprice = "foodprice"
        case offer = "offer"
        case image = "image"
    }
    
    
}
