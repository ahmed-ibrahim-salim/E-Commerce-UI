//
//  LoginVC.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/10/22.
//

import UIKit
import MOLH
import Toast_Swift

class LoginVC: UIViewController {
    
    @IBAction func loginAction(_ sender: Any) {
        logIn(parameters: self.parameters)
    }
    @IBAction func backBTN(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func signupAction(_ sender: Any) {
        let vc = handleSBs(sbName: "AuthenticationSB", ViewCID: "signupscreen")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBOutlet weak var loginLBL: UILabel!
    let parameters: [String:Any] = [
        "username": "mor_2314",
        "password": "83r5^_"
    ]
    @IBOutlet weak var donthaveaccLBL: UILabel!
    @IBOutlet weak var passwordLBL: UILabel!
    @IBOutlet weak var emailLBL: UILabel!
    @IBOutlet weak var loginBTN: UIButton!
    @IBOutlet weak var signUpBTN: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        screenSetter()
        fixAuthLoop()
        
    }
    func fixAuthLoop(){
        guard let navigationController = self.navigationController else { return }
        if navigationController.viewControllers.count > 2{
            var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
            navigationArray.remove(at: navigationArray.count - 2) // To remove previous UIViewController
            self.navigationController?.viewControllers = navigationArray
        }
    }
    func logIn(parameters: [String:Any]){
        ApiService.shared.loginApi(parameters:parameters,completion: {token in
            if let _ = token {
                UserDefaults.standard.setValue("authenticated", forKey: "authentication")
                MOLH.reset()
            }
        },onError: {errorMessage in
            self.view.makeToast(errorMessage, duration: 3.0, position: .bottom)

            }
        )
    }
    func screenSetter(){
        self.loginBTN.layer.cornerRadius = 7
        // shadow
        self.loginBTN.layer.shadowColor = #colorLiteral(red: 0.4577034712, green: 0.7691348791, blue: 1, alpha: 1).cgColor
        self.loginBTN.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        self.loginBTN.layer.shadowOpacity = 0.25
        // defaults
//        self.loginBTN.layer.shadowRadius = 3.0
//        self.loginBTN.layer.masksToBounds = false
        
        self.loginLBL.text = Constants.logIn.rawValue.localized
        self.loginBTN.setTitle(Constants.logIn.rawValue.localized, for: .normal)
        self.signUpBTN.setTitle(Constants.signUp.rawValue.localized, for: .normal)
        self.donthaveaccLBL.text = Constants.donthaveaccount.rawValue.localized
        self.emailLBL.text = Constants.email.rawValue.localized
        self.passwordLBL.text = Constants.password.rawValue.localized
    }
}
