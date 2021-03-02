//
//  FoodVC.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-01.
//

import UIKit
import Firebase


class FoodVC: UIViewController  {
    
    @IBOutlet weak var FoodCategoryCV: UICollectionView!
    @IBOutlet weak var FoodTbl: UITableView!
    @IBOutlet weak var cartTbl: UITableView!
    @IBOutlet weak var carTitleView: UIView!
    @IBOutlet weak var totalPriceBtn: CustomButton!
    @IBOutlet weak var noOfItemsLbl: UILabel!
    
    let db = Firestore.firestore()
    
    var cart : [Cart] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setDelegate()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupUI()

    }
    
    func setDelegate(){
        FoodCategoryCV.delegate = self
        FoodCategoryCV.dataSource = self
        FoodTbl.delegate = self
        FoodTbl.dataSource = self
        cartTbl.delegate = self
        cartTbl.dataSource = self
    }
    
    func setupUI(){
        
        noOfItemsLbl.text = String(cart.count)+" items"
        if cart.count < 1{
            carTitleView.isHidden = true
            cartTbl.isHidden = true
        }else{
            carTitleView.isHidden = false
            cartTbl.isHidden = false

        }
    }
    
    func getData(){
        
        db.collection("categories").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    let  data = document.data()
                    print(data["name"])
                }
            }
        }
    }
    
}

extension FoodVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCategoryCell", for: indexPath)
        return cell
    }
    
    
    
}

extension FoodVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case FoodTbl :
            return 3
        case cartTbl :
            return cart.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
        case FoodTbl :
            let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell") as! FoodCell
            cell.configCell()
            return cell
            
        case cartTbl :
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell") as! CartCell
            cell.addDelegate = self
            cell.minDelegate = self
            cell.configCell(model: cart[indexPath.row])
            cell.index = indexPath
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell") as! CartCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch tableView {
        case FoodTbl:
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let targetVC = storyboard.instantiateViewController(withIdentifier: "ViewFoodVC") as!ViewFoodVC
            targetVC.delegate = self
            targetVC.index = indexPath.row
            self.navigationController?.pushViewController(targetVC, animated: true)
        default:
            print("")
        }
        
    }
}

extension FoodVC:addItemDelegate{
    func itemAddedToCart(model: Cart?,index:Int?) {
        print("added to cart")
        
        if let cartdate = model {
            cart.append(cartdate)
        }
        
        
        let total = cart.map({(format:String(),$0.total)})
        print(total)
        
        var add = 0
        
        for totValue in total {
            print(totValue)
        }
        cartTbl.reloadData()
        print(cart)
    }
    
  
}

extension FoodVC:addItemsAmtDelegate,minItemsAmtDelegate{
    func addAmtItems(amount: Int?, index: IndexPath?) {
        
        if amount != nil {
            cart[index?.row ?? 0].amount = (amount ?? 0) + 1
        }
        cartTbl.reloadData()
    }
    
    func minAmtItems(amount: Int?, index: IndexPath?) {
        
        if amount != nil {
            if amount! > 0{
                cart[index?.row ?? 0].amount = (amount ?? 0) - 1
            }
        }
         
        cartTbl.reloadData()

    }

}
