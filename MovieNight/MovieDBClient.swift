//
//  MovieDBClient.swift
//  MovieNight
//
//  Created by Safwat Shenouda on 28/10/2016.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import Foundation

class MovieDBClient {
    let apiClient = APIClient()
    var genresList = [Genre]()
    
     func LoadGenreList()
     {
        let urlString = "https://api.themoviedb.org/3/genre/movie/list?api_key=ae0b9efa77149c7c5c55edae3d42c5a9&language=en-US"
        apiClient.downloadJSONNEW(urlString: urlString) {
            json in
            
            if let list = json["genres"] as? [[String:AnyObject]] {
                
                for genre in list {
                    if let genreName = genre["name"] as? String ,let id = genre["id"] as? Int {
                        self.genresList.append(Genre(id: id, name: genreName))
                    }
                }
            }
                
                for genre in self.genresList {
                    print("Genre: \(genre.name) , id = \(genre.id) ")
                }
            
        }
    }

}
