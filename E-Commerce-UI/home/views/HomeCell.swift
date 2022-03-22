//
//  HomeCell.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/24/22.
//

import UIKit

protocol DetailNavigationDelegete {
    func navToDetail(product:FeaturedListModelElement)
}

class HomeCell: UITableViewCell {
    
    @IBAction func seeAllAction(_ sender: Any) {
    }
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var collectionV: UICollectionView!
    var delegate: DetailNavigationDelegete?
    var list = Array<FeaturedListModelElement>()
    


    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionV.dataSource = self
        self.collectionV.delegate = self
        self.collectionV.register(UINib(nibName: "FeaturedCell", bundle: nil), forCellWithReuseIdentifier: "featuredcell")
    }
    
    func changeCategoryLbl(at indexPath: IndexPath){
        switch indexPath.row {
        case 1:
            self.titleLbl.text = "Most Wished"
        case 2:
            self.titleLbl.text = "Top Rated"
        default:
            self.titleLbl.text = "Best Seller"
        }
    }
    
    func updateHomeCell(collectionList:[FeaturedListModelElement]){
        self.list = collectionList
        self.collectionV.reloadData()
    }
    
}
extension HomeCell: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "featuredcell", for: indexPath) as? FeaturedCell{
            
            if let url = URL(string: list[indexPath.row].image ?? ""){
                cell.setCell(cell: list[indexPath.row], imageUrl: url)
                cell.featuredimage.layer.cornerRadius = 5
                return cell
                
            }
            
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.delegate?.navToDetail(product: list[indexPath.row])
        
    }
}

extension HomeCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height)
    }
}


