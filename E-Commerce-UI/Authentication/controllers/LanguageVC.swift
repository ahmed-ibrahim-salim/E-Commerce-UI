//
//  LanguageVC.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/12/22.
//

import UIKit
import MOLH
class LanguageVC: UIViewController {
    @IBOutlet weak var arabicLangBTN: UIButton!

    @IBOutlet weak var englishLangBTN: UIButton!
    @IBAction func arabicAction(_ sender: Any) {
        UserDefaults.standard.setValue("ar", forKey: "language")
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "ar")
        MOLH.reset()
    }
    @IBAction func engAction(_ sender: Any) {
        UserDefaults.standard.setValue("en", forKey: "language")
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "en" : "en")
        MOLH.reset()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetter()       
    }
    func pageSetter(){
        self.navigationController?.navigationBar.isHidden = true
        // shadow
        self.arabicLangBTN.layer.shadowColor = #colorLiteral(red: 0.4577034712, green: 0.7691348791, blue: 1, alpha: 1).cgColor
        self.arabicLangBTN.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        self.arabicLangBTN.layer.shadowOpacity = 0.25
        // defaults
//        self.arabicLangBTN.layer.shadowRadius = 3.0
//        self.arabicLangBTN.layer.masksToBounds = false
        
        self.arabicLangBTN.layer.cornerRadius = 7
        self.arabicLangBTN.setTitle("العربيه", for: .normal)
        self.englishLangBTN.setTitle("English", for: .normal)
    }
}
