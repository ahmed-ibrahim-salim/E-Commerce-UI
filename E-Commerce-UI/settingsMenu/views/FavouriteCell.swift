//
//  FavouriteCell.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/24/22.
//

import UIKit
import CoreData

protocol FavouriteCellDelegete: AnyObject{
    func removeFromFavourite(itemName: String)
}

class FavouriteCell: UICollectionViewCell{
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    weak var favouriteDelegete: FavouriteCellDelegete?
    // protocol function gets data from cell (titleLbl.text)
    @IBAction func removeAction(_ sender: UIButton) {
        favouriteDelegete?.removeFromFavourite(itemName: titleLbl.text ?? "")
    }
}

