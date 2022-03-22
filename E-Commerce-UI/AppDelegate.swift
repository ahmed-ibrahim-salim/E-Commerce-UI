//
//  AppDelegate.swift
//  E-Commerce-UI
//
//  Created by ahmadibrahim on 1/10/22.
//

import UIKit
import MOLH
import CoreData
import GoogleMaps
import GooglePlaces

@main
class AppDelegate: UIResponder, UIApplicationDelegate ,MOLHResetable{
    var window: UIWindow?
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavouriteModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error, \((error as NSError).userInfo)")
            }
        })
        return container
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        MOLH.shared.activate(true)
        GMSServices.provideAPIKey("AIzaSyBLmq0bLqpE-SLnj9Yg9A-cfsEaxiLJFiI")
        GMSPlacesClient.provideAPIKey("AIzaSyBLmq0bLqpE-SLnj9Yg9A-cfsEaxiLJFiI")
        reset()
        return true
    }
    func whichNavCTRL(sbName: String,rootID: String) -> UINavigationController{
        let story = UIStoryboard(name: sbName, bundle: nil)
        let root = story.instantiateViewController(withIdentifier: rootID)
        let navController = UINavigationController()
        navController.viewControllers = [root]
        return navController
    }
    func reset() {
        let rootViewController: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        if let _ = UserDefaults.standard.string(forKey: "language") {
            if let _ = UserDefaults.standard.string(forKey: "authentication"){
                rootViewController.rootViewController = whichNavCTRL(sbName: "HomeSB", rootID: "homepage")
            }else{
                rootViewController.rootViewController = whichNavCTRL(sbName: "AuthenticationSB", rootID: "onboardingscreen")
            }
        }else{
            let story = UIStoryboard(name: "AuthenticationSB", bundle: nil)
            let root = story.instantiateViewController(withIdentifier: "chooselanguage")
            rootViewController.rootViewController = root
        }
    }
}

