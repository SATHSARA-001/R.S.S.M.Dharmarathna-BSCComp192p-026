//
//  Food.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-03.
//

import Foundation

struct Food: Codable {
    
    var categoryName: String?
    var foodDescription: String?
    var foodname : String?
    var foodprice: String?
    var image:String?
    var offer: String?
    var availability:Int?

    
    
    public init(categoryName:String?,foodDescription: String?,foodname : String?,foodprice: String?,offer: String?,image:String?,availability:Int?) {
        self.categoryName = categoryName
        self.foodDescription = foodDescription
        self.foodname = foodname
        self.foodprice = foodprice
        self.offer = offer
        self.image = image
        self.availability = availability

        
    }
    
    public enum CodingKeys: String, CodingKey {
        case categoryName = "categoryName"
        case foodDescription = "itemDescription"
        case foodname = "itemName"
        case foodprice = "itemPrice"
        case offer = "itemDiscount"
        case image = "imageURL"
        case availability = "availability"

    }
    
    
}
