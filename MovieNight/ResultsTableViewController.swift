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

        return cell
    }
    

    
}
