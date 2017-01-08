//
//  MovieDBClient.swift
//  MovieNight
//
//  Created by Safwat Shenouda on 28/10/2016.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import Foundation
import UIKit

class MovieDBClient {
    let apiClient = APIClient()
    var genresList = [Genre]()
    var actorsList = [Actor]()
    
    
    // load genres
    func loadGenreList(completionHandler: @escaping ()-> Void)
     {
        let urlString = "https://api.themoviedb.org/3/genre/movie/list?api_key=ae0b9efa77149c7c5c55edae3d42c5a9&language=en-US"
        apiClient.downloadJSONNEW(urlString: urlString) {
            json in
            
            if let list = json["genres"] as? [[String:AnyObject]] {
                
                for genre in list {
                    if let genreName = genre["name"] as? String , let id = genre["id"] as? Int {
                        self.genresList.append(Genre(id: id, name: genreName))
                    }
                }
            }
                
                for genre in self.genresList {
                    print("Genre: \(genre.name) Id= \(genre.id)")
                }
                completionHandler()
        }
    }
    
    func prepareGenresList (genreIDs:[Int]) ->String {
        
        var selectedGenres = ""
        if (genreIDs.count > 1)
        {
            for i in 0...genreIDs.count-2 {
                selectedGenres += "\(genresList[genreIDs[i]].id),"
            }
            selectedGenres += "\(genresList[genreIDs[genreIDs.count-1]].id)"
        }
        else {
            selectedGenres = "\(genresList[genreIDs[0]].id)"
        }
        
       return selectedGenres
    }
    

            // load MovieImages for genre
        func loadImageList(movieId: Int, completionHandler: @escaping ([String])-> Void )
        {
            var imagePathList = [String]()
            let urlString = "https://api.themoviedb.org/3/movie/\(movieId)/images?api_key=ae0b9efa77149c7c5c55edae3d42c5a9"
            apiClient.downloadJSONNEW(urlString: urlString) {
                json in
                
                if let list = json["backdrops"] as? [[String:AnyObject]] {
                    
                    for image in list {
                        if let path = image["file_path"] as? String
                        {
                            
                            imagePathList.append(path)
                            print("Movie backdrop path: \(path) ")
                        }
                    }
                }
                completionHandler(imagePathList)
            }
    }
    
    // Get list of popular actors
    func loadActorsList(pageNumber:Int, completionHandler: @escaping ([Actor])-> Void)
    {
        let urlString = "https://api.themoviedb.org/3/person/popular?api_key=ae0b9efa77149c7c5c55edae3d42c5a9&language=en-US&page=\(pageNumber)"
        
        var tempList = [Actor]()
        apiClient.downloadJSONNEW(urlString: urlString) {
            json in
    
            if let list = json["results"] as? [[String:AnyObject]] {
                
                for actor in list {
                    if let actorName = actor["name"] as? String , let id = actor["id"] as? Int, let profilePath = actor["profile_path"] as? String {
                        tempList.append(Actor(id: id, name: actorName, profilePath:profilePath))
                    }
                }
            }
            
            for actor in self.actorsList {
                print("Actors: \(actor.name) Id= \(actor.id) profile= \(actor.profilePath)")
            }
            completionHandler(tempList)
        }
    }
    // load movies for genre
    func loadMovies(for genreIDs: [Int],pageNumber:Int, completionHandler: @escaping ([Movie])-> Void )
    {
        let selectedGenres = prepareGenresList(genreIDs: genreIDs)
        var tempList = [Movie]()
        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=ae0b9efa77149c7c5c55edae3d42c5a9&with_genres=\(selectedGenres)&page=\(pageNumber)&sort_by=popularity.desc&with_cast=500"
        apiClient.downloadJSONNEW(urlString: urlString) {
            json in
            
            if let list = json["results"] as? [[String:AnyObject]] {
                
                for movie in list {
                    if let movieTitle = movie["title"] as? String , let id = movie["id"] as? Int
                    {
                        let movieToAdd = Movie(id: id, title: movieTitle)
                        tempList.append(movieToAdd)
                        print("Movie: \(movieTitle) ")
                    }
                }
            }
            
            if let pageCount = json["total_pages"] {
                print ("total pages = \(pageCount)")
            }
            completionHandler(tempList)
            
        }
    }

}



