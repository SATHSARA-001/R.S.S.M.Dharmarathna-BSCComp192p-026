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
    
    @IBOutlet weak var foodNameTxt: UILabel!
    @IBOutlet weak var offerValueTxt: UILabel!
    @IBOutlet weak var priceTxt: UILabel!
    @IBOutlet weak var descTxt: UILabel!
    @IBOutlet weak var foodImg: UIImageView!
    
    
    var delegate:addItemDelegate?
    var index : Int?
    var foodDetails : Food?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        setData()
    }
    
    func setData(){
        foodNameTxt.text = foodDetails?.foodname
        offerValueTxt.text = foodDetails?.offer
        priceTxt.text = foodDetails?.foodprice
        descTxt.text = foodDetails?.foodDescription
    }
    
    @IBAction func addItemToCart(_ sender: Any) {
        
        let foodName = foodDetails?.foodname
        let foodPrice = Double(foodDetails?.foodprice ?? "")
        let foodamount : Double? = 1
        let total = (foodPrice ?? 0 * foodamount! )
        let newcart = Cart(foodName: foodName, foodPrice: foodPrice, amount: foodamount,total:total)
        self.delegate?.itemAddedToCart(model: newcart, index: index)
        navigationController?.popViewController(animated: true)
    }
    
}
