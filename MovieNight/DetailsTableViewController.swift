//
//  DetailsTableViewController.swift
//  MovieNight
//
//  Created by Safwat Shenouda on 28/10/2016.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {

    var movieDBClient: MovieDBClient?
    var option:Int?
    var currentPage:Int = 0
    
    var stillLoading = false
    var showList = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        loadNextPage()
        
    }

    func loadNextPage(){
        stillLoading = true
        if let option = self.option , let movieDBClient = self.movieDBClient {
            movieDBClient.loadMovies(for: option, pageNumber: currentPage + 1 ) { list in
                self.showList.append(contentsOf: list)
                self.currentPage += 1
                self.stillLoading = false
                self.tableView.reloadData()
            }
        }

    }



    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print ("Will display called for: \(indexPath.row)")
        let diff = showList.count - (indexPath.row + 1)
        if (diff < 1) {
            print("Loading next page after: \(currentPage)")
            loadNextPage()
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print ("list = \(showList.count)")
        return showList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = showList[indexPath.row].title
        let id = showList[indexPath.row].id
        cell.detailTextLabel?.text = "\(id)"

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        
        
        
        if let vc = segue.destination as? PosterViewController {
            vc.movieDBClient = movieDBClient
            vc.movieId = 188927
            if let cell = sender as? UITableViewCell, let detailText = cell.detailTextLabel?.text {
                let id = Int(detailText)
                vc.movieId = id!
                vc.navigationItem.title = cell.textLabel?.text
            }
        }
    
    }
    

}
