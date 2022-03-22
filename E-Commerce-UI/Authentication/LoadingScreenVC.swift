//
//  LoadingScreenVC.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/10/22.
//

import UIKit

class OnBoardingScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavBar()
    }
    func hideNavBar(){
        self.navigationController?.navigationBar.isHidden = true
    }
    
}
