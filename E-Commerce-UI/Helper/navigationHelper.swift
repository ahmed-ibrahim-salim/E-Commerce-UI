//
//  navigationHelper.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/10/22.
//

import UIKit

extension UIViewController{
    func handleSBs(sbName: String,ViewCID:String,navTitle: String = "") -> UIViewController {
        let sb = UIStoryboard(name: sbName, bundle: nil)
        
        let vc = sb.instantiateViewController(identifier: ViewCID)
        
//        navigationItem.backButtonTitle = ""
//        vc.navigationItem.title = navTitle
        return vc
    }
}
