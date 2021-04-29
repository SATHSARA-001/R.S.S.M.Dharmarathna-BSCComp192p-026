//
//  OrderVC.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-01.
//

import UIKit
import Firebase

class OrderVC: UIViewController {
    
    @IBOutlet weak var orderTbl: UITableView!
    
    
    var orderList = [CartObject]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchOrders()
    }
    
    func setDelegates(){
        orderTbl.delegate = self
        orderTbl.dataSource = self
    }
    
    func fetchOrders(){
        
        let orderList: DatabaseReference! = Database.database().reference().child("orders")
        
        orderList.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0{
                self.orderList.removeAll()
                
                for orders in snapshot.children.allObjects as! [DataSnapshot]{
                    let categoryObject = orders.value as? [String: AnyObject]
                    
                    let cart  = categoryObject?["cart"]
                    let time  = categoryObject?["time"]
                    let userID  = categoryObject?["userID"]
                    let totalAmt  = categoryObject?["totalAmt"]
                    let orderStatus = categoryObject?["orderStatus"]
                    let userName = categoryObject?["userName"]
                    let orderID = categoryObject?["orderID"]
                    let orderLocationLatitude = categoryObject?["orderLocationLatitude"]
                    let orderLocationLongitude = categoryObject?["orderLocationLongitude"]
                    let userFCM = categoryObject?["userFCM"]
                    
                    let cartObject = CartObject(cart: cart as? [Cart], time: time as? String, userID: userID as? String, userName: userName as? String, totalAmt: totalAmt as? String,orderStatus:orderStatus as? Int, orderID: orderID as? String,orderLocationLatitude: orderLocationLatitude as? String,orderLocationLongitude: orderLocationLongitude as? String,userFCM: userFCM as? String)
                    
                    let userid = self.defaults.string(forKey: "userID")
                    
                    if cartObject.userID == userid {
                        if cartObject.orderStatus == 1 || cartObject.orderStatus == 2 || cartObject.orderStatus == 3 || cartObject.orderStatus == 4{
                            self.orderList.append(cartObject)
                            
                        }
                    }
                    
                    print(self.orderList.count)
                }
                
                self.orderTbl.reloadData()
                
            }
        }
        
    }
    
    
    
}


extension OrderVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell") as! OrderCell
        cell.configCell(model: orderList[indexPath.row],index: indexPath.row)
        return cell
    }
    
    
}
