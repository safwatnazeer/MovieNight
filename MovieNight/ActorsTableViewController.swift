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
    

    var movieDBClient: MovieDBClient?
    var currentPage:Int = 0
    var stillLoading = false
    var genresList:[Int]?
    var selectedItems=[Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup navigation contoller appearence
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        tableView.separatorStyle = .none
        navigationController?.toolbar.barTintColor = UIColor.red
        
        
        //
        updateToolbar()
        // load actors
        
        loadNextPage()
        
    }
    
    
    func loadNextPage(){
        stillLoading = true
        if let movieDBClient = self.movieDBClient {
            movieDBClient.loadActorsList(pageNumber: currentPage + 1 ) {
                list in
                movieDBClient.actorsList.append(contentsOf: list)
                self.currentPage += 1
                self.stillLoading = false
                DispatchQueue.main.async {
                    // update UI
                    self.tableView.reloadData()
                }
            }
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
        // #warning Incomplete implementation, return the number of rows
        return movieDBClient!.actorsList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomActorCell
        
        // set name
        cell.cellLabel.text = movieDBClient?.actorsList[indexPath.row].name
        // set selection image
        if (selectedItems.contains(indexPath.row)) {
            cell.cellImage.image = UIImage(named: "selected")
        } else {
            cell.cellImage.image = UIImage(named: "empty2")
        }
        
        // get image 
        if let movieDBClient = self.movieDBClient {
            movieDBClient.apiClient.downloadLoadImageData(imagePath: movieDBClient.actorsList[indexPath.row].profilePath) {
                image in
                DispatchQueue.main.async {
                    cell.actorImage.image = image
                    
                }

            }
        
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print ("Will display called for: \(indexPath.row)")
        let diff = movieDBClient!.actorsList.count - (indexPath.row + 1)
        if (diff < 1) {
            print("Loading next page after: \(currentPage)")
            loadNextPage()
        }
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomActorCell
        
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showMovies") {
            if let vc = segue.destination as? MoviesTableViewController, let genresList = self.genresList  {
                vc.movieDBClient = movieDBClient
                vc.actorsList = selectedItems
                vc.genresList = genresList
                movieDBClient?.selectedGenres = genresList
                movieDBClient?.selectedActors = selectedItems
                movieDBClient?.movieList.removeAll()
                if let currentUser = movieDBClient?.currentUserSelecting , let usersWhoFinished =  movieDBClient?.usersWhoFinishedSelection {
                    if (!usersWhoFinished.contains(currentUser)) {
                        movieDBClient?.usersWhoFinishedSelection.append(currentUser)
                    }
                }
                vc.navigationItem.title = "Select Movies"
            }
        }
    }

   
}
