//
//  ActorsTableViewController.swift
//  MovieNight
//
//  Created by Safwat Shenouda on 08/01/2017.
//  Copyright © 2017 Safwat Shenouda. All rights reserved.
//

import UIKit

class ActorsTableViewController: UITableViewController {
    @IBOutlet weak var toolBarItem: UIBarButtonItem!
    

    var movieDB: MovieDB?
    var currentPage:Int = 0 // support pagination to allow large number of actors
    var stillLoading = false
    var genresList:[Int]?
    var selectedItems=[Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        updateToolbar()
        // load actors
        loadNextPage()
        
    }
    
    
    func loadNextPage(){
        stillLoading = true
        if let movieDB = self.movieDB {
            movieDB.loadActorsList(pageNumber: currentPage + 1 ) {
                list in
                movieDB.actorsList.append(contentsOf: list)
                self.currentPage += 1
                self.stillLoading = false
                DispatchQueue.main.async {
                    // update UI
                    self.tableView.reloadData()
                }
            }
        }
        
    }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (!stillLoading) {
            return movieDB!.actorsList.count
        } else {
            return 0
        }

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomActorCell
        // set name
        cell.cellLabel.text = movieDB?.actorsList[indexPath.row].name
        // set selection image
        if (selectedItems.contains(indexPath.row)) {
            cell.cellImage.image = UIImage(named: "selected")
        } else {
            cell.cellImage.image = UIImage(named: "empty2")
        }
        
        // get actor image
        if let movieDB = self.movieDB {
            movieDB.apiClient.downloadLoadImageData(imagePath: movieDB.actorsList[indexPath.row].profilePath) {
                image in
                DispatchQueue.main.async {
                    cell.actorImage.image = image
                    
                }

            }
        
        }
        
        return cell
    }
    
    // load next set of actors when user scrolls down
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print ("Will display called for: \(indexPath.row)")
        let diff = movieDB!.actorsList.count - (indexPath.row + 1)
        if (diff < 1) {
            print("Loading next page after: \(currentPage)")
            loadNextPage()
        }
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomActorCell
        if (selectedItems.contains(indexPath.row)) {
            cell.cellImage.image = UIImage(named: "empty2")
            let itemIndex = selectedItems.index(of: indexPath.row)
            selectedItems.remove(at: itemIndex!)
            updateToolbar()
        } else {
            if (selectedItems.count < 5 ) {
                cell.cellImage.image = UIImage(named: "selected")
                if (!selectedItems.contains(indexPath.row)) {selectedItems.append(indexPath.row) }
                updateToolbar()
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    func updateToolbar() {
        toolBarItem.title =  "\(selectedItems.count) of 5 selected"
    }

    // Prepare to move to Movies lists
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showMovies") {
            if let vc = segue.destination as? MoviesTableViewController, let genresList = self.genresList  {
                vc.movieDB = movieDB
                vc.actorsList = selectedItems
                vc.genresList = genresList
                movieDB?.selectedGenres = genresList
                movieDB?.selectedActors = selectedItems
                movieDB?.movieList.removeAll()
                if let currentUser = movieDB?.currentUserSelecting , let usersWhoFinished =  movieDB?.usersWhoFinishedSelection {
                    if (!usersWhoFinished.contains(currentUser)) {
                        movieDB?.usersWhoFinishedSelection.append(currentUser)
                    }
                }
                vc.navigationItem.title = "Select Movies"
            }
        }
    }

   
}
