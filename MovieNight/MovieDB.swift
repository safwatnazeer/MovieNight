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
    func downloadJSON<T>(urlString:String, parse:@escaping ([String:AnyObject])-> T , completionHandler: @escaping (T) -> Void) {
        
        
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
                        print("\(json)")
                        let value = parse(json!)
                        completionHandler(value)
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

    // load image for movie
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
                print("Data retuned, trying to convert to json ")
                if response.statusCode == 200 {
                    
                    if let image = UIImage(data: data) {
                        print("Image Data successful ..")
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
