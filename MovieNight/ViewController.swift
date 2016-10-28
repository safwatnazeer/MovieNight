//
//  ViewController.swift
//  MovieNight
//
//  Created by Safwat Shenouda on 28/10/2016.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let movieDBClient = MovieDBClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // test call 
        let urlString = "https://api.themoviedb.org/3/movie/550?api_key=ae0b9efa77149c7c5c55edae3d42c5a9"
        movieDBClient.apiClient.downloadJSON(urlString: urlString,
        parse:
            { data in
            
                if let title = data["title"] {
                    print("Title: \(title)")
                }
                if let prodCompanies = data["production_companies"] as? [[String:AnyObject]]{
                    for company in prodCompanies {
                        let companyName = company["name"]!
                        print("Company: \(companyName)")
                    }
                }
        })
        {
            print("first call complete...")
        }
        
    
        //// list of genres
        movieDBClient.LoadGenreList()
           
    }
    
    
   
}

