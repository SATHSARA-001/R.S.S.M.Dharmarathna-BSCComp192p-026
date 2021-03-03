//
//  FoodCell.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-01.
//

import UIKit

class FoodCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodNameTxt: UILabel!
    @IBOutlet weak var foodDescText: UILabel!
    @IBOutlet weak var foodPriceTxt: UILabel!
    @IBOutlet weak var foodOfferTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configCell(model:Food?){
        
        if let foodData = model {
            shadowView.addShadow()
            foodNameTxt.text = foodData.foodname
            foodDescText.text = foodData.foodDescription
            foodPriceTxt.text = "Rs."+(foodData.foodprice ?? "N/A")
            
            if foodData.offer != nil{
                foodOfferTxt.isHidden = false
                foodOfferTxt.text = (foodData.offer ?? "N/A")+"%Off"
            }else{
                foodOfferTxt.isHidden = true
            }
            
        }
    }
    
}
