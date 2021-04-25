//
//  FoodVC.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-01.
//

import UIKit
import FirebaseStorage
import Firebase


class FoodVC: UIViewController,LoadingIndicatorDelegate  {
    
    @IBOutlet weak var FoodCategoryCV: UICollectionView!
    @IBOutlet weak var FoodTbl: UITableView!
    @IBOutlet weak var cartTbl: UITableView!
    @IBOutlet weak var carTitleView: UIView!
    @IBOutlet weak var totalPriceBtn: CustomButton!
    @IBOutlet weak var noOfItemsLbl: UILabel!
    
    let ref: DatabaseReference! = Database.database().reference().child("orders")
    let defaults = UserDefaults.standard
    
    
    var cart : [Cart] = []
    
    var add:Double = 0
    var foodList = [Food]()
    var filteredFoodList = [Food]()
    var categoryList = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCategories()
        fetchFoods()
        setDelegate()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupUI()
        
    }
    
    func fetchCategories(){
        let categoriesListRef: DatabaseReference! = Database.database().reference().child("categories")
        
        categoriesListRef.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0{
                self.categoryList.removeAll()
                
                for categories in snapshot.children.allObjects as! [DataSnapshot]{
                    let categoryObject = categories.value as? [String: AnyObject]
                    
                    let categoryID  = categoryObject?["categoryID"]
                    let categoryName  = categoryObject?["categoryName"]
                    
                    let category = Category(categoryID: categoryID as! String?, categoryName: categoryName as! String?)
                    
                    //appending it to list
                    self.categoryList.append(category)
                    print(self.categoryList.count)
                }
                
                self.FoodCategoryCV.reloadData()
                
            }
        }
        
    }
    
    func fetchFoods(){
        let foodListRef: DatabaseReference! = Database.database().reference().child("foods")
        
        foodListRef.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0{
                self.foodList.removeAll()
                
                for foods in snapshot.children.allObjects as! [DataSnapshot]{
                    let foodObject = foods.value as? [String: AnyObject]
                    
                    let categoryName = foodObject?["categoryName"]
                    let foodDescription  = foodObject?["itemDescription"]
                    let foodname = foodObject?["itemName"]
                    let foodprice  = foodObject?["itemPrice"]
                    let offer  = foodObject?["itemDiscount"]
                    let image = foodObject?["imageURL"]
                    
                    let food = Food(categoryName: categoryName as! String?, foodDescription: foodDescription as! String?, foodname: foodname as! String?, foodprice: foodprice as! String?, offer: offer as! String?, image: image as! String?)
                    //appending it to list
                    self.foodList.append(food)
                }
                
                self.FoodTbl.reloadData()
            }
        }
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
    
    
    @IBAction func clickOrder(_ sender: Any) {
        if cart.count > 0{
            
            var totalAmt = 0.0
            
            let time = Date().convertDateToString(.FullDateTime_WithSlash_12Hours_dMy)
            let userID = defaults.string(forKey: "userID") ?? ""
            let userName = defaults.string(forKey: "userName") ?? ""
            
            let total = cart.map({($0.total)})
            
            for totValue in total {
                totalAmt = (totalAmt + totValue!)
            }
            
            let totalIS = String(totalAmt)
            
            let cartObject = CartObject(cart: cart,time:time, userID: userID, userName: userName,totalAmt:totalIS, orderStatus: 1 )
            
            do{
                
                let obj =  try cartObject.toDictionary()
                
                self.ref.childByAutoId().setValue(obj)
                
                cart.removeAll()
                cartTbl.reloadData()
                setupUI()
                totalPriceBtn.setTitle("Order", for: .normal)
            }catch{
                
            }
            
        }
    }
    
    
}

extension FoodVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCategoryCell", for: indexPath) as! FoodCategoryCell
        cell.configCell(model: categoryList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCategoryName = categoryList[indexPath.row].categoryName
        filteredFoodList = foodList.filter({$0.categoryName == selectedCategoryName})
        self.FoodTbl.reloadData()
        
    }
}

extension FoodVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case FoodTbl :
            return filteredFoodList.count
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
            cell.configCell(model: filteredFoodList[indexPath.row])
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
            let targetVC = storyboard.instantiateViewController(withIdentifier: "ViewFoodVC") as! ViewFoodVC
            targetVC.delegate = self
            targetVC.index = indexPath.row
            targetVC.foodDetails = filteredFoodList[indexPath.row]
            self.navigationController?.pushViewController(targetVC, animated: true)
        default:
            print("")
        }
        
    }
}

extension FoodVC:addItemDelegate{
    func itemAddedToCart(model: Cart?,index:Int?) {
        print("added to cart")
        var add:Double = 0
        if let cartdate = model {
            cart.append(cartdate)
        }
        
        let total = cart.map({($0.total)})
        print(total)
        
        for totValue in total {
            add = (add + totValue!)
        }
        
        print(add)
        let totPrice = "Order (Rs."+(String(add)+")")
        totalPriceBtn.setTitle(totPrice, for: .normal)
        cartTbl.reloadData()
        print(cart)
    }
    
}

extension FoodVC:addItemsAmtDelegate,minItemsAmtDelegate{
    func addAmtItems(amount: Int?, index: IndexPath?) {
        
        if amount != nil {
            
            var add:Double = 0
            
            let foodPrice = cart[index?.row ?? 0].foodPrice
            
            cart[index?.row ?? 0].amount = Int(Double((amount ?? 0) + 1))
            let addedAmt = Double(cart[index?.row ?? 0].amount ?? 0)
            cart[index?.row ?? 0].total =  addedAmt * foodPrice!
            
            
            
            let total = cart.map({($0.total)})
            
            for totValue in total {
                add = (add + totValue!)
            }
            
            let totPrice = "Order Rs. "+(String(add))
            totalPriceBtn.setTitle(totPrice, for: .normal)
        }
        cartTbl.reloadData()
    }
    
    func minAmtItems(amount: Int?, index: IndexPath?) {
        
        var add:Double = 0
        
        if amount != nil {
            if amount! > 0{
                
                let foodPrice = cart[index?.row ?? 0].foodPrice
                cart[index?.row ?? 0].amount = Int(Double((amount ?? 0) - 1))
                let addedAmt = Double(cart[index?.row ?? 0].amount ?? 0)
                cart[index?.row ?? 0].total =  addedAmt * foodPrice!
                
                let total = cart.map({($0.total)})
                
                for totValue in total {
                    add = (add + totValue!)
                }
                
                let totPrice = "Order Rs. "+(String(add))
                totalPriceBtn.setTitle(totPrice, for: .normal)
            }
            
            
        }
        cartTbl.reloadData()
        
    }
    
}
