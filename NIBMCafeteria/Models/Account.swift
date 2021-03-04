//
//  Account.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-04.
//

import Foundation

struct Account: Codable {
    
    var accName: String?
    var accAvarter: String?
    var accContact:String?
   
    
    public init(accName: String?, accAvarter: String?, accContact:String?) {
        self.accName = accName
        self.accAvarter = accAvarter
        self.accContact = accContact
    }
    
    public enum CodingKeys: String, CodingKey {
        case accName = "categoryID"
        case accAvarter = "categoryName"
        case accContact = ""
        
    }
    
    
}
