//
//  MainViewController.swift
//  MovieNight
//
//  Created by Safwat Shenouda on 31/12/2016.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // outlets
    @IBOutlet weak var firstBubble: UIImageView!
    @IBOutlet weak var secondBubble: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup gesture recognizers
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(recognizerAction))
        firstBubble.addGestureRecognizer(gestureRecognizer)
        
        
        
    }

    func recognizerAction() {
        
        print("Action pressed")
        performSegue(withIdentifier: "showGenres", sender: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
    

}
