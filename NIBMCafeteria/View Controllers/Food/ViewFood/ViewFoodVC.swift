//
//  ViewFoodVC.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-01.
//

import UIKit

protocol addItemDelegate {
    func itemAddedToCart(model:Cart?,index:Int?)
}

class ViewFoodVC: UIViewController {
    
    var delegate:addItemDelegate?
    var index : Int?
    
    var newcart = Cart(foodName: "Apple", foodPrice: 100, amount: 10,total:0)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addItemToCart(_ sender: Any) {
        
       
        let amount = Double(newcart.amount ?? 0)
        let unitPrice = Double(newcart.foodPrice ?? 0)
        newcart.total = amount * unitPrice
        self.delegate?.itemAddedToCart(model: newcart, index: index)
        navigationController?.popViewController(animated: true)
    }
    
}
