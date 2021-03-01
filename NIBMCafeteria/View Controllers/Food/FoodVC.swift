//
//  FoodVC.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-01.
//

import UIKit

class FoodVC: UIViewController {

    @IBOutlet weak var FoodCategoryCV: UICollectionView!
    @IBOutlet weak var FoodTbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()

        // Do any additional setup after loading the view.
    }
    
    func setDelegate(){
        FoodCategoryCV.delegate = self
        FoodCategoryCV.dataSource = self
        FoodTbl.delegate = self
        FoodTbl.dataSource = self
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
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell") as! FoodCell
        cell.configCell()
        return cell
    }
    
    
}
