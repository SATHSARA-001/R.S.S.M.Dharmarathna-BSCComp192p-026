//
//  AccountVC.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-01.
//

import UIKit
import Firebase
import FirebaseStorage
import AlamofireImage


class AccountVC: UIViewController,LoadingIndicatorDelegate {
    
    @IBOutlet weak var avarterImg: UIImageView!
    @IBOutlet weak var profilePicBtn: UIButton!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var contactNoTxt: UITextField!
    
    let ref: DatabaseReference! = Database.database().reference()
    let storage = Storage.storage().reference()
    let defaults = UserDefaults.standard
    var userID : String?
    let picker = UIImagePickerController()
    var userList = [User]()
    var loginuser = [User]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userID = defaults.string(forKey: "userID")
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchUserAccount()
        setupUI()
        setData()
    }
    
    func setupUI(){
        picker.delegate = self
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
                    let avarterImage = userObject?["avarter"]
                    
                    let user = User(userID: userID as? String, contactNo: phone as? String, email: email as? String, avarterImage: avarterImage as? String)
                    
                    //appending it to list
                    self.userList.append(user)
                    print(self.userList.count)
                }
                
                self.loginuser = self.userList.filter({$0.userID == self.userID})
                print(self.loginuser)
                self.setData()
                //                self.user.reloadData()
                
            }
        }
    }
    
    func setData(){
        
        userNameTxt.text = loginuser.first?.email
        contactNoTxt.text =  loginuser.first?.contactNo
        let Image = loginuser.first?.avarterImage
        
        guard let imageData = Image else{return}
        
        avarterImg.setImageWithUrl(imageData)
        
    }
    
    @IBAction func uploadAvarter(_ sender: Any) {
        
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    
    @IBAction func updateUserData(_ sender: Any) {
        
        let email = userNameTxt.text
        let contactNo = contactNoTxt.text
        
        let user = ["email":email,"phone":contactNo,"userID":userID]
        
        let refUsers: DatabaseReference! = Database.database().reference().child("users")
        
        refUsers.child(userID ?? "").setValue(user )
        
        fetchUserAccount()
        setData()
        
    }
    
}


extension AccountVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage  else { return
        }
        guard let imageData = image.pngData() else { return  }
        
        self.startLoading()
        storage.child("images/\(self.userID ?? "")").putData(imageData, metadata: nil, completion: {_,error in
            
            guard error == nil else{
                print("failed to upload")
                return
            }
            
            self.storage.child("images/\(self.userID ?? "")").downloadURL { (url, error) in
                self.stopLoading()
                
                guard let url = url,error == nil else{
                    return
                }
                
                let refUsers: DatabaseReference! = Database.database().reference().child("users")
                
                let email = self.userNameTxt.text
                let contactNo = self.contactNoTxt.text
                
                let user = ["email":email,"phone":contactNo,"userID":self.userID,"avarter":url.absoluteString]
                
                refUsers.child(self.userID ?? "").setValue(user )
                
                self.fetchUserAccount()
                self.setData()
                
                print(url.absoluteURL)
     
                
            }
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
    
}


