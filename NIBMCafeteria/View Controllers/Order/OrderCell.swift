//
//  OrderCell.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-01.
//

import UIKit

class OrderCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var orderIDTxt: UILabel!
    @IBOutlet weak var orderTimeDurationTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configCell(model:CartObject,index:Int){
        
        let time = model.time?.convertStringToDate(.Time_24Hours)
        let currTime = Date().convertDateToString(.Time_24Hours).convertStringToDate(.Time_24Hours)
        
        orderTimeDurationTxt.text = "13min Left"
        orderIDTxt.text = model.orderID
        
        shadowView.addShadow()
    }
    
}
