//
//  CustomResultsCell.swift
//  MovieNight
//
//  Created by Safwat Shenouda on 09/01/2017.
//  Copyright © 2017 Safwat Shenouda. All rights reserved.
//

import UIKit

class CustomResultsCell: UITableViewCell {

    // outlets
    @IBOutlet weak var voteButton1: UIButton!
    @IBOutlet weak var voteButton2: UIButton!
    @IBOutlet weak var cellLabel: UILabel!
    
    // vars
    var button1Voted : Bool = false { didSet {updateCellBackground()} }
    var button2Voted : Bool = false { didSet {updateCellBackground()} }
    
    let votedColor = UIColor(red: 46.0/255.0, green: 192.0/255.0, blue: 175.0/255.0, alpha: 1.0)
    let cellAgreedColor = UIColor(red: 175.0/255.0, green: 232.0/255.0, blue: 197.0/255.0, alpha: 1.0)
    
    // Actions
    @IBAction func voteButton2(_ sender: Any) {
      print("vote 2 pressed for movie \(cellLabel.text)")
        button2Voted = !button2Voted
        if (button2Voted)  { voteButton2.backgroundColor = votedColor } else { voteButton2.backgroundColor = UIColor.orange }
       
        
        
    }
    @IBAction func voteButton1(_ sender: Any) {
        print("vote 1 pressed for movie \(cellLabel.text)")
        button1Voted = !button1Voted
        if (button1Voted)  { voteButton1.backgroundColor = votedColor } else { voteButton1.backgroundColor = UIColor.orange }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func markVotes(movieVotes:[MovieVote]) {
        
        for movieVote in movieVotes {
            if (cellLabel.text == movieVote.title) {
                button1Voted = movieVote.vote1
                button2Voted = movieVote.vote2
                if (movieVote.vote1)  { voteButton1.backgroundColor = votedColor } else { voteButton1.backgroundColor = UIColor.orange}
                if (movieVote.vote2)  { voteButton2.backgroundColor = votedColor } else { voteButton2.backgroundColor = UIColor.orange }
            }
        }
        
    }
    
    func initializeCellColors() {
        voteButton1.layer.cornerRadius = 3.0
        voteButton2.layer.cornerRadius = 3.0
        voteButton1.backgroundColor = UIColor.orange
        voteButton2.backgroundColor = UIColor.orange
    }
    
    func updateCellBackground() {
        if (button1Voted && button2Voted) {
            self.backgroundColor = cellAgreedColor
        } else {
            self.backgroundColor = UIColor.white
        }
    }
}
