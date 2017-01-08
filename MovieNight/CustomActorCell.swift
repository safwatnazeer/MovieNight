//
//  CustomActorCellTableViewCell.swift
//  MovieNight
//
//  Created by Safwat Shenouda on 08/01/2017.
//  Copyright © 2017 Safwat Shenouda. All rights reserved.
//

import UIKit

class CustomActorCell: UITableViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var actorImage: UIImageView!
    
  //  var cellSelected: Bool = false

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
       
//        self.cellLabel.text = "to be reused !!"
//        self.cellSelected = false
//        self.cellImage.image = UIImage(named: "empty2")
    
    }
}
