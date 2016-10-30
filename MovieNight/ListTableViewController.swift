//
//  ListTableViewController.swift
//  MovieNight
//
//  Created by Safwat Shenouda on 28/10/2016.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {

    let movieDBClient = MovieDBClient()
    var stillLoading = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //// list of genres
        stillLoading = true
        
        movieDBClient.loadGenreList() {
            DispatchQueue.main.async {
         
            }
            self.stillLoading = false
            print("now reload data..")
            self.tableView.reloadData()
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print ("geners list = \(movieDBClient.genresList.count)")
        return  movieDBClient.genresList.count
        
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cell for row \(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = movieDBClient.genresList[indexPath.row].name

        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? DetailsTableViewController {
            vc.movieDBClient = movieDBClient
            if let index = tableView.indexPathForSelectedRow {
                let cellText = tableView.cellForRow(at: index)?.textLabel?.text
                let selectedGenre = movieDBClient.genresList.filter() { if $0.name == cellText {return true } else {return false} }
                vc.option = selectedGenre[0].id
                vc.navigationItem.title = selectedGenre[0].name
            }
            
        }
        
        
    }
    
    
    

}
