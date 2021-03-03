//
//  FoodCategoryCell.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-01.
//

import UIKit

class FoodCategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryName: UILabel!
    
    func configCell(model:Category?){
        
        if let categoryNameText = model?.categoryName {
            categoryName.text = categoryNameText
        }
    }
}
