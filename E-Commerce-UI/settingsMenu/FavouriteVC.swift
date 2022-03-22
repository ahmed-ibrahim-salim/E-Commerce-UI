//
//  FavouriteVC.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/18/22.
//

import UIKit
import CoreData
class FavouriteVC: UIViewController {

    @IBOutlet weak var collectionV: UICollectionView!
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    @IBOutlet weak var favLBL: UILabel!
    var collectionVList = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetter()
        
    }
    func pageSetter(){
        self.favLBL.text = "Favourite"
        self.collectionV.layer.cornerRadius = 6
        self.collectionV.register(UINib(nibName: "FavouriteCell", bundle: nil), forCellWithReuseIdentifier: "favouritecell")
        collectionV.delegate = self
        collectionV.dataSource = self
        self.collectionVList = CoreDataGeneric.instance.fetch(entityName: "FavouriteEntity")
    }
   }
extension FavouriteVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionVList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favouritecell", for: indexPath) as? FavouriteCell
        
        let url = URL(string: collectionVList[indexPath.row].value(forKey: "image") as? String ?? "" )
        cell?.favouriteDelegete = self
        cell?.image.sd_setImage(with: url, completed: .none)
        cell?.titleLbl.text = collectionVList[indexPath.row].value(forKey: "title") as? String
        cell?.priceLbl.text = "$\(String(collectionVList[indexPath.row].value(forKey: "price") as? Double ?? 0.0))"
        cell?.image.layer.cornerRadius = 5
        return cell ?? UICollectionViewCell()
    }
}
extension FavouriteVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.2, height: collectionView.frame.height / 2)
    }
}
extension FavouriteVC: FavouriteCellDelegete{
    func removeFromFavourite(itemName: String) {
        let products = self.collectionVList.filter{
                $0.value(forKey: "title") as? String == itemName
            }
        if let prod = products.first {
            CoreDataGeneric.instance.removeFromCoreD(item: prod)
            self.collectionVList = CoreDataGeneric.instance.fetch(entityName: "FavouriteEntity")
                print(self.collectionVList.count)
                self.collectionV.reloadData()
        }
    }
}
