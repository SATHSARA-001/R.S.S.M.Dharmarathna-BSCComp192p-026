//
//  AccountVC.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-01.
//

import UIKit

class AccountVC: UIViewController {
    
    @IBOutlet weak var avarterImg: UIImageView!
    @IBOutlet weak var profilePicBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        // Do any additional setup after loading the view.
    }
    
    
    func setupUI(){
        avarterImg.layer.cornerRadius = avarterImg.frame.height / 2
        profilePicBtn.layer.cornerRadius = profilePicBtn.frame.height / 2

    }

}
