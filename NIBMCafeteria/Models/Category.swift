//
//  Category.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-03.
//

import Foundation

struct Category: Codable {
    
    var categoryID: String?
    var categoryName: String?
   
    
    public init(categoryID: String?,categoryName: String?) {
        self.categoryID = categoryID
        self.categoryName = categoryName
    }
    
    public enum CodingKeys: String, CodingKey {
        case categoryID = "categoryID"
        case categoryName = "categoryName"
        
    }
    
    
}
