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
    var movieList = [Movie]()
    
    var selectedGenres = [Int]()
    var selectedActors = [Int]()
    var usersWhoFinishedSelection = [UsersList]()
    var currentUserSelecting : UsersList = .noOne
    
    
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
    
    func prepareGenresList(listOfIDs:[Int]) ->String {
        var selectedText = ""
        if (listOfIDs.count > 0) {
            selectedText += "&with_genres="
            if (listOfIDs.count > 1)
            {
                for i in 0...listOfIDs.count-2 {
                    selectedText += "\(genresList[listOfIDs[i]].id),"
                }
                selectedText += "\(genresList[listOfIDs[listOfIDs.count-1]].id)"
            }
            else {
                selectedText += "\(genresList[listOfIDs[0]].id)"
            }
        }
        return selectedText
    }
    
    // prepare url elements
    func prepareActorsList(listOfIDs:[Int]) ->String {
        var selectedText = ""
        if (listOfIDs.count > 0) {
            selectedText += "&with_cast="
            if (listOfIDs.count > 1)
            {
                for i in 0...listOfIDs.count-2 {
                    selectedText += "\(actorsList[listOfIDs[i]].id),"
                }
                selectedText += "\(actorsList[listOfIDs[listOfIDs.count-1]].id)"
            }
            else {
                selectedText += "\(actorsList[listOfIDs[0]].id)"
            }
        }
        print(selectedText)
        return selectedText
    }
    
    // load movies for genre
    func loadMovies(for genresIDs:[Int],actorsIDs:[Int] ,pageNumber:Int, completionHandler: @escaping ([Movie],Int)-> Void )
    {
        let selectedGenres   = prepareGenresList(listOfIDs: genresIDs)
        let selectedActors = prepareActorsList(listOfIDs: actorsIDs)
        
        var tempList = [Movie]()
        let urlString = "https://api.themoviedb.org/3/discover/movie?api_key=ae0b9efa77149c7c5c55edae3d42c5a9\(selectedGenres)&page=\(pageNumber)&sort_by=popularity.desc\(selectedActors)"
        
        print(urlString)
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
            var totalPages = 0
            if let pageCount = json["total_pages"] as? Int{
                print ("total pages = \(pageCount)")
                totalPages = pageCount
            }
            print(totalPages)
            completionHandler(tempList,totalPages)
            
        }
    }

}



