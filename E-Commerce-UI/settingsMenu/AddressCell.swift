//
//  AddressCell.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 2/3/22.
//

import UIKit
import DLRadioButton
class AddressCell: UITableViewCell {
    
    @IBOutlet weak var radioButton: DLRadioButton!
    
    
    
    func setRadioBtn(title:String){
        radioButton.setTitle(title, for: .normal)
//        radioButton.isSelected = false
//        radioButton.style
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
