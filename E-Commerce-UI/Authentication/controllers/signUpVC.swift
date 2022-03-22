//
//  signUpVC.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/10/22.
//

import UIKit

class signUpVC: UIViewController {
    // MARK: - Button Actions
    @IBAction func backBTN(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func signupAction(_ sender: Any) {
        signUp(paramters: self.textFieldParameters)
    }
    @IBAction func signinAction(_ sender: Any) {
        let vc = handleSBs(sbName: "AuthenticationSB", ViewCID: "loginscreen")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet weak var signupLBL: UILabel!
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var alreadyhaveaccLBL: UILabel!
    @IBOutlet weak var signupBTN: UIButton!
    @IBOutlet weak var emailLBL: UILabel!
    @IBOutlet weak var passLBL: UILabel!
    @IBOutlet weak var signinBTN: UIButton!
    let textFieldParameters: [String:Any] = [
                            "email":"ahmed@gmail.com",
                            "username":"ahmed1",
                            "password":"abcde",
                            "name":[
                                "firstname":"ahmed",
                                "lastname":"ibrahim"
                            ],
                            "address":[
                                "city":"kilcoole",
                                "street":"7835 new road",
                                "number":3,
                                "zipcode":"12926-3874",
                            "geolocation":[
                            "lat":"-37.3159",
                                "long":"81.1496"
                                ]
                            ],
                            "phone":"1-570-236-7033"
    ]
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetter()
        fixAuthLoop()
        
    }
    // MARK: - functions
    func fixAuthLoop(){
            guard let navigationController = self.navigationController else { return }
            if navigationController.viewControllers.count > 2{
                var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
                navigationArray.remove(at: navigationArray.count - 2) // To remove previous UIViewController
                self.navigationController?.viewControllers = navigationArray
            }
    }
    func signUp(paramters:Dictionary<String,Any>){
        ApiService.shared.signUpApi(parameters:paramters,completion: {(user) in
            self.view.makeToast("Signed up successfully, you can login now", duration: 3.0, position: .bottom)

            print(user?.id ?? 0)
        }, onError:{ errorMessege in
            self.view.makeToast(errorMessege, duration: 3.0, position: .bottom)

        })
    }
    
    func pageSetter(){
        self.signupBTN.layer.cornerRadius = 7
        // shadow
        self.signupBTN.layer.shadowColor = #colorLiteral(red: 0.4577034712, green: 0.7691348791, blue: 1, alpha: 1).cgColor
        self.signupBTN.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        self.signupBTN.layer.shadowOpacity = 0.25
        // defaults
//        self.signupBTN.layer.shadowRadius = 3.0
//        self.signupBTN.layer.masksToBounds = false
        
        self.signinBTN.setTitle(Constants.logIn.rawValue.localized, for: .normal)
        self.signupBTN.setTitle(Constants.signUp.rawValue.localized, for: .normal)
        self.signupLBL.text = Constants.signUp.rawValue.localized
        self.alreadyhaveaccLBL.text = Constants.alreadyhaveacc.rawValue.localized
        self.nameLBL.text = Constants.name.rawValue.localized

        self.emailLBL.text = Constants.email.rawValue.localized
        self.passLBL.text = Constants.password.rawValue.localized
        
    }
}
