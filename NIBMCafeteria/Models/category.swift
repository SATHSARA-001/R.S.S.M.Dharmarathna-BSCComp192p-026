//
//  categories.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-01.
//

import Foundation



public struct category: Codable {

    public var categoryID: String?
    public var categoryName: String?
 
    public init(categoryID: String?, categoryName: String?) {
        self.categoryID = categoryID
        self.categoryName = categoryName
    }

    public enum CodingKeys: String, CodingKey {
        case categoryID = "categoryID"
        case categoryName = "name"
        
    }


}
