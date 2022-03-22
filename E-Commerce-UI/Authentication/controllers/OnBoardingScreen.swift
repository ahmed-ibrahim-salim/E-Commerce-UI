//
//  LoadingScreenVC.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/10/22.
//

import UIKit

class OnBoardingScreen: UIViewController {
    @IBOutlet weak var signUpBTN: UIButton!
    @IBAction func loginAction(_ sender: Any) {
        let vc = handleSBs(sbName: "AuthenticationSB", ViewCID: "loginscreen")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signupAction(_ sender: Any) {
        let vc = handleSBs(sbName: "AuthenticationSB", ViewCID: "signupscreen")
        self.navigationController?.pushViewController(vc, animated: true)

    }

    @IBOutlet weak var exploreLBL: UILabel!
    @IBOutlet weak var welcomeLBL: UILabel!
    @IBOutlet weak var logInBTN: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        screenSetter()
    }
    // MARK: - Functions
    func screenSetter(){
        self.navigationController?.navigationBar.isHidden = true
        // shadow
        self.logInBTN.layer.shadowColor = #colorLiteral(red: 0.4577034712, green: 0.7691348791, blue: 1, alpha: 1).cgColor
        self.logInBTN.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        self.logInBTN.layer.shadowOpacity = 0.25
        // defaults
//        self.logInBTN.layer.shadowRadius = 3.0
//        self.logInBTN.layer.masksToBounds = false
        
        self.logInBTN.layer.cornerRadius = 7
        self.logInBTN.setTitle(Constants.logIn.rawValue.localized, for: .normal)
        self.signUpBTN.setTitle(Constants.signUp.rawValue.localized, for: .normal)
        self.welcomeLBL.text = Constants.WelcometoBolt.rawValue.localized
        self.exploreLBL.text = Constants.exploreUs.rawValue.localized
    }
    
}
