//
//  ListTableViewController.swift
//  MovieNight
//
//  Created by Safwat Shenouda on 28/10/2016.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import UIKit



class GenresTableViewController: UITableViewController {

    @IBOutlet weak var toolBarItem: UIBarButtonItem!
    
    var stillLoading = false
    
    var selectedItems=[Int]()
    var movieDBClient : MovieDBClient?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup navigation contoller appearence
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        tableView.separatorStyle = .none
        navigationController?.toolbar.barTintColor = UIColor.red
        
        
        updateToolbar()
        
        //// list of genres
        stillLoading = true
        
        movieDBClient?.loadGenreList() {
            DispatchQueue.main.async {
         
            
            self.stillLoading = false
            print("now reload data..")
            self.tableView.reloadData()
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
        
        if (!stillLoading) {
        print ("geners list = \(movieDBClient?.genresList.count)")
            return  movieDBClient!.genresList.count
        } else {
            return 0
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cell for row \(indexPath.row)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        
        cell.cellLabel.text = movieDBClient?.genresList[indexPath.row].name
        // set selection image
        if (selectedItems.contains(indexPath.row)) {
            cell.cellImage.image = UIImage(named: "selected")
        } else {
            cell.cellImage.image = UIImage(named: "empty2")
        }

        
        //cell.contentView.backgroundColor = indexPath.row%2 == 0 ? UIColor.lightGray : UIColor.blue
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomCell
        
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
        print(selectedItems)
        //cell.cellLabel.text = movieDBClient.genresList[indexPath.row].name
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
   
   
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if(segue.identifier == "showActors") {
            if let vc = segue.destination as? ActorsTableViewController {
                movieDBClient?.actorsList.removeAll()
                vc.movieDBClient = movieDBClient
                vc.genresList = selectedItems
                movieDBClient?.selectedGenres = selectedItems
                vc.navigationItem.title = "Select Actors"
            }
    
        }
        
    }
  
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func updateToolbar() {
        toolBarItem.title =  "\(selectedItems.count) of 5 selected"
    }
    
    
}
