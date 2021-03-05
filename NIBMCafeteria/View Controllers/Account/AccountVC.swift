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
    
    var userList = [User]()
    var loginuser = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchUserAccount()
    }
    
    func setupUI(){
        avarterImg.layer.cornerRadius = avarterImg.frame.height / 2
        profilePicBtn.layer.cornerRadius = profilePicBtn.frame.height / 2
        
    }
    
    func fetchUserAccount(){
        let orderList: DatabaseReference! = Database.database().reference().child("users")
        
        orderList.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0{
                self.userList.removeAll()
                
                for users in snapshot.children.allObjects as! [DataSnapshot]{
                    let userObject = users.value as? [String: AnyObject]
                    
                    let email  = userObject?["email"]
                    let phone  = userObject?["phone"]
                    let userID  = userObject?["userID"]
                    
                    let user = User(userID: userID as? String, contactNo: phone as? String, email: email as? String)
                    
                    //appending it to list
                    self.userList.append(user)
                    print(self.userList.count)
                }
                
                self.loginuser = self.userList.filter({$0.userID == self.userID})
                print(self.loginuser)
                
//                self.user.reloadData()
                
            }
        }
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
