//
//  CutomeNavigationController.swift
//  MovieNight
//
//  Created by Safwat Shenouda on 08/01/2017.
//  Copyright © 2017 Safwat Shenouda. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup navigation contoller appearence
        navigationBar.barTintColor = UIColor.red
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        toolbar.barTintColor = UIColor.red
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
        

}
