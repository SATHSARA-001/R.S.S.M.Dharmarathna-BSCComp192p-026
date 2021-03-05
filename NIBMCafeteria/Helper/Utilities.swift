//
//  Utilities.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-02-23.
//

import Foundation
import UIKit

class Utilities {
    
}


extension UIView{
    
    func addShadow(offSet: CGFloat = 2.0, color: UIColor = .lightGray) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: offSet, height: offSet)
        self.layer.shadowOpacity = 1
        self.layer.shouldRasterize = false
        self.layer.masksToBounds = false
    }
}

extension Encodable {

    /// Converting object to postable dictionary
    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        let data = try encoder.encode(self)
        let object = try JSONSerialization.jsonObject(with: data)
        guard let json = object as? [String: Any] else {
            let context = DecodingError.Context(codingPath: [], debugDescription: "Deserialized object is not a dictionary")
            throw DecodingError.typeMismatch(type(of: object), context)
        }
        return json
    }
}
