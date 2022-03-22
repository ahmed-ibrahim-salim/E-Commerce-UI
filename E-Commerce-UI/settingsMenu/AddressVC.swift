//
//  AddressVC.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/31/22.
//


// api-key: AIzaSyBLmq0bLqpE-SLnj9Yg9A-cfsEaxiLJFiI
import UIKit
import DLRadioButton

class AddressVC: UIViewController{

    @IBOutlet weak var addAddressBtn: UIButton!
    @IBAction func addAddressAction(_ sender: Any) {
        let vc = handleSBs(sbName: "MenuSB", ViewCID: "addaddress")
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBOutlet weak var addressesTableV: UITableView!
    
    @IBOutlet weak var addressRadioBtn: DLRadioButton!
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    var tableViewList = [AddressEntity]()

    override func viewWillAppear(_ animated: Bool) {
        self.tableViewList = CoreDataGeneric.instance.fetchAddresses("AddressEntity")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    func initViews(){
        self.addressesTableV.register(UINib(nibName: "AddressCell", bundle: nil), forCellReuseIdentifier: "addresscell")
        
        self.addAddressBtn.layer.cornerRadius = 8
        addressesTableV.delegate = self
        addressesTableV.dataSource = self

    }
}

extension AddressVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "addresscell") as? AddressCell{
            
            cell.setRadioBtn(title: tableViewList[indexPath.row].value(forKey: "address") as! String)
            return cell

        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
}
