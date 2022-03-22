//
//  HomeVC.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/13/22.
//

import UIKit
import SDWebImage
class HomeVC: UIViewController {
    
    @IBAction func menuAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "menuvc")
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    @IBOutlet weak var searchStackV: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    
    var list = [FeaturedListModelElement](){
        didSet{
            if list.count != 0{
                self.featuredlist = Array(list[0...6])
                self.mostWishedlist = Array(list[6...10])
                self.topRatedlist = Array(list[11...16])
            }
        }
    }
    var featuredlist = Array<FeaturedListModelElement>()
    var mostWishedlist = Array<FeaturedListModelElement>()
    var topRatedlist = Array<FeaturedListModelElement>()
    
    // MARK: - life Cycle
    override func viewWillAppear(_ animated: Bool) {
        getRank()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetter()
    }
    // MARK: - Setters
    func pageSetter(){
        self.searchStackV.layer.backgroundColor = UIColor.white.cgColor
        self.searchStackV.layer.borderColor = UIColor.gray.withAlphaComponent(0.1).cgColor
        self.searchStackV.layer.borderWidth = 0.3
        self.searchStackV.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
        self.searchStackV.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).cgColor
        self.searchStackV.layer.shadowOpacity = 0.05
        
        self.navigationController?.navigationBar.isHidden = true
        self.searchStackV.layer.cornerRadius = 6
        
        self.tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "homecell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    // MARK: - ApiCall
    private func getRank(){
        ApiService.shared.getHomeData(){ featured in
            self.list = featured!
            self.tableView.reloadData()            
        } onError: { (errorMessage) in
            debugPrint(errorMessage)
        }
    }
}


// MARK: - Extensions
extension HomeVC: UITableViewDelegate,UITableViewDataSource, DetailNavigationDelegete{

    func navToDetail(product: FeaturedListModelElement) {
        let destinationVC = storyboard?.instantiateViewController(identifier: "productdetail") as? ProductDetailVC
        destinationVC?.product = product
        navigationController?.pushViewController(destinationVC ?? UIViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "homecell") as? HomeCell{
            
            switch indexPath.row{
            case 1:
                cell.updateHomeCell(collectionList: featuredlist)
            case 2:
                cell.updateHomeCell(collectionList: topRatedlist)
            default:
                cell.updateHomeCell(collectionList: mostWishedlist)
            }
            
            cell.changeCategoryLbl(at: indexPath)
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
}
