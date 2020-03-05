//
//  AppDelegate.swift
//  Makan Cuy
//
//  Created by Christian Stevanus on 28/01/20.
//  Copyright © 2020 Christian Stevanus. All rights reserved.
//

import UIKit
import Moya
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let window = UIWindow()
    let locationService = LocationService()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let service = MoyaProvider<YelpService.BusinessesProvider>()
    let jsonDecoder = JSONDecoder()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        service.request(.details(id: "WavvLdfdP6g8aZTtbBQHTw")) { (result) in
            switch result {
            case .success(let response):
                let detail = try? self.jsonDecoder.decode(Details.self, from: response.data)
                print("Details : \n\n \(detail)")
            case .failure(let error):
                print("error to get details : \(error)")
            }
        }
        
        //Hit API
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        //Get location
        locationService.didChangeStatus = { [weak self] success in
            if success {
                self?.locationService.getLocation()
            }
        }
        
        locationService.newLocation = { [weak self] result in
            switch result {
            case .success(let location):
                self?.loadBusinesses(with: location.coordinate)
            case .failure(let error):
                assertionFailure("Error getting user location \(error)")
                
            }
        }
        
        //Check Location
        switch locationService.status {
        case .notDetermined, .denied, .restricted:
            let locationViewController = storyboard.instantiateViewController(withIdentifier: "LocationViewController") as? LocationViewController
            
            //locationViewController?.locationService = locationService
            locationViewController?.delegate = self
            
            window.rootViewController = locationViewController
        default:
            let nav = storyboard.instantiateViewController(withIdentifier: "WartegNavigationController") as? UINavigationController
            window.rootViewController = nav
            //loadBusinesses() //HIT API
            locationService.getLocation()
        }
        
        window.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    private func loadBusinesses(with coordinate: CLLocationCoordinate2D) {
        service.request(.search(lat: coordinate.latitude, long: coordinate.longitude)) { [weak self] (result) in
            switch result {
            case .success(let response):
                guard let strongSelf = self else {return}
                let root = try? strongSelf.jsonDecoder.decode(Root.self, from: response.data)
                let viewModel = root?.businesses
                    .compactMap(WarungListViewModel.init)
                    .sorted(by: { $0.distance < $1.distance})
                
                if let nav = strongSelf.window.rootViewController as? UINavigationController,
                    let warungListViewController = nav.topViewController as? WarungTableViewController {
                    warungListViewController.viewModel = viewModel ?? []
                }
                
            case .failure(let error):
                print("My Error : \(error)")
            }
        }
    }
    
}

extension AppDelegate: LocationAction{
    func didTapAllow() {
        locationService.requestLocationAuthorization()
    }
    
    
}

