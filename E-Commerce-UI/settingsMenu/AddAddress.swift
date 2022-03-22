//
//  AddAddress.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 2/2/22.
//

import UIKit

class AddAddressVC: UIViewController {
    @IBOutlet weak var countryTxtField: UITextField!
    @IBOutlet weak var streetTxtField: UITextField!
    @IBOutlet weak var cityTxtField: UITextField!
    @IBOutlet weak var useLocationBtn: UIButton!
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func useLocationAction(_ sender: Any) {
        let vc = handleSBs(sbName: "MenuSB", ViewCID: "map")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetter()
    }
    func pageSetter(){
        self.streetTxtField.becomeFirstResponder()
        streetTxtField.delegate = self
        cityTxtField.delegate = self
        countryTxtField.delegate = self
        self.useLocationBtn.layer.cornerRadius = 6
    }
}

//extension AddAddress
