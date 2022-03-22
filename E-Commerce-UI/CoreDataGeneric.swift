//
//  CoreDataModel.swift
//  NewUI-UIKit
//
//  Created by ahmadibrahim on 1/5/22.
//
import UIKit
import CoreData

class CoreDataGeneric{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static let instance = CoreDataGeneric()
    
    func AddToaddressesCoreD(address: String, compilation: @escaping(String)->Void,onError:@escaping(String)->Void){
        let coreDataAddress = AddressEntity(context: context)
        coreDataAddress.address = address
        
        do{
            try context.save()
            compilation("Successfully added \(String(describing: coreDataAddress.address)) to address")
        } catch{
            onError("Error adding product to address")
        }
    }
    
    func fetchAddresses(_ entityName:String) -> [AddressEntity]{
        var data = [AddressEntity]()
        let fetchRequest = NSFetchRequest<AddressEntity>(entityName: entityName)
        do {
            let dataArr = try context.fetch(fetchRequest)
            data = dataArr
            print("fetch addresses is successfull")

        } catch  {
            print("No Data from fetch request")
        }
        return data
    }
    
    func decreaseCartItemQuantity(cartItem: NSManagedObject){
        if let quantity = cartItem.value(forKey: "quantity") as? Int{
            if quantity > 1{
                cartItem.setValue(quantity - 1, forKey: "quantity")
                 do {
                     try context.save()
                 }
                 catch {
                     // Handle Error
                 }
            }
        }
    }
    func increaseCartItemQuantity(cartItem: NSManagedObject){
        if let quantity = cartItem.value(forKey: "quantity") as? Int{
           cartItem.setValue(quantity + 1, forKey: "quantity")
            do {
                try context.save()
            }
            catch {
                // Handle Error
            }
        }
    }
    func AddToCartCoreD(cartItem: FeaturedListModelElement,compilation:@escaping(String)->Void,onError:@escaping(String)->Void){
        let prod = CartEntity(context: context)
        prod.id = Int32(cartItem.id ?? 0)
        prod.title = cartItem.title
        prod.price = cartItem.price ?? 0.0
        prod.image = cartItem.image
        do{
            try context.save()
            compilation("Successfully added \(String(describing: prod.title)) to cart")
        } catch{
            onError("Error adding product to cart")
        }
    }
    func AddToFavCoreD(product: FeaturedListModelElement, compilation: @escaping(String)->Void,onError:@escaping(String)->Void){
        let prod = FavouriteEntity(context: context)
        prod.id = Int32(product.id ?? 0)
        prod.title = product.title
        prod.price = product.price ?? 0.0
        prod.image = product.image
        do{
            try context.save()
            compilation("Successfully added \(String(describing: prod.title)) to fav")
        } catch{
            onError("Error adding product to fav")
        }
    }
    
    func removeFromCoreD(item: NSManagedObject){
        context.delete(item)
        do {
            try context.save()
            print("deletion is successfull")
        } catch  {
            print("deletion error")
        }
    }
    func fetchCartItems(entityName:String) -> [CartEntity]{
        var data = [CartEntity]()
        let fetchRequest = NSFetchRequest<CartEntity>(entityName: entityName)
        do {
            let dataArr = try context.fetch(fetchRequest)
            data = dataArr
            print("fetch request is successfull")

        } catch  {
            print("No Data from fetch request")
        }
        return data
    }
    func fetch(entityName:String) -> [NSManagedObject]{
        var data = [NSManagedObject]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            if let dataArr = try context.fetch(fetchRequest) as? [NSManagedObject]{
                data = dataArr
            }else {
                print("No Data from fetch request")
            }
        } catch  {
            print("No Data from fetch request")
        }
        return data
    }
}
