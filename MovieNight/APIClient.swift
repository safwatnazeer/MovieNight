//
//  MovieDB.swift
//  MovieNight
//
//  Created by Safwat Shenouda on 28/10/2016.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import Foundation
import UIKit

class APIClient {
    
    let session: URLSession
    
    init () {
        session = URLSession(configuration: URLSessionConfiguration.default )
        
    }

    
    func downloadJSONNEW(urlString:String, completionHandler: @escaping ([String:AnyObject]) -> Void) {
        
        
        let url = URL(string: urlString)
        let task = session.dataTask(with: url!) { data,response,error in
            
            guard let response = response as? HTTPURLResponse else {
                // Missing HTTP response error
                print("Missing HTTP response")
                return
            }
            
            if  let data = data
            {
                print("Data retuned, trying to convert to json ")
                if response.statusCode == 200 {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                        print("JSON Data successful ..")
                       // print("\(json)")
                        
                        completionHandler(json!)
                    } catch let jsonError {
                        print("Error converting JSON data: \(jsonError)")
                    }
                }
                else {
                    print("Response was not successful . .error code: \(response.statusCode) ")
                }
            }
            else {
                // data is nil
                print("No Data returned")
            }
            
        }
        task.resume()
    }

    // load image 
    func downloadLoadImageData(imagePath:String , completionHandler: @escaping (UIImage)-> Void )
    {
        
        let urlString = "https://image.tmdb.org/t/p/w300\(imagePath)"
        let url = URL(string: urlString)
        let task = session.dataTask(with: url!) { data,response,error in
            
            guard let response = response as? HTTPURLResponse else {
                // Missing HTTP response error
                print("Missing HTTP response")
                return
            }
            
            if  let data = data
            {
               // print("Data retuned, trying to convert to json ")
                if response.statusCode == 200 {
                    
                    if let image = UIImage(data: data) {
                      //  print("Image Data successful ..")
                        completionHandler(image)
                    }
                    else {
                        print("Image conversion failed  ..")
                    }
                    
                    
                }
                else {
                    print("Response was not successful . .error code: \(response.statusCode) ")
                }
            }
            else {
                // data is nil
                print("No Data returned")
            }
            
        }
        task.resume()
    }

}



/*
Query urls:
- search for an actor:
https://api.themoviedb.org/3/search/person?api_key=ae0b9efa77149c7c5c55edae3d42c5a9&language=en-US&query=%22Tom%20Hanks%22

- Get list of movies for a year , but year doesnt work very well
 https://api.themoviedb.org/3/discover/movie?api_key=ae0b9efa77149c7c5c55edae3d42c5a9&year=2001

- Get list of movies for a genre 
 https://api.themoviedb.org/3/discover/movie?api_key=ae0b9efa77149c7c5c55edae3d42c5a9&with_genres=28&page=1

- Get list geners 
 https://api.themoviedb.org/3/genre/movie/list?api_key=ae0b9efa77149c7c5c55edae3d42c5a9&language=en-US

- Get list of images for a movie 
https://api.themoviedb.org/3/movie/188927/images?api_key=ae0b9efa77149c7c5c55edae3d42c5a9
 
- Get list of popular actors
 https://api.themoviedb.org/3/person/popular?api_key=ae0b9efa77149c7c5c55edae3d42c5a9&language=en-US
 
 
 
 
- Get image for a movie based on image url
https://image.tmdb.org/t/p/w300/lQtNOJVScqqYhapr80JYUnChQeg.jpg
 
- Get list of movies for an actor based on person id
 https://api.themoviedb.org/3/person/31/movie_credits?api_key=ae0b9efa77149c7c5c55edae3d42c5a9&language=en-US
 
 - get list of movies for actor and year providing you the actor id
 ----be careful to use primary_release_year instead of year---
 
 https://api.themoviedb.org/3/discover/movie?api_key=ae0b9efa77149c7c5c55edae3d42c5a9&with_cast=31&year=2010
 
 - same but with sort based on poularity
 https://api.themoviedb.org/3/discover/movie?api_key=ae0b9efa77149c7c5c55edae3d42c5a9&with_cast=31&year=2010&sort_by=popularity.desc
 
 - adding genre to discover
 https://api.themoviedb.org/3/discover/movie?api_key=ae0b9efa77149c7c5c55edae3d42c5a9&primary_release_year=2013&sort_by=popularity.desc&with_genres=28
 
 */
