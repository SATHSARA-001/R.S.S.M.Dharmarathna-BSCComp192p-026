//
//  categories.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-01.
//

import Foundation



struct Cart: Codable {
    
    var foodName: String?
    var foodPrice: Double?
    var amount : Double?
    var total: Double?
    
    public init( foodName: String?,foodPrice: Double?,amount : Double?,total: Double?) {
        self.foodName = foodName
        self.foodPrice = foodPrice
        self.amount = amount
        self.total = total
    }
    
    public enum CodingKeys: String, CodingKey {
        case foodName = "foodName"
        case foodPrice = "foodPrice"
        case amount = "amount"
        case total = "total"
    }
    
    
}
