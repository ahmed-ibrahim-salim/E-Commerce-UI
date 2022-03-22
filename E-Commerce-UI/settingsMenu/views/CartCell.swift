//
//  CartCell.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/19/22.
//

import UIKit
import CoreData

protocol CartCellDelegate: AnyObject {
    func removeItem(itemName: String)
    func increaseQuantity(itemName: String)
    func decreaseQuantity(itemName: String)

}

class CartCell: UICollectionViewCell {
    @IBOutlet weak var titleLBL: UILabel!
    
    @IBOutlet weak var priceLBL: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var quantityLBL: UILabel!

    @IBOutlet weak var removeFromCartBTN: UIButton!
    
    
    weak var cellDelegate: CartCellDelegate?
    
    func setCell(cell:FeaturedListModelElement,imageUrl:URL){
        image.sd_setImage(with: imageUrl, completed: .none)
        titleLBL.text = cell.title
        priceLBL.text = "$\(cell.price ?? 0)"
    }
    
    @IBAction func removeFromCartBtnTapped(_ sender: UIButton) {
        cellDelegate?.removeItem(itemName: titleLBL.text ?? "" )
    }
    @IBAction func minusAction(_ sender: UIButton) {
        cellDelegate?.decreaseQuantity(itemName: titleLBL.text ?? "")
    }
    @IBAction func plusAction(_ sender: UIButton) {
        cellDelegate?.increaseQuantity(itemName: titleLBL.text ?? "")

    }
}
