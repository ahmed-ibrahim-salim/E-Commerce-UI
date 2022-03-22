//
//  CartVC.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/19/22.
//

import UIKit
import CoreData

class CartVC: UIViewController {
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    @IBOutlet weak var collectionV: UICollectionView!
    @IBOutlet weak var cartLBL: UILabel!
    
    var collectionVList = [CartEntity]()
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetter()
    }
    
    // MARK: - page setter
    func pageSetter(){
        self.cartLBL.text = "Cart"
        collectionV.delegate = self
        collectionV.dataSource = self
        self.collectionV.layer.cornerRadius = 6
        self.collectionV.register(UINib(nibName: "CartCell", bundle: nil), forCellWithReuseIdentifier: "cartcell")
        self.collectionVList = CoreDataGeneric.instance.fetchCartItems(entityName: "CartEntity")
    }
}

// MARK: - EXTENSIONS
extension CartVC: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionVList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartcell", for: indexPath) as? CartCell
        
        let url = URL(string: collectionVList[indexPath.row].value(forKey: "image") as? String ?? "" )
    
        cell?.image.sd_setImage(with: url, completed: .none)
        cell?.titleLBL.text = collectionVList[indexPath.row].value(forKey: "title") as? String
        cell?.quantityLBL.text = "\( collectionVList[indexPath.row].value(forKey: "quantity") as? Int ?? 0)"
        cell?.priceLBL.text = "$\(String(collectionVList[indexPath.row].value(forKey: "price") as? Double ?? 0.0))"
        
        
        cell?.cellDelegate = self
        cell?.image.layer.cornerRadius = 5
        return cell ?? UICollectionViewCell()
    }

}

extension CartVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 200)
    }
}

extension CartVC: CartCellDelegate{
    func decreaseQuantity(itemName: String) {
        let products = self.collectionVList.filter{
                $0.value(forKey: "title") as? String == itemName
            }
        if let prod = products.first {
            CoreDataGeneric.instance.decreaseCartItemQuantity(cartItem: prod)
            self.collectionVList = CoreDataGeneric.instance.fetchCartItems(entityName: "CartEntity")
            self.collectionV.reloadData()
        }
    }
    func increaseQuantity(itemName: String) {
        let products = self.collectionVList.filter{
                $0.value(forKey: "title") as? String == itemName
            }
        if let prod = products.first {
            CoreDataGeneric.instance.increaseCartItemQuantity(cartItem: prod)
            self.collectionVList = CoreDataGeneric.instance.fetchCartItems(entityName: "CartEntity")
            self.collectionV.reloadData()
        }
    }
    
    func removeItem(itemName: String) {
        let products = self.collectionVList.filter{
                $0.value(forKey: "title") as? String == itemName
            }
        if let prod = products.first {
            CoreDataGeneric.instance.removeFromCoreD(item: prod)
            self.collectionVList = CoreDataGeneric.instance.fetchCartItems(entityName: "CartEntity")
                print(self.collectionVList.count)
                self.collectionV.reloadData()
        }
    }
}
