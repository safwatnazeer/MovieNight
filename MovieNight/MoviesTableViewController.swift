//
//  DetailsTableViewController.swift
//  MovieNight
//
//  Created by Safwat Shenouda on 28/10/2016.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {

    
    @IBOutlet weak var toolBarItem: UIBarButtonItem!
    
    
    var movieDBClient: MovieDBClient?
    var genresList:[Int]?   // array contains indices of selected Genres
    var actorsList: [Int]?  // array contains indices of selected Actors
    var currentPage:Int = 0
    
    var stillLoading = false
    var selectedItems=[Int]()
    var totalPages = 1
    
    
    @IBAction func done(_ sender: Any) {
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup navigation contoller appearence
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        tableView.separatorStyle = .none
        navigationController?.toolbar.barTintColor = UIColor.red
        
        
        //
        updateToolbar()
        
        
        loadNextPage()
        
    }
    

    func loadNextPage(){
        stillLoading = true
        if let generesList = self.genresList , let movieDBClient = self.movieDBClient , let actorsList = self.actorsList {
            movieDBClient.loadMovies(for: generesList, actorsIDs: actorsList ,pageNumber: currentPage + 1 ) { list, totalPages in
                movieDBClient.movieList.append(contentsOf: list)
                self.currentPage += 1
                self.totalPages = totalPages
                self.stillLoading = false
                DispatchQueue.main.async {
                    // update UI
                    self.tableView.reloadData()
                }
            }
        }

    }



    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print ("Will display called for: \(indexPath.row)")
        let diff = movieDBClient!.movieList.count - (indexPath.row + 1)
        print ("diff = \(diff) , showList count =\(movieDBClient?.movieList.count), IndexPath+1 = \(indexPath.row+1) ")
        if (diff < 1 && currentPage < totalPages) {
            print("Loading next page after: \(currentPage)")
            loadNextPage()
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print ("list = \(movieDBClient?.movieList.count)")
        return movieDBClient!.movieList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomMovieCell

        cell.cellLabel.text = movieDBClient?.movieList[indexPath.row].title
        // set selection image
        if (selectedItems.contains(indexPath.row)) {
            cell.cellImage.image = UIImage(named: "selected")
        } else {
            cell.cellImage.image = UIImage(named: "empty2")
        }
        //let id = showList[indexPath.row].id
        //cell.detailTextLabel?.text = "\(id)"

        return cell
    }
    

    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    
        // go back to main controller
        if (segue.identifier == "goBack") {
            if let vc = segue.destination as? MainViewController {
            
                // copy selected movies to the movieDBClient
                print("List of selected movies indices:\(selectedItems)")
                movieDBClient?.selectedMovies = selectedItems
                for index in selectedItems {
                    print("adding film index: \(index) , movie: \(movieDBClient!.movieList[index])")
                    movieDBClient!.selectedMoviesList.append(movieDBClient!.movieList[index])
                }
                // add user to list of who finished selection
                movieDBClient?.addUser()
                print("\(movieDBClient!.selectedMoviesList)")
                
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomMovieCell
        
        if (selectedItems.contains(indexPath.row)) {
            cell.cellImage.image = UIImage(named: "empty2")
            // cell.cellSelected = false
            let itemIndex = selectedItems.index(of: indexPath.row)
            selectedItems.remove(at: itemIndex!)
            updateToolbar()
        } else {
            if (selectedItems.count < 5 ) {
                cell.cellImage.image = UIImage(named: "selected")
                //   cell.cellSelected = true
                if (!selectedItems.contains(indexPath.row)) {selectedItems.append(indexPath.row) }
                updateToolbar()
            }
        }
        print(selectedItems)
        //cell.cellLabel.text = movieDBClient.genresList[indexPath.row].name
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    func updateToolbar() {
        toolBarItem.title =  "\(selectedItems.count) of 5 selected"
    }

    
    
}
