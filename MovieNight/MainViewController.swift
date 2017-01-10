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
    
    // model instance
    let movieDB = MovieDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup gesture recognizers
        let gestureRecognizerFirst = UITapGestureRecognizer(target: self, action: #selector(recognizerActionFirst))
        firstBubble.addGestureRecognizer(gestureRecognizerFirst)
        
        let gestureRecognizerSecond = UITapGestureRecognizer(target: self, action: #selector(recognizerActionSecond))
        firstBubble.addGestureRecognizer(gestureRecognizerFirst)
        secondBubble.addGestureRecognizer(gestureRecognizerSecond)
        
        
        
    }

    func recognizerActionFirst() {
        print("first pressed")
        movieDB.currentUserSelecting = .firstUser
        performSegue(withIdentifier: "showGenres", sender: nil)
    }
    func recognizerActionSecond() {
        print("second pressed")
        movieDB.currentUserSelecting = .secondUser
        performSegue(withIdentifier: "showGenres", sender: nil)
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "showGenres") {
            if let vc = segue.destination as? GenresTableViewController {
                vc.movieDB = movieDB
            }
        }
        
        if(segue.identifier == "showResutls") {
            if let vc = segue.destination as? ResultsTableViewController {
                vc.movieDB = movieDB
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
    @IBAction func goBackToMain(segue: UIStoryboardSegue) {
        
        // change images
        if (movieDB.usersWhoFinishedSelection.count > 0) {
            if (movieDB.usersWhoFinishedSelection.contains(UsersList.firstUser)) { firstBubble.image = UIImage(named: "bubble-selected")
            }
            if (movieDB.usersWhoFinishedSelection.contains(UsersList.secondUser)) { secondBubble.image = UIImage(named: "bubble-selected")
            }
        }
    }

    // start over
    @IBAction func startOver(_ sender: Any) {
        
        firstBubble.image = UIImage(named: "bubble-empty")
        secondBubble.image = UIImage(named: "bubble-empty")
        
        movieDB.startOver()
    }
    
    
}
