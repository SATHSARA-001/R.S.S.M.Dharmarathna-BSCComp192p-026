//
//  AccountVC.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-01.
//

import UIKit
import Firebase

class AccountVC: UIViewController {
    
    @IBOutlet weak var avarterImg: UIImageView!
    @IBOutlet weak var profilePicBtn: UIButton!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var contactNoTxt: UITextField!
    
    let ref: DatabaseReference! = Database.database().reference()
    
    let defaults = UserDefaults.standard
    
    var userID : String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setData()
        
        // Do any additional setup after loading the view.
    }
    
    
    func setupUI(){
        avarterImg.layer.cornerRadius = avarterImg.frame.height / 2
        profilePicBtn.layer.cornerRadius = profilePicBtn.frame.height / 2
        
    }
    
    func setData(){
        
        userID = defaults.string(forKey: "userID")
        let contactNo = defaults.string(forKey: "phoneNumber")
        let userName = defaults.string(forKey: "userName")
        
        userNameTxt.text = userName
        contactNoTxt.text = contactNo
        
    }
    
    @IBAction func uploadAvarter(_ sender: Any) {
        
        
    }
    
    
    @IBAction func updateUserData(_ sender: Any) {
        
        let email = userNameTxt.text
        let contactNo = contactNoTxt.text
        
        
        
        guard let key = ref.child("users").childByAutoId().key else { return }
        let post = ["userID": userID,
                    "email": email,
                    "phone": contactNo]
        
        let childUpdates = ["/users/\(key)": post,
                            "/user-posts/\(String(describing: userID))/\(key)/": post]
        ref.updateChildValues(childUpdates)
        
    }
    
}
