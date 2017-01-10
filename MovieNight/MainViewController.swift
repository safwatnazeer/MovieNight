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
    let movieDBClient = MovieDBClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup gesture recognizers
        let gestureRecognizerFirst = UITapGestureRecognizer(target: self, action: #selector(recognizerActionFirst))
        firstBubble.addGestureRecognizer(gestureRecognizerFirst)
        
        let gestureRecognizerSecond = UITapGestureRecognizer(target: self, action: #selector(recognizerActionSecond))
        firstBubble.addGestureRecognizer(gestureRecognizerFirst)
        secondBubble.addGestureRecognizer(gestureRecognizerSecond)
        
        // hide tool bar 
       // navigationController?.setToolbarHidden(true, animated: false)
        
    }

    func recognizerActionFirst() {
        print("first pressed")
        movieDBClient.currentUserSelecting = .firstUser
        performSegue(withIdentifier: "showGenres", sender: nil)
    }
    func recognizerActionSecond() {
        print("second pressed")
        movieDBClient.currentUserSelecting = .secondUser
        performSegue(withIdentifier: "showGenres", sender: nil)
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showGenres") {
            if let vc = segue.destination as? GenresTableViewController {
                vc.movieDBClient = movieDBClient
                
            }
            
        }
        
        if(segue.identifier == "showResutls") {
            if let vc = segue.destination as? ResultsTableViewController {
                vc.movieDBClient = movieDBClient
                
            }
            
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        print(movieDBClient.selectedMovies)
    }
    
    @IBAction func goBackToMain(segue: UIStoryboardSegue) {
        print ("Here is back from segue")
        // change pictures
        print ("selected movies list: \(movieDBClient.selectedMoviesList)")
        if (movieDBClient.usersWhoFinishedSelection.count > 0) {
            if (movieDBClient.usersWhoFinishedSelection.contains(UsersList.firstUser)) { firstBubble.image = UIImage(named: "bubble-selected")
            }
            if (movieDBClient.usersWhoFinishedSelection.contains(UsersList.secondUser)) { secondBubble.image = UIImage(named: "bubble-selected")
            }
        }
    }

    // start over
    @IBAction func startOver(_ sender: Any) {
        
        firstBubble.image = UIImage(named: "bubble-empty")
        secondBubble.image = UIImage(named: "bubble-empty")
        
        movieDBClient.startOver()
    }
    
    
}
