//
//  LocationViewController.swift
//  Makan Cuy
//
//  Created by Christian Stevanus on 28/01/20.
//  Copyright © 2020 Christian Stevanus. All rights reserved.
//

import UIKit

protocol LocationAction: class {
    func didTapAllow()
}

class LocationViewController: UIViewController {
    
    @IBOutlet weak var locationView: LocationView!
    //var locationService: LocationService?
    weak var delegate: LocationAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //User authorization
        locationView.didTapAllow = {
                //self?.locationService?.requestLocationAuthorization()
            self.delegate?.didTapAllow()
        }
        
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
