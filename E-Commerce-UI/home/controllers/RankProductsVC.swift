//
//  RankDetailsVC.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/14/22.
//

import UIKit

class RankProductsVC: UIViewController {
    
    @IBOutlet weak var collectionV: UICollectionView!
    @IBOutlet weak var pageTitle: UILabel!
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    var collectionVList = [FeaturedListModelElement]()
    var pageTitleTXT = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetter()

    }
    func pageSetter(){
        self.collectionV.layer.cornerRadius = 6
        self.collectionV.register(UINib(nibName: "FeaturedCell", bundle: nil), forCellWithReuseIdentifier: "featuredcell")
        collectionV.delegate = self
        collectionV.dataSource = self
        self.pageTitle.text = pageTitleTXT

    }
}

// MARK: - Extensions
extension RankProductsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionVList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "featuredcell", for: indexPath) as? FeaturedCell
        
        if let url = URL(string: collectionVList[indexPath.row].image ?? ""){
            cell?.setCell(cell: collectionVList[indexPath.row], imageUrl: url)
            }
        cell?.featuredimage.layer.cornerRadius = 5
        return cell ?? UICollectionViewCell()
    }
    
    
}
