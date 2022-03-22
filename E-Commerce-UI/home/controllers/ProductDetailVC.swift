//
//  ProductDetailVC.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/17/22.
//

import UIKit
import CoreData
class ProductDetailVC: UIViewController {
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var addtofavBTN: UIButton!
    @IBAction func addtofavAction(_ sender: Any) {
        let numOfprod = allProducts.filter{ $0.value(forKey: "id") as? Int == product?.id}
        if numOfprod.isEmpty {
            addTofav(productToAdd: product)
        }else{
            removefromfav(productToRemove: product)
        }
    }
    // MARK: - add to cart
    
    @IBAction func addToCartAction(_ sender: Any) {
        addToCart(cartProduct: product)
//        let vc = handleSBs(sbName: "MenuSB", ViewCID: "cart")
//        navigationController?.pushViewController(vc, animated: true)
    }
    @IBOutlet weak var addtoFav: UIButton!
    @IBOutlet weak var reviewsCountLBL: UILabel!
    @IBOutlet weak var priceScratchedLBL: UILabel!
    @IBOutlet weak var priceLBL: UILabel!
    @IBOutlet weak var TITLELBL: UILabel!
    @IBOutlet weak var descriptionLBL: UILabel!
    @IBOutlet weak var ratingLBL: UILabel!
    @IBOutlet weak var scratechedPrice: UILabel!
    
    @IBOutlet weak var addToCartBTNTitle: UIButton!
    var productsInCart = CoreDataGeneric.instance.fetch(entityName: "CartEntity")
    var allProducts = CoreDataGeneric.instance.fetch(entityName: "FavouriteEntity")
    var product: FeaturedListModelElement?
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkProdInFavourite()
        pageSetter()
        checkProdInCart()
//        self.addToCartBTNTitle.setTitle("ADD TO CART", for: .normal)

    }
    // MARK: - check product in cart
    
    func checkProdInCart(){
        let cartlist = productsInCart.filter{ $0.value(forKey: "id") as? Int == product?.id}
        if cartlist.isEmpty {
            self.addToCartBTNTitle.setTitle("ADD TO CART", for: .normal)
        }else{
            self.addToCartBTNTitle.setTitle("IN CART", for: .normal)
            self.addToCartBTNTitle.isEnabled = false
        }
    }
    // MARK: - add to cart

    func addToCart(cartProduct: FeaturedListModelElement?){
        if let prod =  cartProduct{
            CoreDataGeneric.instance.AddToCartCoreD(cartItem: prod,compilation: {(messege)in
                self.addToCartBTNTitle.setTitle("IN CART", for: .normal)
                self.addToCartBTNTitle.isEnabled = false
                self.view.makeToast("added to cart", duration: 3.0, position: .bottom)
            }, onError:
                {(a)in
//                self.addToCartBTNTitle.setTitle("ADD TO CART", for: .normal)
                self.view.makeToast("error happened, please try again later", duration: 3.0, position: .bottom)
            })
            productsInCart = CoreDataGeneric.instance.fetch(entityName: "CartEntity")
        }
    }
    // MARK: - remove from favourite
    
    func removefromfav(productToRemove: FeaturedListModelElement?){
            self.addtoFav.setImage(UIImage(named: "star"), for: .normal)
        let productsToDelete = self.allProducts.filter{
                $0.value(forKey: "id") as? Int == productToRemove?.id
            }
            for product in productsToDelete{
                CoreDataGeneric.instance.removeFromCoreD(item: product)
            }
        }
    // MARK: - add to favourite

    func addTofav(productToAdd: FeaturedListModelElement?){
        if let prod =  productToAdd{
            CoreDataGeneric.instance.AddToFavCoreD(product: prod,compilation:
                {(message) in
                    self.addtoFav.setImage(UIImage(named: "starfilled"), for: .normal)
                    self.view.makeToast("added to favourite", duration: 3.0, position: .bottom)

                },onError: {(message) in
                    self.addtoFav.setImage(UIImage(named: "star"), for: .normal)
                    self.view.makeToast("error happened, please try again later", duration: 3.0, position: .bottom)
                })
            allProducts = CoreDataGeneric.instance.fetch(entityName: "FavouriteEntity")
        }
    }
    // MARK: - check product in favourite
    func checkProdInFavourite(){
        let favlist = allProducts.filter{ $0.value(forKey: "id") as? Int == product?.id}
        if favlist.isEmpty {
            self.addtoFav.setImage(UIImage(named: "star"), for: .normal)
        }else{
            self.addtoFav.setImage(UIImage(named: "starfilled"), for: .normal)
        }
    }
    // MARK: - page setter

    func pageSetter(){
        // add corner radius to uilabel with background color
        self.ratingLBL.layer.masksToBounds = true
        self.ratingLBL.layer.cornerRadius = 5
        // check favourite status
        
        let priceScratched = product?.price ?? 0.0
        self.priceLBL.text = "\(product?.price ?? 0.0)"
        self.TITLELBL.text = product?.title
        self.descriptionLBL.text = product?.featuredListModelDescription
        self.ratingLBL.text = "\(product?.rating?.rate ?? 0.0)"
        self.reviewsCountLBL.text = "\(product?.rating?.count ?? 0) Reviews"
        // scrateched text
        let myDouble = priceScratched + 48.0
        let doubleStr = String(format: "%.2f", myDouble) // 2 decimal places only

        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "$\(doubleStr)")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        self.scratechedPrice.attributedText = attributeString

    }
}
