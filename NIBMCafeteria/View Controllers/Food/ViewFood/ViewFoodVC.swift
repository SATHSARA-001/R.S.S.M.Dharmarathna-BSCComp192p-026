//
//  ViewFoodVC.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-01.
//

import UIKit

protocol addItemDelegate {
    func itemAddedToCart()
}

class ViewFoodVC: UIViewController {
    
    var delegate:addItemDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addItemToCart(_ sender: Any) {
        
        self.delegate?.itemAddedToCart()
        navigationController?.popViewController(animated: true)
    }
    
}
