//
//  FoodVC.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-01.
//

import UIKit

class FoodVC: UIViewController {

    @IBOutlet weak var FoodCategoryCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()

        // Do any additional setup after loading the view.
    }
    
    func setDelegate(){
        FoodCategoryCV.delegate = self
        FoodCategoryCV.dataSource = self
    }


}

extension FoodVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCategoryCell", for: indexPath)
        return cell
    }
    
    
    
}
