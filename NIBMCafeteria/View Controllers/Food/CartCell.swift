//
//  CartCell.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-01.
//

import UIKit

protocol addItemsAmtDelegate {
    func addAmtItems(amount:Int?,index:IndexPath?)
}

protocol minItemsAmtDelegate {
    func minAmtItems(amount:Int?,index:IndexPath?)

}

class CartCell: UITableViewCell {

    @IBOutlet weak var foodNameLbl: UILabel!
    @IBOutlet weak var amtLbl: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var minBtn: UIButton!
    @IBOutlet weak var priceAmtLbl: UILabel!
    
    var addDelegate:addItemsAmtDelegate? = nil
    var minDelegate:minItemsAmtDelegate? = nil
    
    var modelDate:Cart?
    var index:IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(model:Cart?){
        
        modelDate = model
        if let data = model {
            foodNameLbl.text = data.foodName
            amtLbl.text = String(data.amount ?? 0)
            priceAmtLbl.text = String(data.foodPrice ?? 0)
        }
        
    }
    
    @IBAction func plusAmountOfItems(_ sender: Any) {
        
        addDelegate?.addAmtItems(amount: modelDate?.amount, index: index) 
    }
    
    @IBAction func minAmountOfItems(_ sender: Any) {
        
        minDelegate?.minAmtItems(amount:modelDate?.amount,index: index)
    }
    

}
