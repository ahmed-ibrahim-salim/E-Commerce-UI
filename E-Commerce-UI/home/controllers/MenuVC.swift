//
//  MenuVC.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/14/22.
//

import UIKit

class MenuVC: UIViewController {

    @IBAction func profileAction(_ sender: Any) {
        let vc = handleSBs(sbName: "MenuSB", ViewCID: "profile")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func myLocationsBtn(_ sender: Any) {
        let vc = handleSBs(sbName: "MenuSB", ViewCID: "address")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func myCartAction(_ sender: Any) {
        let vc = handleSBs(sbName: "MenuSB", ViewCID: "cart")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func favouriteAction(_ sender: Any) {
        let vc = handleSBs(sbName: "MenuSB", ViewCID: "favourite")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func myOrdersAction(_ sender: Any) {
    }
    @IBAction func languageAction(_ sender: Any) {
    }
    @IBAction func settingsAction(_ sender: Any) {
    }

    
    @IBAction func cancelAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
