//
//  FeaturedCell.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/13/22.
//

import UIKit
import SDWebImage

class FeaturedCell: UICollectionViewCell {
    @IBOutlet weak var priceLBL: UILabel!
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var featuredimage: UIImageView!
    
    func setCell(cell:FeaturedListModelElement,imageUrl:URL){
        featuredimage.sd_setImage(with: imageUrl, completed: .none)
        titleLBL.text = cell.title
        priceLBL.text = "$\(cell.price ?? 0)"
    }
}
