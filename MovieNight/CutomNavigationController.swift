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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
