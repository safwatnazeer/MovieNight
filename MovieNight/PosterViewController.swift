//
//  PosterViewController.swift
//  MovieNight
//
//  Created by Safwat Shenouda on 30/10/2016.
//  Copyright © 2016 Safwat Shenouda. All rights reserved.
//

import UIKit

class PosterViewController: UIViewController {
    
    var movieDBClient : MovieDBClient?
    var movieId:Int = 0
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDBClient?.loadImageList(movieId: movieId) {
            list in
            if list.count > 0 {
                print("image list loaded count = \(list.count) ")
                print("first image path on list = \(list[0]) ")
                self.showImage(imagePath: list[0])
            }
            else {
                print("image list is empty  ")
            }

        }
    }
    
    func showImage(imagePath: String) {
        movieDBClient?.apiClient.downloadLoadImageData(imagePath: imagePath)
        {
            image in
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
