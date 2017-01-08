//
//  OptionsViewController.swift
//  MovieNight
//
//  Created by Safwat Shenouda on 21/11/2016.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import UIKit

class OptionsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
