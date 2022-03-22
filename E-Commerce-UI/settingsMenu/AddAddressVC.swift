//
//  AddAddress.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 2/2/22.
//

import UIKit
import Toast_Swift

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
    
    @IBAction func addAddressAction(_ sender: Any) {
        saveButton(fullAddress)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetter()
        print(fullAddress)
    }
    
    func pageSetter(){
        self.streetTxtField.becomeFirstResponder()
        
        streetTxtField.returnKeyType = .done
        cityTxtField.returnKeyType = .done
        countryTxtField.returnKeyType = .done
        
        streetTxtField.delegate = self
        cityTxtField.delegate = self
        countryTxtField.delegate = self
        self.useLocationBtn.layer.cornerRadius = 6
    }
    
    var fullAddress: String {
        return "\(streetTxt) \(cityTxt) \(countryTxt)"
    }
    func saveButton(_ fullAddress:String){
        
        CoreDataGeneric.instance.AddToaddressesCoreD(address: fullAddress, compilation: { complete in
            print(complete)
            if let vc = self.navigationController?.viewControllers[2]{
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }, onError: { error in
            print(error)
            
            }
        )
    }
    var streetTxt = String()
    var cityTxt = String()
    var countryTxt = String()
    
    
}

extension AddAddressVC: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        
        func abc(textField:UITextField)->Bool{
            if let txt = textField.text{
                if txt.count == 0 {
                    self.view.makeToast("fields should not be empty", duration: 3.0, position: .center)
                }else if txt.count < 4{
                    self.view.makeToast("Field should be more than 4 Characters", duration: 3.0, position: .center)
                }else {
                    return true
                }
            }
            return false
        }
        
        if textField == streetTxtField{
            if let street = textField.text{
                if abc(textField: textField){
                    streetTxt = street
                }
            }
        }else  if textField == cityTxtField{
            if let street = textField.text{
                if abc(textField: textField){
                    cityTxt = street
                    
                }
                
            }
        }else  if textField == countryTxtField{
            if let street = textField.text{
                if abc(textField: textField){
                    countryTxt = street
                }
            }
        }
        print(fullAddress)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()


        return true
    }
}
