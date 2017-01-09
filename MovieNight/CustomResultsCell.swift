//
//  CustomResultsCell.swift
//  MovieNight
//
//  Created by Safwat Shenouda on 09/01/2017.
//  Copyright © 2017 Safwat Shenouda. All rights reserved.
//

import UIKit

class CustomResultsCell: UITableViewCell {

    @IBOutlet weak var voteButton1: UIButton!
    @IBOutlet weak var voteButton2: UIButton!
    
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBAction func voteButton2(_ sender: Any) {
      print("vote 2 pressed for movie \(cellLabel.text)")
    }
    @IBAction func voteButton1(_ sender: Any) {
        print("vote 2 pressed for movie \(cellLabel.text)")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
