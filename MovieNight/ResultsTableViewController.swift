//
//  ResultsTableViewController.swift
//  MovieNight
//
//  Created by Safwat Shenouda on 09/01/2017.
//  Copyright © 2017 Safwat Shenouda. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {

    var movieDBClient: MovieDBClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = movieDBClient?.selectedMoviesList.count { return count }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomResultsCell

        cell.cellLabel.text = movieDBClient?.selectedMoviesList[indexPath.row].title
        cell.initializeCellColors()
        if let votedMovies = movieDBClient?.votedMovies {
            cell.markVotes(movieVotes: votedMovies)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "goBack") {
            
                movieDBClient?.votedMovies.removeAll()
            
            print(tableView.numberOfRows(inSection: 0))
                for row in 0..<tableView.numberOfRows(inSection: 0) {
                     let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as! CustomResultsCell
                    let vote = MovieVote(title: cell.cellLabel.text!, vote1: cell.button1Voted,vote2: cell.button2Voted)
                    movieDBClient?.votedMovies.append(vote)
            }
            
        }

    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }

    
}
